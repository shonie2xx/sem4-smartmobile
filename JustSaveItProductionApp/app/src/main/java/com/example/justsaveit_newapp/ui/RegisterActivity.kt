package com.example.justsaveit_newapp.ui

import android.content.Intent
import android.os.Build
import android.os.Bundle
import android.util.Patterns
import android.widget.Button
import android.widget.Toast
import androidx.annotation.RequiresApi
import androidx.appcompat.app.AppCompatActivity
import com.example.justsaveit_newapp.R
import com.example.justsaveit_newapp.firestore.FireStoreClass
import com.example.justsaveit_newapp.models.Expense
import com.example.justsaveit_newapp.models.ExpenseCategory
import com.example.justsaveit_newapp.models.MonthlyBudget
import com.example.justsaveit_newapp.models.User
import com.google.android.material.textfield.TextInputEditText
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.auth.FirebaseUser
import com.google.firebase.firestore.FirebaseFirestore
import java.time.YearMonth
import java.util.*

class RegisterActivity : AppCompatActivity() {
    private lateinit var auth: FirebaseAuth
    private lateinit var fStore: FirebaseFirestore


    @RequiresApi(Build.VERSION_CODES.O)
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_register)
        auth = FirebaseAuth.getInstance()
        fStore = FirebaseFirestore.getInstance()
        signUp()
        backToLogin()
    }


    @RequiresApi(Build.VERSION_CODES.O)
    private fun signUp(){
        val register: Button = findViewById(R.id.btnRegister)
        val registerEmail : TextInputEditText = findViewById(R.id.tbRegEmail)
        val registerPassword: TextInputEditText = findViewById(R.id.tbRegPassword)
        register.setOnClickListener {
            if(registerEmail.text.toString().isEmpty())
            {
                registerEmail.error = "Please enter email."
                registerEmail.requestFocus()
                return@setOnClickListener
            }
            if(!Patterns.EMAIL_ADDRESS.matcher(registerEmail.text.toString()).matches())
            {
                registerEmail.error = "Please enter valid email."
                registerEmail.requestFocus()
                return@setOnClickListener
            }
            if(registerPassword.text.toString().isEmpty())
            {
                registerPassword.error = "Please enter password."
                registerPassword.requestFocus()
                return@setOnClickListener
            }

            auth.createUserWithEmailAndPassword(registerEmail.text.toString(),
                registerPassword.text.toString()
            )
                .addOnCompleteListener(this) { task ->
                    if (task.isSuccessful) {
                        // Sign in success, update UI with the signed-in user's information
                        val firebaseUser: FirebaseUser = task.result!!.user!!

                        val user = User(
                                firebaseUser.uid,
                                firebaseUser.email!!
                        )

                        val budget = MonthlyBudget(
                            YearMonth.now(),
                            0.0,
                            0.0,
                            0.0
                        )

                        //Default expenses
                        val expenseGroceries = Expense(
                                ExpenseCategory.GROCERIES,
                                0.0
                        )
                        val expenseClothing= Expense(
                                ExpenseCategory.CLOTHING,
                                0.0
                        )
                        val expenseHouse = Expense(
                                ExpenseCategory.HOUSE,
                                0.0
                        )
                        val expensePhone = Expense(
                                ExpenseCategory.PHONE,
                                0.0
                        )
                        val expenseVehicle = Expense(
                                ExpenseCategory.VEHICLE,
                                0.0
                        )

                        FireStoreClass().registerUser(this,user)
                        FireStoreClass().addMonthlyBudget(this,user.id,budget) // CHANGE user-> userid

                        FireStoreClass().addExpense(this,expenseGroceries,user.id,budget)
                        FireStoreClass().addExpense(this,expenseClothing,user.id,budget)
                        FireStoreClass().addExpense(this,expensePhone,user.id,budget)
                        FireStoreClass().addExpense(this,expenseVehicle,user.id,budget)
                        FireStoreClass().addExpense(this,expenseHouse,user.id,budget)

                        startActivity(Intent(this, LoginActivity::class.java))

                    } else {
                        // If sign in fails, display a message to the user.
                        Toast.makeText(baseContext, "Try again",
                            Toast.LENGTH_SHORT).show()
                    }
                }
        }
    }
    private fun backToLogin() {
        val backtoLogin: Button = findViewById(R.id.btnBackToLogin)
        backtoLogin.setOnClickListener{
            startActivity(Intent(this, LoginActivity::class.java))
        }
    }

    fun registerSuccessful(){
        Toast.makeText(baseContext,"Succesfull",Toast.LENGTH_SHORT).show()
    }
    fun registerFailure(){
        Toast.makeText(baseContext,"Failed",Toast.LENGTH_SHORT).show()
    }
}