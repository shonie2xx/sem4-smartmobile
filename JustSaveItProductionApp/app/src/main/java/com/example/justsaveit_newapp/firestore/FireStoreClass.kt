package com.example.justsaveit_newapp.firestore

import com.example.justsaveit_newapp.models.DateMap
import com.example.justsaveit_newapp.models.MonthlyBudget
import com.example.justsaveit_newapp.models.User
import com.example.justsaveit_newapp.ui.AddIncomeActivity
import com.example.justsaveit_newapp.ui.HomePageActivity
import com.example.justsaveit_newapp.ui.RegisterActivity
import com.google.android.gms.tasks.Task
import com.google.firebase.firestore.*
import java.time.YearMonth
import java.util.*

class FireStoreClass {

    private val mFireStore = FirebaseFirestore.getInstance()

    fun registerUser(activity: RegisterActivity,userInfo: User){
        mFireStore.collection("users")
                .document(userInfo.id)
                // set options.merge -> if you want to merge later, if you want to replace a null value or change a current value
                .set(userInfo, SetOptions.merge())
                .addOnSuccessListener{
                    activity.registerSuccessful()
                }
                .addOnFailureListener{
                    activity.registerFailure()
                }
    }

    //if there is no budgets until now
    fun addFirstMonthlyBudget(activity: RegisterActivity, userInfo: User, budget: MonthlyBudget){
        mFireStore.collection("users").document(userInfo.id).collection("monthlybudgets")
                .document(budget.date.toString()).set(budget, SetOptions.merge())
                .addOnSuccessListener{
                    activity.registerSuccessful()
                }
                .addOnFailureListener{
                    activity.registerFailure()
                }
    }

    fun getLastMonthlyBudgetDate(userId: String) : YearMonth?{
//        get last added monthly budget so the new one can be added as new MonthlyBudget ( YearMonth. minusMonths(-1)
        //get list of document snapshots, binary search the highest document.monthYear,
        // return document.monthyear as a YearMonth format

//        var date: Date? = null
//        var dateMaps : ArrayList<DateMap>? = null
//        val docRef = mFireStore.collection("users")
//            .document(userId).collection("monthlybudgets").get()
//
//
//        docRef.addOnSuccessListener {
//            it.documents.forEach { doc ->
//                doc.data
//                doc.data!!.forEach {
//                    if(it.key == "date"){
//                        val map = it.value
//                    }
//                }
//                val dm = it.value.toObject(DateMap::class.java)
//                if (dm != null ) {
//                    if()
//                    dateMaps?.add(dm)
//                }
//
//                //it.toObject(MonthlyBudget::class.java)
////                val dateMapUnit  = it.getData()?.forEach {
////                    if(it.key == "date") {
////                        it.value.
////                        var maps = MutableList<Map<String,Any>>()
////                        maps.add(it.value)
////                    }
////                }
//                }
//                if(dateMaps!= null){
//                    var highestYear = dateMaps[0].year!!.toInt()
//                    var currentYear :Int
//                    for (i in 0 until dateMaps!!.size-1) {
//                        currentYear = dateMaps[i].year!!.toInt()
//                            if(currentYear > highestYear){
//                                highestYear = currentYear
//                            }
//                    }
//                    //highest year found
//                    var highestMonth = dateMaps[0].monthValue!!.toInt()
//                    for (i in 0 until dateMaps!!.size-1) {
//                        currentYear = dateMaps[i].year!!.toInt()
//                        if()
//                    }
//                }
//            }
        return null
        }
            //.orderBy("date", Query.Direction.DESCENDING).limit(1).get()

      /*      sortedQuery.addOnSuccessListener {
                //QuerySnapshot to Documents, get the first doc
                val doc = it.documents[0]
                date = doc.getDate("date")
            }
                sortedQuery.addOnFailureListener {
            }
        return date*/
// citiesRef.orderBy("name", Query.Direction.DESCENDING).limit(3)


    //if there is budgets USE
    fun editMonthlyBudget(activity: AddIncomeActivity, userId:String, monthYear: String,incomeAmount:Double,savings: Double){

        //savings calculation
        val savingsValue = incomeAmount * (savings / 100)

        //get monthly budget doc
        val docRef:DocumentReference = mFireStore.collection("users").document(userId)
            .collection("monthlybudgets")
            .document(monthYear)

        //query update values
        docRef.update("income", FieldValue.increment(incomeAmount),
                "savings",FieldValue.increment(savingsValue))
                .addOnSuccessListener{
            activity.success()
        }
            .addOnFailureListener{
                activity.failure()
            }
    }


    fun getAllMonthlyBudgetName(activity:HomePageActivity,userId: String) : Task<QuerySnapshot> {
        return mFireStore.collection("users").document(userId).collection("monthlybudgets")
            .get()
       }



    fun getBudget(activity: HomePageActivity, userId:String, docId: String) : Task<DocumentSnapshot> {
        return mFireStore.collection("users").document(userId)
                .collection("monthlybudgets")
                .document(docId).get()
    }

    fun getIncome(activity:HomePageActivity,userInfo: User,budget:MonthlyBudget){
        mFireStore.collection("users").document(userInfo.id)
                .collection("monthlybudgets")
                .document(budget.income.toString()).get()
                .addOnSuccessListener{
//                    activity.success()
                }
                .addOnFailureListener{
//                    activity.failure()
                }
    }


}