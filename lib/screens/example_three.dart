import 'package:flutter/material.dart';
import 'dart:math' show pi;

class ExampleThree extends StatefulWidget {
  const ExampleThree({super.key});

  @override
  State<ExampleThree> createState() => _ExampleThreeState();
}

class _ExampleThreeState extends State<ExampleThree>
    with TickerProviderStateMixin {
  late AnimationController _xController;
  late AnimationController _yController;
  late AnimationController _zController;
  late Tween<double> _tween;

  @override
  void initState() {
    super.initState();

    _xController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    );
    _yController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    );
    _zController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 40),
    );

    _tween = Tween<double>(
      begin: 0,
      end: 2 * pi,
    );
  }

  @override
  void dispose() {
    _xController.dispose();
    _yController.dispose();
    _zController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _xController
      ..reset()
      ..repeat();
    _yController
      ..reset()
      ..repeat();
    _zController
      ..reset()
      ..repeat();

    return Scaffold(
      appBar: AppBar(
        title: const FittedBox(
          fit: BoxFit.scaleDown,
          child: Text('3d animation'),
        ),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: Listenable.merge([
            _xController,
            _yController,
            _zController,
          ]),
          builder: (context, child) {
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..rotateX(_tween.evaluate(_xController))
                ..rotateY(_tween.evaluate(_yController))
                ..rotateZ(_tween.evaluate(_zController)),
              child: Stack(
                children: <Widget>[
                  // frot container
                  Container(
                    width: 100,
                    height: 100,
                    color: Colors.red,
                  ),

                  // back container
                  Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.translationValues(0, 0, 100),
                    child: Container(
                      width: 100,
                      height: 100,
                      color: Colors.green,
                    ),
                  ),

                  // right
                  Transform(
                    alignment: Alignment.centerRight,
                    transform: Matrix4.rotationY(pi / 2),
                    child: Container(
                      width: 100,
                      height: 100,
                      color: Colors.yellow,
                    ),
                  ),

                  // left
                  Transform(
                    alignment: Alignment.centerLeft,
                    transform: Matrix4.rotationY(-pi / 2),
                    child: Container(
                      width: 100,
                      height: 100,
                      color: Colors.teal,
                    ),
                  ),

                  //top
                  Transform(
                    alignment: Alignment.topCenter,
                    transform: Matrix4.rotationX(pi / 2),
                    child: Container(
                      width: 100,
                      height: 100,
                      color: Colors.orange,
                    ),
                  ),

                  // bottom
                  Transform(
                    alignment: Alignment.bottomCenter,
                    transform: Matrix4.rotationX(-pi / 2),
                    child: Container(
                      width: 100,
                      height: 100,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
