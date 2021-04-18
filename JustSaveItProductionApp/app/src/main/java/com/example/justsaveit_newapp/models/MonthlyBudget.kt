package com.example.justsaveit_newapp.models

import java.time.YearMonth

class MonthlyBudget(
        var date: YearMonth,
        var balance: Double,
        var income: Double,
        var savings: Double,
        )