import 'package:flutter/material.dart';

class BMIResultPage extends StatelessWidget {
  final int age;
  final String gender;
  final double bmiResult;

  BMIResultPage({
    required this.age,
    required this.gender,
    required this.bmiResult,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Result', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.teal,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Age: $age', style: TextStyle(fontSize: 24)),
            Text('Gender: $gender', style: TextStyle(fontSize: 24)),
            Text(
              'Result: ${bmiResult.toStringAsFixed(1)}',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
