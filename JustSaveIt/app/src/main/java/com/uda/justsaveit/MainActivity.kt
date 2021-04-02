package com.uda.justsaveit

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import com.google.firebase.database.FirebaseDatabase

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        // Testing RealTime DB
        var database = FirebaseDatabase.getInstance().reference
        database.setValue("Data Saved in db")
    }
}