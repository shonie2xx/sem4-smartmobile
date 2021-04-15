//package com.example.justsaveit_newapp.logic
//
//import androidx.lifecycle.ViewModel
//import com.example.justsaveit_newapp.models.MonthlyBudget
//import com.google.firebase.auth.FirebaseAuth
//import com.google.firebase.firestore.FirebaseFirestore
//
//class AddViewModel : ViewModel(){
//
//        private lateinit var monthlyBudget: MonthlyBudget
//
//        val budgets = arrayListOf<MonthlyBudget>()
//
//        private lateinit var auth: FirebaseAuth
//        private lateinit var fStore:FirebaseFirestore
//
//
//        constructor(){
//            fStore = FirebaseFirestore.getInstance()
//            auth = FirebaseAuth.getInstance()
//        }
//
//        //MONTHLYBUDGETSERVICE
//    fun addIncome(amount: Double, date: Date ){
//            // income + amount
////        foreach(MonthlyBudget item in list){
////            if(item.date == date){
////                item.income += amounth;
////            }
////        }
//    }
//
//    fun getAllMonthlyBudgets(){
//        // get all monthly budgets of a user
////        foreach(MonthlyBudget item in budgets) // budgets -> collection in database
////        {
////            if(item.user.uid == user.uid)
////            {
////                return item // LIST
////            }
////        }
//
////        val documentReference: DocumentReference = fStore.collection("users").document(auth.currentUser.uid)
//
//        val docRef = fStore.collection("users").document(auth.currentUser.uid)
//        val budgets = docRef.collection("budgets").get() ?: return
//
//        //this is how we add budget to user
////        fStore.collection("users").document(auth.currentUser.uid).collection("monthlybudgets").add(budget.toJson())
//    }
//
//    //fun getMonthlyBudget(user: FirebaseUser?, month: Date){
//        // get specific user budget
////        List<MonthlyBudget> list = getAllMonthlyBudget(user)
////        foreach(MonthlyBudget item in list)
////        {
////            if(item.byMonth == month)
////            {
////                return item;
////            }
////        }
//
////        val monthlyBudget: getAllMonthlyBudgets()
//
//    //}
//
//
//    fun getIncome()
//    {
//        //get current income
//    }
//
//    fun setMonth(date: Date){
//        //set month
//    }
//
//
//
//
//
//
//
//
////    private val months: MutableLiveData<List<MonthlyBudget>> by lazy{
////        MutableLiveData().also{
////            loadMonths()
////        }
////    }
//
//    private fun loadMonths() {
//
//    }
//
////    val list = arrayListOf<MonthlyBudget>()
////
////    private lateinit var fStore : FirebaseFirestore
////    private lateinit var authuser: FirebaseUser.
////    val user =
//
//
//}