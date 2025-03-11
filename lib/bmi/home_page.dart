import 'package:flutter/material.dart';
import 'bmi_calculator_page.dart';
import 'bmi_result_page.dart';
import 'widgets/gender_card.dart';
import 'widgets/counter_card.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  double height = 180;
  int weight = 60;
  int age = 28;
  String gender = 'MALE';
  double bmiResult = 0;

  void _calculateBMI() {
    setState(() {
      // BMI Formula: weight (kg) / (height (m) * height (m))
      double heightInMeters = height / 100;
      bmiResult = weight / (heightInMeters * heightInMeters);
      _selectedIndex = 1; // Navigate to the result page
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = <Widget>[
      BMICalculatorPage(
        onGenderSelected: (value) {
          setState(() {
            gender = value;
          });
        },
        onHeightChanged: (value) {
          setState(() {
            height = value;
          });
        },
        onWeightChanged: (value) {
          setState(() {
            weight = value;
          });
        },
        onAgeChanged: (value) {
          setState(() {
            age = value;
          });
        },
        onCalculate: _calculateBMI,
        height: height,
        weight: weight,
        age: age,
        selectedGender: gender,
      ),
      BMIResultPage(age: age, gender: gender, bmiResult: bmiResult),
    ];

    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'Calculator',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            label: 'Result',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}
