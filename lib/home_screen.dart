import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int counter = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff85AAA3),
        leading: Icon(Icons.menu),
        title: Text("Hello Ibrahim"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                counter++;
              });
            },
            icon: Icon(Icons.star),
          ),
          IconButton(onPressed: () {}, icon: Text('$counter')),
        ],
      ),
    );
  }
}
