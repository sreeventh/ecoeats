import 'package:ecoeats/View/daymealplan.dart';
import 'package:flutter/material.dart';

class WeakMealPlan extends StatefulWidget {
  final Map weakplan;
  const WeakMealPlan({super.key, required this.weakplan});

  @override
  State<WeakMealPlan> createState() => _WeakMealPlanState();
}

class _WeakMealPlanState extends State<WeakMealPlan> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 7,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(tabs: [
              Tab(text: 'Sun'),
              Tab(text: 'Mon'),
              Tab(text: 'Tue'),
              Tab(text: 'Wed'),
              Tab(text: 'Thu'),
              Tab(text: 'Fri'),
              Tab(text: 'Sat'),
            ]),
          ),
          body: TabBarView(
            children: [
              DayMealPlan(mealPlan: widget.weakplan['Sunday']),
              DayMealPlan(mealPlan: widget.weakplan['Monday']),
              DayMealPlan(mealPlan: widget.weakplan['Tuesday']),
              DayMealPlan(mealPlan: widget.weakplan['Wednesday']),
              DayMealPlan(mealPlan: widget.weakplan['Thursday']),
              DayMealPlan(mealPlan: widget.weakplan['Friday']),
              DayMealPlan(mealPlan: widget.weakplan['Saturday']),
            ],
          ),
        ));
  }
}
