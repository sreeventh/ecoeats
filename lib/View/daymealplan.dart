import 'package:flutter/material.dart';

class DayMealPlan extends StatefulWidget {
  final Map mealPlan;
  const DayMealPlan({super.key, required this.mealPlan});

  @override
  State<StatefulWidget> createState() => _DayMealPlan();
}

class _DayMealPlan extends State<DayMealPlan> {
  String breakfast = '';
  String lunch = '';
  String snacks = '';
  String dinner = '';

  @override
  void initState() {
    super.initState();
    for (var b in widget.mealPlan['Breakfast']) {
      if (breakfast == '') {
        breakfast = b['Meal'].toString();
      } else {
        breakfast = '$breakfast, ${b['Meal']}';
      }
    }
    for (var b in widget.mealPlan['Lunch']) {
      if (lunch == '') {
        lunch = b['Meal'].toString();
      } else {
        lunch = '$lunch, ${b['Meal']}';
      }
    }
    for (var b in widget.mealPlan['Snacks']) {
      if (snacks == '') {
        snacks = b['Meal'].toString();
      } else {
        snacks = '$snacks, ${b['Meal']}';
      }
    }
    for (var b in widget.mealPlan['Dinner']) {
      if (dinner == '') {
        dinner = b['Meal'].toString();
      } else {
        dinner = '$dinner, ${b['Meal']}';
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView(
        shrinkWrap: true,
        children: [
          ListTile(
            title: Text(breakfast),
          ),
          ListTile(
            title: Text(lunch),
          ),
          ListTile(
            title: Text(snacks),
          ),
          ListTile(
            title: Text(dinner),
          ),
        ],
      ),
    );
  }
}
