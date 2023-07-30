import 'package:flutter/material.dart';

class ExampleFive extends StatefulWidget {
  const ExampleFive({super.key});

  @override
  State<ExampleFive> createState() => _ExampleFiveState();
}

class _ExampleFiveState extends State<ExampleFive> {
  bool isBig = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('animated container')),
      body: Center(
        child: GestureDetector(
          onTap: () {
            setState(() {
              isBig = !isBig;
            });
          },
          child: AnimatedContainer(
            width: isBig ? 300 : 120,
            height: isBig ? 300 : 120,
            duration: const Duration(milliseconds: 500),
            curve: Curves.fastOutSlowIn,
            color: Colors.grey,
            child: const Center(
              child: Text('Tap Me'),
            ),
          ),
        ),
      ),
    );
  }
}
