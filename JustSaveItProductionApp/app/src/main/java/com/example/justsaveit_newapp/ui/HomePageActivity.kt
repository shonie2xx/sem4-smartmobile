package com.example.justsaveit_newapp.ui

import android.content.Intent
import android.graphics.Color
import android.os.Build
import android.os.Bundle
import android.util.Log
import android.view.View
import android.widget.*
import androidx.annotation.RequiresApi
import androidx.appcompat.app.AppCompatActivity
import com.example.justsaveit_newapp.R
import com.example.justsaveit_newapp.firestore.FireStoreClass
import com.github.mikephil.charting.charts.PieChart
import com.github.mikephil.charting.data.PieData
import com.github.mikephil.charting.data.PieDataSet
import com.github.mikephil.charting.data.PieEntry
import com.github.mikephil.charting.utils.ColorTemplate
import com.google.android.material.floatingactionbutton.FloatingActionButton
import com.google.firebase.auth.FirebaseAuth

class HomePageActivity : AppCompatActivity() {
    private lateinit var auth: FirebaseAuth
    var selectedDate: String? = null

    private lateinit var incomeFetch: TextView
    private lateinit var savingsFetch: TextView
    private lateinit var balanceFetch: TextView
    private lateinit var clothingExpense: TextView
    private lateinit var houseExpense: TextView
    private lateinit var phoneExpense: TextView
    private lateinit var vehicleExpense: TextView
    private lateinit var groceriesExpense: TextView

    @RequiresApi(Build.VERSION_CODES.O)
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_home_page)
        auth = FirebaseAuth.getInstance()

        incomeFetch = findViewById(R.id.tbIncomeFetch)
        savingsFetch = findViewById(R.id.tbSavingsFetch)
        balanceFetch = findViewById(R.id.tbBalanceFetch)
        clothingExpense = findViewById(R.id.txtClothing)
        houseExpense = findViewById(R.id.txtHouse)
        phoneExpense = findViewById(R.id.txtPhone)
        vehicleExpense = findViewById(R.id.txtVehicle)
        groceriesExpense = findViewById(R.id.txtGrocery)

        spinnerMonthDate()
        addIncome()
        addExpense()

    }

//    @RequiresApi(Build.VERSION_CODES.O)
//    private fun addMonthlyBudget(){
//        val add: FloatingActionButton = findViewById(R.id.btnAddMonth)
//
//        add.setOnClickListener{
//            FireStoreClass().addNextMonthlyBudget(auth.currentUser.uid)
//        }
//    }
    private fun addIncome() {
        val toIncome: FloatingActionButton = findViewById(R.id.btnToIncomePage)

        toIncome.setOnClickListener {
            val intent = Intent(this, AddIncomeActivity::class.java).apply {
                putExtra("year_month", selectedDate)
            }
            startActivity(intent)
        }
    }

    private fun addExpense() {
        val toExpense: FloatingActionButton = findViewById(R.id.btnToExpenseActivity)
        toExpense.setOnClickListener {
            val intent = Intent(this, AddExpenseActivity::class.java).apply {
                putExtra("year_month", selectedDate)
            }
            startActivity(intent)
        }
    }

    private fun spinnerMonthDate() {
        val query = FireStoreClass().getAllMonthlyBudgetName(this, auth.currentUser!!.uid)
        query.addOnSuccessListener() { list ->
            val months = ArrayList<String>()
            for (doc in list)
                months.add(doc.id)

            val spinner: Spinner = findViewById(R.id.spinner)

            val adapter = ArrayAdapter(applicationContext, android.R.layout.simple_spinner_item, months)

            val spinnerResult: TextView = findViewById(R.id.tbSelected)

            adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item)
            spinner.adapter = adapter

            spinner.onItemSelectedListener = object :
                    AdapterView.OnItemSelectedListener {

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

    private fun fetchData() {

        val docRef = FireStoreClass().getBudget(this, auth.currentUser.uid, selectedDate!!)
        docRef.addOnSuccessListener() { document ->
            if (document != null) {
                incomeFetch.text = document.getDouble("income").toString()
                savingsFetch.text = document.getDouble("savings").toString()
                balanceFetch.text = document.getDouble("balance").toString()
            } else {
                Log.d("no exist", "no data")
            }
        }.addOnFailureListener { exception ->
            Log.d("errordb", "fail reading from db", exception)
        }
        val docRef2 = FireStoreClass().getExpenses(AddExpenseActivity(), auth.currentUser.uid, selectedDate!!)
        docRef2.addOnSuccessListener() { document ->
            if (document != null) {
                for (item in document) {
                    if (item.id == "CLOTHING") {
                        clothingExpense.text = item["amount"].toString()
                    }
                    if (item.id == "HOUSE") {
                        houseExpense.text = item["amount"].toString()
                    }
                    if (item.id == "PHONE") {
                        phoneExpense.text = item["amount"].toString()
                    }
                    if (item.id == "VEHICLE") {
                        vehicleExpense.text = item["amount"].toString()
                    }
                    if (item.id == "GROCERIES") {
                        groceriesExpense.text = item["amount"].toString()
                    }
                }
                pieChart()
            } else {
                Log.d("no exist", "no data")
            }

        }.addOnFailureListener { exception ->
            Log.d("errordb", "fail reading from db", exception)
        }
    }

    private fun pieChart(){
        val pieChart = findViewById<PieChart>(R.id.pieChart)
        val spend = ArrayList<PieEntry>()
        Log.d("clothing is : ",clothingExpense.text.toString())
        if(clothingExpense.text != null)
            spend.add(PieEntry(clothingExpense.text.toString().toFloat(), "Clothing"))
        if(houseExpense.text!=null)
            spend.add(PieEntry(houseExpense.text.toString().toFloat(), "House"))
        if(phoneExpense.text!=null)
            spend.add(PieEntry(phoneExpense.text.toString().toFloat(), "Phone"))
        if(vehicleExpense.text!=null)
            spend.add(PieEntry(vehicleExpense.text.toString().toFloat(), "Vehicle"))
        if(groceriesExpense.text!=null)
            spend.add(PieEntry(groceriesExpense.text.toString().toFloat(), "Groceries"))

        val pieDataSet = PieDataSet(spend,"")

        pieDataSet.setColors(*ColorTemplate.COLORFUL_COLORS)
        pieDataSet.valueTextColor = Color.WHITE
        pieDataSet.valueTextSize = 12f

        val pieData = PieData(pieDataSet)

        pieChart.data = pieData
        pieChart.description.isEnabled = false
        pieChart.centerText = "Spends (€)"
        pieChart.setCenterTextColor(Color.DKGRAY)
        pieChart.animate()
    }

    fun success(){
        Toast.makeText(baseContext,"Succesfull", Toast.LENGTH_SHORT).show()
        startActivity(Intent(this, HomePageActivity::class.java))
    }
    fun failure(){
        Toast.makeText(baseContext,"Failed", Toast.LENGTH_SHORT).show()
    }
}

