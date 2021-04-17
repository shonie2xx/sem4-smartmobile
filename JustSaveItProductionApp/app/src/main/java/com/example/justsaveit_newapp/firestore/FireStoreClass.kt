package com.example.justsaveit_newapp.firestore

import android.os.Build
import android.widget.Toast
import androidx.annotation.RequiresApi
import com.example.justsaveit_newapp.models.DateMap
import com.example.justsaveit_newapp.models.Expense
import com.example.justsaveit_newapp.models.MonthlyBudget
import com.example.justsaveit_newapp.models.User
import com.example.justsaveit_newapp.ui.AddExpenseActivity
import com.example.justsaveit_newapp.ui.AddIncomeActivity
import com.example.justsaveit_newapp.ui.HomePageActivity
import com.example.justsaveit_newapp.ui.RegisterActivity
import com.google.android.gms.tasks.Task
import com.google.firebase.firestore.*
import java.text.SimpleDateFormat
import java.time.YearMonth
import java.util.*

@RequiresApi(Build.VERSION_CODES.O)

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
    fun addExpense(activity:RegisterActivity, expense: Expense, userId:String, budgetDate:String){
        mFireStore.collection("users").document(userId).collection("monthlybudgets")
                .document(budgetDate).collection("expenses").document(expense.category.toString())
                .set(expense, SetOptions.merge())
                .addOnSuccessListener{
                    activity.registerSuccessful()
                }
                .addOnFailureListener{
                    activity.registerFailure()
                }
    }

    fun getExpenses(activity:AddExpenseActivity,userId: String,budgetDate: String) : Task<QuerySnapshot> {
        return mFireStore.collection("users").document(userId).collection("monthlybudgets")
            .document(budgetDate).collection("expenses").get()
    }

    fun editExpense(activity: AddExpenseActivity, userId:String, monthYear:String, expenseCategory:String, amount:Double){
        val docRef: DocumentReference = mFireStore.collection("users").document(userId)
                .collection("monthlybudgets").document(monthYear).collection("expenses")
                .document(expenseCategory)

        docRef.update("amount",FieldValue.increment(amount)).addOnSuccessListener{
            activity.success()
        }
                .addOnFailureListener{
                    activity.failure()
                }
    }

    fun getLastMonthlyBudgetDate(userId: String){
//        get last added monthly budget so the new one can be added as new MonthlyBudget ( YearMonth. minusMonths(-1)
        //get list of document snapshots, query the highest document.monthYears then limit to one doc,
        // return document.monthyear as a YearMonth format

        var ym: YearMonth = YearMonth.parse("0000-00")
//        var dateMaps : ArrayList<DateMap>? = null
        val docRef = mFireStore.collection("users")
            .document(userId).collection("monthlybudgets")
            .orderBy("date", Query.Direction.DESCENDING).limit(1).get().addOnSuccessListener {
                val doc = it.documents[0]
                val date = doc.getDate("date")
                val sdf: SimpleDateFormat = SimpleDateFormat("YYYY-MM")
                ym = YearMonth.parse(sdf.format(date))
            }
        return ym
    }

    fun addNewMonthlyBudget(userId: String){
        var lastMonth: YearMonth = getLastMonthlyBudgetDate(userId)
        var newYear = lastMonth.year
        var newMonth = lastMonth.monthValue + 1
        if(newMonth == 13){
            newYear++
            newMonth = 1
        }
        val newYearMonth = YearMonth.parse("${newYear}-${newMonth}")
        val newMonthlyBudget = MonthlyBudget(newYearMonth,0.0,0.0,0.0)
        mFireStore.collection("users")
            .document(userId).collection("monthlybudgets").add(newMonthlyBudget)
        // Need to add expense?
    }

    fun addExpenses(userId: String) {
        //addExpense(this,expenseGroceries,user.id,budget.date.toString())
        //addExpense(this,expenseClothing,user.id,budget.date.toString())
        //addExpense(this,expensePhone,user.id,budget.date.toString())
        //addExpense(this,expenseVehicle,user.id,budget.date.toString())
        //addExpense(this,expenseHouse,user.id,budget.date.toString())
    }

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