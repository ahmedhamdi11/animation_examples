import 'package:animation_test/screens/example_five.dart';
import 'package:animation_test/screens/example_four.dart';
import 'package:animation_test/screens/example_one.dart';
import 'package:animation_test/screens/example_three.dart';
import 'package:animation_test/screens/example_two.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      const ExampleOne(),
      const ExampleTwo(),
      const ExampleThree(),
      const Example4(),
      const ExampleFive(),
    ];
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: screens.length,
        itemBuilder: (context, index) {
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
            child: MaterialButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => screens[index]),
                );
              },
              color: Colors.teal[400],
              height: 50,
              child: Text(
                'example ${index + 1}',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
        },
      ),
    );
  }
}
