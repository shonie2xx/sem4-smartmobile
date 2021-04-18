package com.example.justsaveit_newapp.firestore

import android.os.Build
import androidx.annotation.RequiresApi
import com.example.justsaveit_newapp.models.Expense
import com.example.justsaveit_newapp.models.MonthlyBudget
import com.example.justsaveit_newapp.models.User
import com.example.justsaveit_newapp.ui.AddExpenseActivity
import com.example.justsaveit_newapp.ui.AddIncomeActivity
import com.example.justsaveit_newapp.ui.HomePageActivity
import com.example.justsaveit_newapp.ui.RegisterActivity
import com.google.android.gms.tasks.Task
import com.google.firebase.firestore.*

class FireStoreClass {

    private val mFireStore = FirebaseFirestore.getInstance()


    fun registerUser(activity: RegisterActivity, userInfo: User) {
        mFireStore.collection("users")
                .document(userInfo.id)
                // set options.merge -> if you want to merge later, if you want to replace a null value or change a current value
                .set(userInfo, SetOptions.merge())
                .addOnSuccessListener {
                    activity.registerSuccessful()
                }
                .addOnFailureListener {
                    activity.registerFailure()
                }
    }

    //if there is no budgets until now
    @RequiresApi(Build.VERSION_CODES.O)
    fun addMonthlyBudget(activity: RegisterActivity, userId: String, budget: MonthlyBudget) {

        mFireStore.collection("users").document(userId).collection("monthlybudgets")
                .document(budget.date.toString()).set(budget, SetOptions.merge())
                .addOnSuccessListener {
                    activity.registerSuccessful()
                }
                .addOnFailureListener {
                    activity.registerFailure()
                }
    }

    @RequiresApi(Build.VERSION_CODES.O)
    fun addExpense(activity: RegisterActivity, expense: Expense, userId: String, budget: MonthlyBudget) {
        mFireStore.collection("users").document(userId).collection("monthlybudgets")
                .document(budget.date.toString()).collection("expenses").document(expense.category.toString())
                .set(expense, SetOptions.merge())
                .addOnSuccessListener {
                    activity.registerSuccessful()
                }
                .addOnFailureListener {
                    activity.registerFailure()
                }
    }

    fun getExpenses(activity: AddExpenseActivity, userId: String, budgetDate: String): Task<QuerySnapshot> {
        return mFireStore.collection("users").document(userId).collection("monthlybudgets")
                .document(budgetDate).collection("expenses").get()
    }

    fun editExpense(activity: AddExpenseActivity, userId: String, monthYear: String, expenseCategory: String, amount: Double) {
        val docRef: DocumentReference = mFireStore.collection("users").document(userId)
                .collection("monthlybudgets").document(monthYear).collection("expenses")
                .document(expenseCategory)

        docRef.update("amount",FieldValue.increment(amount)).addOnSuccessListener{
            val updateBalance = mFireStore.collection("users").document(userId)
                    .collection("monthlybudgets").document(monthYear).update("balance", FieldValue.increment(-amount))
                    .addOnSuccessListener {
                        activity.success()
                    }.addOnFailureListener{
                        activity.failure()
                    }
        }
                .addOnFailureListener{
                    activity.failure()
                }

    }

//if there is budgets USE
fun editMonthlyBudget(activity: AddIncomeActivity, userId: String, monthYear: String, incomeAmount: Double, savings: Double)
{

    val savingsValue = incomeAmount * (savings / 100)

    //get monthly budget doc
    val docRef:DocumentReference = mFireStore.collection("users").document(userId)
            .collection("monthlybudgets")
            .document(monthYear)

    //query update values
    docRef.update("income", FieldValue.increment(incomeAmount),
            "savings",FieldValue.increment(savingsValue),
            "balance", FieldValue.increment(incomeAmount-savingsValue))
            .addOnSuccessListener{
                activity.success()
            }
            .addOnFailureListener{
                activity.failure()
            }
}

fun getAllMonthlyBudgetName(activity: HomePageActivity, userId: String): Task<QuerySnapshot> {
    return mFireStore.collection("users").document(userId).collection("monthlybudgets")
            .get()
}

fun getBudget(activity: HomePageActivity, userId: String, docId: String): Task<DocumentSnapshot> {
    return mFireStore.collection("users").document(userId)
            .collection("monthlybudgets")
            .document(docId).get()
}

}

