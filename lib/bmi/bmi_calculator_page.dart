import 'package:app1/bmi/widgets/gender_card.dart';
import 'package:app1/bmi/widgets/counter_card.dart';
import 'package:flutter/material.dart';

class BMICalculatorPage extends StatelessWidget {
  final Function(String) onGenderSelected;
  final Function(double) onHeightChanged;
  final Function(int) onWeightChanged;
  final Function(int) onAgeChanged;
  final VoidCallback onCalculate;
  final double height;
  final int weight;
  final int age;
  final String selectedGender;

  BMICalculatorPage({
    required this.onGenderSelected,
    required this.onHeightChanged,
    required this.onWeightChanged,
    required this.onAgeChanged,
    required this.onCalculate,
    required this.height,
    required this.weight,
    required this.age,
    required this.selectedGender,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI CALCULATOR', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GenderCard(
                  icon: Icons.male,
                  label: 'MALE',
                  isSelected: selectedGender == 'MALE',
                  onTap: () => onGenderSelected('MALE'),
                ),
                GenderCard(
                  icon: Icons.female,
                  label: 'FEMALE',
                  isSelected: selectedGender == 'FEMALE',
                  onTap: () => onGenderSelected('FEMALE'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Column(
              children: [
                Text('HEIGHT', style: TextStyle(color: Colors.grey[800])),
                Text(
                  '${height.toStringAsFixed(0)} cm',
                  style: TextStyle(color: Colors.grey[800], fontSize: 40),
                ),
                Slider(
                  value: height,
                  min: 100,
                  max: 250,
                  onChanged: onHeightChanged,
                  activeColor: Colors.teal,
                  inactiveColor: Colors.grey,
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CounterCard(
                  label: 'WEIGHT',
                  value: weight,
                  onIncrement: () => onWeightChanged(weight + 1),
                  onDecrement: () => onWeightChanged(weight - 1),
                ),
                CounterCard(
                  label: 'AGE',
                  value: age,
                  onIncrement: () => onAgeChanged(age + 1),
                  onDecrement: () => onAgeChanged(age - 1),
                ),
              ],
            ),
            Spacer(),
            ElevatedButton(
              onPressed: onCalculate,
              child: Text('CALCULATE', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
