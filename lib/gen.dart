import 'dart:convert';

import 'package:ecoeats/Model/foodpreference.dart';
import 'package:ecoeats/View/weekmealplan.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Model/user.dart';
import 'ViewModel/sharedpreferences.dart';
import 'api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class GenerateMealPlanPage extends StatefulWidget {
  const GenerateMealPlanPage({super.key});

  @override
  State<GenerateMealPlanPage> createState() => _GenerateMealPlanPageState();
}

class _GenerateMealPlanPageState extends State<GenerateMealPlanPage> {
  // Define the meal preferences and cuisine types.

  List<String> mealPreferences = ['Veg', 'Non-veg'];
  List<String> cuisineTypes = [
    "African",
    "American",
    "Arabian",
    "Argentinian",
    "Armenian",
    "Asian",
    "Australian",
    "Austrian",
    "Baguette",
    "Balinese",
    "Bangladeshi",
    "Barbecue",
    "Basque",
    "Belgian",
    "Bihari",
    "Brazilian",
    "British",
    "Cajun",
    "Cambodian",
    "Canadian",
    "Caribbean",
    "Catalan",
    "Central African",
    "Central American",
    "Central Asian",
    "Chinese",
    "Colombian",
    "Continental",
    "Creole",
    "Croatian",
    "Cuban",
    "Czech",
    "Danish",
    "Deli",
    "Dim sum",
    "Dutch",
    "Eastern European",
    "Ecuadorian",
    "Egyptian",
    "English",
    "Ethiopian",
    "European",
    "Fast food",
    "Filipino",
    "Finnish",
    "French",
    "Fusion",
    "German",
    "Greek",
    "Gujarati",
    "Guatemalan",
    "Hawaiian",
    "Honduran",
    "Hungarian",
    "North Indian",
    "South Indian",
    "Indonesian",
    "International",
    "Irish",
    "Israeli",
    "Italian",
    "Japanese",
    "Korean",
    "Latin American",
    "Lebanese",
    "Malaysian",
    "Mediterranean",
    "Mexican",
    "Middle Eastern",
    "Moroccan",
    "Nepalese",
    "New Zealand",
    "Nicaraguan",
    "Nigerian",
    "North African",
    "North American",
    "Northeastern",
    "Northern European",
    "Norwegian",
    "Oceania",
    "Pakistani",
    "Pan Asian",
    "Pan-Latin",
    "Peruvian",
    "Polish",
    "Portuguese",
    "Puerto Rican",
    "Romanian",
    "Russian",
    "Salvadoran",
    "Scandinavian",
    "Scottish",
    "Seafood",
    "Sichuan",
    "Singaporean",
    "South African",
    "South American",
    "Southeast Asian",
    "Southern",
    "Spanish",
    "Sri Lankan",
    "Steak",
    "Subs",
    "Swedish",
    "Swiss",
    "Syrian",
    "Taiwanese",
    "Thai",
    "Tibetan",
    "Turkish",
    "Ukrainian",
    "Venezuelan",
    "Vietnamese",
    "Western",
    "World"
  ];

  String _response = '';
  String uid = '';
  @override
  void initState() {
    super.initState();
    getuid();
  }

  getuid() async {
    uid = SharedPref.getString('id');
  }

  Future<void> _sendMessage() async {
    // Fetch user details from Firebase

    try {
      DocumentSnapshot<Map<String, dynamic>> userSnapshot = await FirebaseFirestore
          .instance
          .collection('Users')
          .doc(
              uid) // Assuming you have a field with the user's unique ID in the collection
          .get();

      if (userSnapshot.exists) {
        // Extract user-specific details
        final dobString = userSnapshot['dob'] as String;
        final dob = DateTime.parse(dobString);
        final height = double.parse(userSnapshot['height'].toString());
        final weight = double.parse(userSnapshot['weight'].toString());
        final location = userSnapshot['location'] as String?;
        final allergies = userSnapshot['allergies'] as List<dynamic>?;
        final diseases = userSnapshot['diseases'] as List<dynamic>?;

        // Calculate age based on DOB
        final now = DateTime.now();
        final difference = now.difference(dob);
        final age = (difference.inDays / 365).floor();

        // Construct the message based on user details, including allergies and diseases
        final message = "I am $age year old male, with height $height cm, "
            "with weight $weight Kg, residing in $location. "
            "I have the following allergies: ${allergies?.join(', ') ?? 'None'}. "
            "I have the following diseases: ${diseases?.join(', ') ?? 'None'}. "
            "Assume today's date and give me a meal plan with least carbon footprint emissions "
            "coming from the food I consume. Suggest me a plan for one week, I am ${selectedMealPreferences.join(', ')} "
            "having breakfast, lunch, snacks, dinner from the following Cuisine : ${selectedCuisineTypes.join(', ')} "
            "[Make sure to add seasonal & Regional products]. Main goal is to "
            "reduce carbon footprint and to maintain BMI + Calories. give me the results in a json format where keys are name of the day and values are maps whose keys are meals of the day with values having list of meals and their benefits of lower carbon footprint according to that location."
            "The data you provide will directly get stored in database, so strictly give response only in json format, no extra info is needed.";

        // Call the function to generate a chat completion
        final apiResponse = await generateChatCompletion(message);

        setState(() {
          _response = apiResponse['choices'][0]['text'].trim();
        });
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  WeakMealPlan(weakplan: json.decode(_response)),
            ));
      } else {
        print('User details not found.');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  // Define the selected meal preferences and cuisine types.
  List<String> selectedMealPreferences = [];
  List<String> selectedCuisineTypes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generate Weekly Meal Plan'),
      ),
      body: ListView(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Meal preferences
          const Text('Meal preferences:'),
          CheckboxListTile(
            title: const Text('Veg'),
            value: selectedMealPreferences.contains('Veg'),
            onChanged: (value) {
              setState(() {
                if (value!) {
                  selectedMealPreferences.add('Veg');
                } else {
                  selectedMealPreferences.remove('Veg');
                }
              });
            },
          ),
          CheckboxListTile(
            title: const Text('Non-veg'),
            value: selectedMealPreferences.contains('Non-veg'),
            onChanged: (value) {
              setState(() {
                if (value!) {
                  selectedMealPreferences.add('Non-veg');
                } else {
                  selectedMealPreferences.remove('Non-veg');
                }
              });
            },
          ),

          // Cuisine types
          const Text('Cuisine types:'),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: cuisineTypes.length,
            itemBuilder: (context, index) => CheckboxListTile(
              title: Text(cuisineTypes[index]),
              value: selectedCuisineTypes.contains(cuisineTypes[index]),
              onChanged: (value) {
                setState(() {
                  if (value!) {
                    selectedCuisineTypes.add(cuisineTypes[index]);
                  } else {
                    selectedCuisineTypes.remove(cuisineTypes[index]);
                  }
                });
              },
            ),
          ),
          // Generate button
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () async {
              _sendMessage();
            },
            child: const Text('Generate Weekly Meal Plan'),
          ),
          Text(_response)
        ],
      ),
    );
  }
}
