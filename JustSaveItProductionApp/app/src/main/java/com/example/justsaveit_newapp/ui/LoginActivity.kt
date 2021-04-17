package com.example.justsaveit_newapp.ui

import android.content.Intent
import android.os.Bundle
import android.util.Patterns
import android.widget.Button
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import com.example.justsaveit_newapp.R
import com.google.android.material.textfield.TextInputEditText
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.auth.FirebaseUser

class LoginActivity : AppCompatActivity() {
    private lateinit var auth: FirebaseAuth

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        auth = FirebaseAuth.getInstance()

        val register: Button = findViewById(R.id.btnCreateAcc)
        register.setOnClickListener(){
            startActivity(Intent(this, RegisterActivity::class.java))
            finish()
        }
        login()
    }

    private fun login() {
        val login: Button = findViewById(R.id.btnLogin)
        val loginEmail : TextInputEditText = findViewById(R.id.tbLoginEmail)
        val loginPassword: TextInputEditText = findViewById(R.id.tbLoginPassword)

        //validation
        login.setOnClickListener(){
            if(loginEmail.text.toString().isEmpty())
            {
                loginEmail.error = "Please enter email."
                loginEmail.requestFocus()
                return@setOnClickListener
            }
            if(!Patterns.EMAIL_ADDRESS.matcher(loginEmail.text.toString()).matches())
            {
                loginEmail.error = "Please enter valid email."
                loginEmail.requestFocus()
                return@setOnClickListener
            }
            if(loginPassword.text.toString().isEmpty())
            {
                loginPassword.error = "Please enter password."
                loginPassword.requestFocus()
                return@setOnClickListener
            }

            //sign in
            auth.signInWithEmailAndPassword(loginEmail.text.toString(), loginPassword.text.toString())
                .addOnCompleteListener(this) { task ->
                    if (task.isSuccessful) {
                        val user: FirebaseUser? = auth.currentUser
                        updateUI(user)
                    } else {
                        updateUI(null)
                    }
                }
        }
    }

    private fun updateUI(currentUser : FirebaseUser?){
        if(currentUser != null)
        {
            startActivity(Intent(this, HomePageActivity::class.java))
            finish()
        }
        else{
            Toast.makeText(baseContext,"Login failed", Toast.LENGTH_SHORT).show()
        }
    }
}