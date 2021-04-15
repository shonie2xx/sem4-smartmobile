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

class HomePageActivity : AppCompatActivity() {

   private lateinit var auth: FirebaseAuth
    var selectedDate: String? = null
//   var spinnerResult: TextView = findViewById(R.id.tbSelected)

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_home_page)
        auth = FirebaseAuth.getInstance()
        spinner()
        addIncome()

    }

    private fun addIncome(){
        val toIncome: Button = findViewById(R.id.btnToIncomePage)
        val textViewContent: TextView = findViewById(R.id.tbSelected)
        toIncome.setOnClickListener{
            val intent = Intent(this, AddIncomeActivity::class.java).apply{
                putExtra("year_month",textViewContent.text)
            }
            startActivity(intent)
        }
    }

    private fun spinner(){
        val query = FireStoreClass().getAllMonthlyBudgetName(this,auth.currentUser!!.uid)
        query.addOnSuccessListener() { list->
            val months = ArrayList<String>()
            for(doc in list)
                months.add(doc.id)

            val spinner: Spinner = findViewById(R.id.spinner)

            val adapter = ArrayAdapter(applicationContext,android.R.layout.simple_spinner_item,months)

            val spinnerResult: TextView = findViewById(R.id.tbSelected)

            adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item)
            spinner.adapter = adapter

            spinner.onItemSelectedListener = object:
                AdapterView.OnItemSelectedListener{

                override fun onNothingSelected(parent: AdapterView<*>?) {
                    spinnerResult.text = "nothing selected"
                }
                override fun onItemSelected(
                    parent: AdapterView<*>,
                    view: View?,
                    position: Int,
                    id: Long
                ) {
                    spinnerResult.text = parent.getItemAtPosition(position).toString()
                    selectedDate = spinnerResult.text.toString()
                    fetchData()
                }
            }
        }

    }

    private fun fetchData(){
        val incomeFetch: TextView = findViewById(R.id.tbIncomeFetch)
        val savingsFetch: TextView = findViewById(R.id.tbSavingsFetch)
        val balanceFetch: TextView = findViewById(R.id.tbBalanceFetch)

        val docRef = FireStoreClass().getBudget(this,auth.currentUser.uid,selectedDate!!)
        docRef.addOnSuccessListener(){ document ->
            if(document != null){
                incomeFetch.text = document.getDouble("income").toString()
                savingsFetch.text = document.getDouble("savings").toString()
                balanceFetch.text = document.getDouble("balance").toString()
            }
            else{
                Log.d("no exist", "no data")
            }
        }.addOnFailureListener{ exception ->
            Log.d("errordb", "fail reading from db", exception)
        }
    }

//    private fun getmonthDate(monthlybudgetsList: List<MonthlyBudget>): List<String> {
//        val result = ArrayList<String>()
//
//        for (item in monthlybudgetsList){
//            result.add(item.date.toString())
//        }
//        return result
//    }



//    fun fetchBudget(user: FirebaseUser)
//    {
//        // call viewmodelUSER
//        userService.getMonthlyBudget(user)
//    }
//fetching data??


//    fun exercise() {
//        val month: TextView = findViewById(R.id.textView4)
//
////        val current_month = HomePageActivity?.getPreferences(Context.MODE_PRIVATE) ?: returnwith (current_month.edit()) {
////            putString(getString(R.string.current_month), LocalDate.now().month)    apply()
//    }
//
//    fun addIncome(string: Text) {
//        //get the stuff from textbox
//
//        //setonclicklistener (add value from tb to db)
//
//        //default value
//    }
//
//    fun getIncome(time: LocalDateTime, currentUser: FirebaseUser) {
//
//    }
//
//    fun getTime()
//    {
//
//    }
//
//    fun tbCurrentMonth(){
//        //default value = Localdate.currentMonth
//
//        //current user, we get the months as a list
//
//        //dropdown menu with all months of the year consisting some income, expenses
//
//    }
}
