package com.uda.justsaveit;

import android.graphics.Color;
import android.os.Bundle;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;

import com.github.mikephil.charting.charts.PieChart;
import com.github.mikephil.charting.data.PieData;
import com.github.mikephil.charting.data.PieDataSet;
import com.github.mikephil.charting.data.PieEntry;
import com.github.mikephil.charting.utils.ColorTemplate;
import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.ValueEventListener;

import java.util.ArrayList;

public class HomeActivity extends AppCompatActivity {
    TextView textBalance;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_home);
        // Back Button on ActionBar
        getSupportActionBar().setDisplayHomeAsUpEnabled(true);

        TextView txtCloth = findViewById(R.id.txtClothing);
        txtCloth.setText("100");
        String str1 = txtCloth.getText().toString();
        float amount1 = Float.parseFloat(str1);

        TextView txtHouse = findViewById(R.id.txtHouse);
        txtHouse.setText("250");
        String str2 = txtHouse.getText().toString();
        float amount2 = Float.parseFloat(str2);

        TextView txtPhone = findViewById(R.id.txtPhone);
        txtPhone.setText("50");
        String str3 = txtPhone.getText().toString();
        float amount3 = Float.parseFloat(str3);

        TextView txtVehicle = findViewById(R.id.txtVehicle);
        txtVehicle.setText("200");
        String str4 = txtVehicle.getText().toString();
        float amount4 = Float.parseFloat(str4);

        TextView txtGrocery = findViewById(R.id.txtGrocery);
        txtGrocery.setText("50");
        String str5 = txtGrocery.getText().toString();
        float amount5 = Float.parseFloat(str5);

        // PieChart
        PieChart pieChart = findViewById(R.id.pieChart);
        ArrayList<PieEntry> spend = new ArrayList<>();

        spend.add(new PieEntry(amount1, "Clothing"));
        spend.add(new PieEntry(amount2, "House"));
        spend.add(new PieEntry(amount3, "Phone"));
        spend.add(new PieEntry(amount4, "Vehicle"));
        spend.add(new PieEntry(amount5, "Groceries"));

        PieDataSet pieDataSet = new PieDataSet(spend, "Total Spending: 650 €");
        pieDataSet.setColors(ColorTemplate.COLORFUL_COLORS);
        pieDataSet.setValueTextColor(Color.WHITE);
        pieDataSet.setValueTextSize(12f);

        PieData pieData = new PieData(pieDataSet);

        pieChart.setData(pieData);
        pieChart.getDescription().setEnabled(false);
        pieChart.setCenterText("Spends (€)");
        pieChart.setCenterTextColor(Color.DKGRAY);
        pieChart.animate();

        textBalance = findViewById(R.id.txtBalance);

        // Making Reference to the db
        FirebaseDatabase database = FirebaseDatabase.getInstance();
        DatabaseReference reference = database.getReference("Data Saved in db");

        // Read Data from db
        reference = FirebaseDatabase.getInstance().getReference().child("Users").child("YrPyUQxrOSk5rm17LwFD").child("months").child("bNUPKIGZo8oYIXyvyJ2H");
        reference.addValueEventListener(new ValueEventListener() {
            @Override
            public void onDataChange(@NonNull DataSnapshot snapshot) {
                String s = (String) snapshot.getValue();
                textBalance.setText("Balance: " + s);
            }

            @Override
            public void onCancelled(@NonNull DatabaseError error) {

            }
        });
    }

}