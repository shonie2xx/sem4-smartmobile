package com.example.justsaveit_newapp.ui

import android.content.Intent
import android.os.Bundle
import android.view.View
import android.widget.*
import androidx.appcompat.app.AppCompatActivity
import com.example.justsaveit_newapp.R
import com.example.justsaveit_newapp.firestore.FireStoreClass
import com.google.firebase.auth.FirebaseAuth

class AddExpenseActivity : AppCompatActivity() {
    private lateinit var auth: FirebaseAuth
    var yearMonth: String? = null
    var categorySelected: String? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_add_expense)
        auth = FirebaseAuth.getInstance()
        yearMonth = intent.getStringExtra("year_month")

        spinnerExpenseCategories()
        addAmount()
    }

    //edit box to Double
    private fun EditText.getDouble(): Double = try {
        text.toString().toDouble()
    } catch (e: NumberFormatException) {
        e.printStackTrace()
        0.0
    }

    private fun addAmount(){
        val btnAdd : Button = findViewById(R.id.btnAddExpenseAmount)
        btnAdd.setOnClickListener{
            val amountBox: EditText = findViewById(R.id.expenseAmount)

            val amount = amountBox.getDouble()
            FireStoreClass().editExpense(this,auth.currentUser.uid,yearMonth.toString(),categorySelected.toString(),amount)
    }
    }

    private fun spinnerExpenseCategories(){
        yearMonth?.let { FireStoreClass().getExpenses( this,auth.currentUser.uid, it) }
            ?.addOnSuccessListener (){ list->
                val categories = ArrayList<String>()
                for(item in list)
                    categories.add(item.id)

                val spinner: Spinner = findViewById(R.id.spinnerExpenseCategory)

                val adapter = ArrayAdapter(applicationContext,android.R.layout.simple_spinner_item,categories)

                adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item)
                spinner.adapter = adapter

                spinner.onItemSelectedListener = object:
                    AdapterView.OnItemSelectedListener{

                    override fun onNothingSelected(parent: AdapterView<*>?) {
                        //todo
                    }
                    override fun onItemSelected(
                        parent: AdapterView<*>,
                        view: View?,
                        position: Int,
                        id: Long
                    ) {
                        categorySelected = parent.getItemAtPosition(position).toString()
                        Toast.makeText(applicationContext,"you selected : $categorySelected",Toast.LENGTH_SHORT).show()
                    }
                }
        }
    }

    fun success(){
        Toast.makeText(baseContext,"Successful", Toast.LENGTH_SHORT).show()
        startActivity(Intent(this, HomePageActivity::class.java))
    }
    fun failure(){
        Toast.makeText(baseContext,"Failed", Toast.LENGTH_SHORT).show()
    }

}
