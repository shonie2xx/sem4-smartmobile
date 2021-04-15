package com.example.justsaveit_newapp.ui

import android.content.Intent
import android.os.Bundle
import android.util.Log
import android.view.View
import android.widget.*
import androidx.appcompat.app.AppCompatActivity
import com.example.justsaveit_newapp.R
import com.example.justsaveit_newapp.firestore.FireStoreClass
import com.google.firebase.auth.FirebaseAuth

class AddIncomeActivity : AppCompatActivity() {
    private lateinit var auth: FirebaseAuth
    var yearMonth: String? = null
    var savings: Double? = null
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_add_income)
        auth = FirebaseAuth.getInstance()

        yearMonth = intent.getStringExtra("year_month")
        val yearMonthtb: TextView = findViewById(R.id.tbYearMonth)
        yearMonthtb.text = yearMonth

        add()

        savingsSpinner()
    }

    //edit box to Double
    fun EditText.getDouble(): Double = try {
        text.toString().toDouble()
    } catch (e: NumberFormatException) {
        e.printStackTrace()
        0.0
    }

    private fun savingsSpinner() {
        val savSpinner: Spinner = findViewById(R.id.savingsSpinner)

        savSpinner.onItemSelectedListener = object : AdapterView.OnItemSelectedListener {
            override fun onItemSelected(parent: AdapterView<*>?, view: View?, position: Int, id: Long) {
                val percentageAmount = parent?.getItemAtPosition(position).toString().toDouble()
                savings = percentageAmount

            }

            override fun onNothingSelected(parent: AdapterView<*>?) {
            }
        }
    }
    //add income
    private fun add(){
         val btnAdd : Button = findViewById(R.id.btnAdd)
        btnAdd.setOnClickListener{
            val amountBox: EditText = findViewById(R.id.tbAmount)

            val amount = amountBox.getDouble()
            Log.d("SAVINGS",savings.toString())
            Log.d("year_month::",yearMonth.toString())
            savings?.let { it1 -> FireStoreClass().editMonthlyBudget(this,auth.currentUser!!.uid,yearMonth!!,amount, it1) }
        }
    }




    fun success(){
        Toast.makeText(baseContext,"Succesfull", Toast.LENGTH_SHORT).show()
        startActivity(Intent(this, HomePageActivity::class.java))
    }
    fun failure(){
        Toast.makeText(baseContext,"Failed",Toast.LENGTH_SHORT).show()
    }
}



