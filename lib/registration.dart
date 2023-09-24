import 'package:ecoeats/Home.dart';
import 'package:ecoeats/Model/foodpreference.dart';
import 'package:ecoeats/Model/user.dart';
import 'package:ecoeats/ViewModel/firebasehelper.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

import 'ViewModel/sharedpreferences.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _usernameController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  final _caloriesController = TextEditingController();
  final _dobController = TextEditingController();
  final _locationController = TextEditingController();
  final _selectedState = TextEditingController();
  final _selectedCountry = TextEditingController();

  bool _isDiabetic = false;
  bool _hasHighBP = false;
  bool _hasCholesterol = false;

  List<TextEditingController> _allergyControllers = [];
  List _allergies = [];
  List _diseases = [];

  void _addAllergyField() {
    setState(() {
      TextEditingController controller = TextEditingController();
      _allergyControllers.add(controller);
    });
  }

  @override
  void dispose() {
    // Dispose the controllers to avoid memory leaks
    for (var controller in _allergyControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        _dobController.text =
            picked.toLocal().toString().split(' ')[0]; // Format: yyyy-MM-dd
      });
    }
  }

  Future<void> _register() async {
    for (var x in _allergyControllers) {
      _allergies.add(x.text);
    }
    if (_isDiabetic) {
      _diseases.add('Diabetes');
    }
    if (_hasCholesterol) {
      _diseases.add('Cholestrol');
    }
    if (_hasHighBP) {
      _diseases.add('High Blood Pressure');
    }
    String email = SharedPref.getString('email');
    String password = SharedPref.getString('password');
    try {
      String id = await FireBaseHelper.insertUser(User(
        userName: _usernameController.text,
        password: password,
        mailId: email,
        dob: _dobController.text,
        location: '${_selectedState.text}, ${_selectedCountry.text}',
        height: double.parse(_heightController.text),
        weight: double.parse(_weightController.text),
        caloriesRequired: double.parse(_caloriesController.text),
        diseases: _diseases,
        allergies: _allergies,
        foodPreference: FoodPreference(
            cuisines: [], isVegan: false, planOption: '', beverages: []),
        kitchenItems: [],
      ));
      SharedPref.setString('id', id);
      // Navigate to the next page after registration
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } catch (e) {
      // print('Error registering user: $e');
    }
  }

  void _removeAllergyField(int index) {
    setState(() {
      _allergyControllers.removeAt(index);
    });

    Future<void> _selectLocation(BuildContext context) async {
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: ListView(
            shrinkWrap: true,
            //mainAxisSize: MainAxisSize.min,
            // children: [
            //   DropdownButton<String>(
            //     value: _selectedCountry,
            //     items: _countries.map((String country) {
            //       return DropdownMenuItem<String>(
            //         value: country,
            //         child: Text(country),
            //       );
            //     }).toList(),
            //     onChanged: (String? newValue) {
            //       setState(() {
            //         _selectedCountry = newValue!;
            //         // Reset state when country changes
            //       });
            //     },
            //   ),

            // DropdownButton<String>(
            //   value: _selectedState,
            //   items: _states.map((String state) {
            //     return DropdownMenuItem<String>(
            //       value: state,
            //       child: Text(state),
            //     );
            //   }).toList(),
            //   onChanged: (String? newValue) {
            //     setState(() {
            //       _selectedState = newValue!;
            //     });
            //   },
            // ),
            //],
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  _locationController.text =
                      '$_selectedState, $_selectedCountry';
                });
              },
              child: const Text('Select'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration Page'),
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: 'Username'),
              ),
              TextField(
                controller: _heightController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Height'),
              ),
              TextField(
                controller: _weightController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Weight'),
              ),
              TextField(
                controller: _caloriesController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    labelText: 'Calories Required Per Day'),
              ),
              TextField(
                controller: _dobController,
                decoration: const InputDecoration(labelText: 'Date of Birth'),
                readOnly: true, // Set the text field as read-only
                onTap: () =>
                    _selectDate(context), // Open the date picker on tap
              ),
              TextField(
                controller: _selectedState,
                decoration: const InputDecoration(labelText: 'States'),
              ),
              TextField(
                controller: _selectedCountry,
                decoration: const InputDecoration(labelText: 'Countries'),
              ),
              const Text(
                'Diseases',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              CheckboxListTile(
                title: const Text('Diabetic'),
                value: _isDiabetic,
                onChanged: (bool? value) {
                  setState(() {
                    _isDiabetic = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('High Blood Pressure'),
                value: _hasHighBP,
                onChanged: (bool? value) {
                  setState(() {
                    _hasHighBP = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('Cholesterol'),
                value: _hasCholesterol,
                onChanged: (bool? value) {
                  setState(() {
                    _hasCholesterol = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('None of the above'),
                value: !_isDiabetic && !_hasHighBP && !_hasCholesterol,
                onChanged: (bool? value) {
                  setState(() {
                    _isDiabetic = false;
                    _hasHighBP = false;
                    _hasCholesterol = false;
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _allergyControllers.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: TextField(
                      controller: _allergyControllers[index],
                      decoration: InputDecoration(
                        labelText: 'Allergy ${index + 1}',
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            setState(() {
                              _removeAllergyField(index);
                              //_allergyControllers.removeAt(index);
                            });
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addAllergyField,
                child: const Text('Add Allergy'),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _register,
                child: const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


//String? _selectedCountry;
  //List<String> _countries = ['A', 'B', 'C'];
  // List<String> _countries = [
  //   "Afghanistan",
  //   "Albania",
  //   "Algeria",
  //   "Andorra",
  //   "Angola",
  //   "Argentina",
  //   "Armenia",
  //   "Australia",
  //   "Austria",
  //   "Azerbaijan",
  //   "Bahamas",
  //   "Bahrain",
  //   "Bangladesh",
  //   "Barbados",
  //   "Belarus",
  //   "Belgium",
  //   "Belize",
  //   "Benin",
  //   "Bhutan",
  //   "Bolivia",
  //   "Botswana",
  //   "Brazil",
  //   "Brunei",
  //   "Bulgaria",
  //   "Burkina Faso",
  //   "Burundi",
  //   "Cabo Verde",
  //   "Cambodia",
  //   "Cameroon",
  //   "Canada",
  //   "Central African ",
  //   "Chad",
  //   "Chile",
  //   "China",
  //   "Colombia",
  //   "Comoros",
  //   "Costa Rica",
  //   "Croatia",
  //   "Cuba",
  //   "Cyprus",
  //   "Denmark",
  //   "Djibouti",
  //   "Dominica",
  //   "Dominican Republic",
  //   "Ecuador",
  //   "Egypt",
  //   "El Salvador",
  //   "Equatorial Guinea",
  //   "Eritrea",
  //   "Estonia",
  //   "Ethiopia",
  //   "Fiji",
  //   "Finland",
  //   "France",
  //   "Gabon",
  //   "Gambia",
  //   "Georgia",
  //   "Germany",
  //   "Ghana",
  //   "Greece",
  //   "Grenada",
  //   "Guatemala",
  //   "Guinea",
  //   "Guinea-Bissau",
  //   "Guyana",
  //   "Haiti",
  //   "Holy See",
  //   "Honduras",
  //   "Hungary",
  //   "Iceland",
  //   "India",
  //   "Indonesia",
  //   "Iran",
  //   "Iraq",
  //   "Ireland",
  //   "Israel",
  //   "Italy",
  //   "Jamaica",
  //   "Japan",
  //   "Jordan",
  //   "Kazakhstan",
  //   "Kenya",
  //   "Kiribati",
  //   "Kuwait",
  //   "Kyrgyzstan",
  //   "Laos",
  //   "Latvia",
  //   "Lebanon",
  //   "Lesotho",
  //   "Liberia",
  //   "Libya",
  //   "Liechtenstein",
  //   "Lithuania",
  //   "Luxembourg",
  //   "Madagascar",
  //   "Malawi",
  //   "Malaysia",
  //   "Maldives",
  //   "Mali",
  //   "Malta",
  //   "Marshall Islands",
  //   "Mauritania",
  //   "Mauritius",
  //   "Mexico",
  //   "Micronesia",
  //   "Moldova",
  //   "Monaco",
  //   "Mongolia",
  //   "Montenegro",
  //   "Morocco",
  //   "Mozambique",
  //   "Namibia",
  //   "Nauru",
  //   "Nepal",
  //   "Netherlands",
  //   "New Zealand",
  //   "Nicaragua",
  //   "Niger",
  //   "Nigeria",
  //   "North Korea",
  //   "Norway",
  //   "Oman",
  //   "Pakistan",
  //   "Palau",
  //   "Palestine State",
  //   "Panama",
  //   "Papua New Guinea",
  //   "Paraguay",
  //   "Peru",
  //   "Philippines",
  //   "Poland",
  //   "Portugal",
  //   "Qatar",
  //   "Romania",
  //   "Russia",
  //   "Rwanda",
  //   "Saint Lucia",
  //   "Samoa",
  //   "San Marino",
  //   "Saudi Arabia",
  //   "Senegal",
  //   "Serbia",
  //   "Seychelles",
  //   "Sierra Leone",
  //   "Singapore",
  //   "Slovakia",
  //   "Slovenia",
  //   "Somalia",
  //   "South Africa",
  //   "South Korea",
  //   "South Sudan",
  //   "Spain",
  //   "Sri Lanka",
  //   "Sudan",
  //   "Suriname",
  //   "Sweden",
  //   "Switzerland",
  //   "Syria",
  //   "Tajikistan",
  //   "Tanzania",
  //   "Thailand",
  //   "Timor-Leste",
  //   "Togo",
  //   "Tonga",
  //   "Tunisia",
  //   "Turkey",
  //   "Turkmenistan",
  //   "Tuvalu",
  //   "Uganda",
  //   "Ukraine",
  //   "United Kingdom",
  //   "USA",
  //   "Uruguay",
  //   "Uzbekistan",
  //   "Vanuatu",
  //   "Venezuela",
  //   "Vietnam",
  //   "Yemen",
  //   "Zambia",
  //   "Zimbabwe"
  // ];
  //List<String> _states = [];