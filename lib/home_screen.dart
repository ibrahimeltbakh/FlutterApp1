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
        backgroundColor: Color.fromARGB(255, 32, 228, 192),

        leading: Icon(Icons.menu, color: Colors.white),
        title: Text("Hello Ibrahim", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                counter++;
              });
            },
            icon: Icon(Icons.star, color: Colors.white),
          ),
          IconButton(
            onPressed: () {},
            icon: Text('$counter', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),

      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.teal,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.red,
                child: Center(child: Text("one")),
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 100,
                        height: 50,
                        color: Colors.yellow,
                        child: Center(child: Text("two")),
                      ),
                      Container(
                        width: 100,
                        height: 50,
                        color: Colors.green,
                        child: Center(child: Text("three")),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.blue,
                child: Center(child: Text("four")),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
