import 'package:flutter/material.dart';
import 'dart:math' show pi;

class ExampleTwo extends StatefulWidget {
  const ExampleTwo({super.key});

  @override
  State<ExampleTwo> createState() => _ExampleTwoState();
}

class _ExampleTwoState extends State<ExampleTwo> with TickerProviderStateMixin {
  late AnimationController _rotateController;
  late Animation<double> _rotateAnimation;

  late AnimationController _flipController;
  late Animation<double> _flipAnimation;

  @override
  void initState() {
    super.initState();

    // rotate animation
    _rotateController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _rotateAnimation = Tween<double>(begin: 0, end: -pi / 2).animate(
      CurvedAnimation(
        parent: _rotateController,
        curve: Curves.bounceOut,
      ),
    );

    // flip animation
    _flipController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _flipAnimation = Tween<double>(begin: 0, end: pi).animate(
      CurvedAnimation(
        parent: _flipController,
        curve: Curves.bounceOut,
      ),
    );

    // status listeners
    _rotateController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _flipAnimation = Tween<double>(
          begin: _flipAnimation.value,
          end: _flipAnimation.value + pi,
        ).animate(
          CurvedAnimation(
            parent: _flipController,
            curve: Curves.bounceOut,
          ),
        );

        _flipController
          ..reset()
          ..forward();
      }
    });

    _flipController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _rotateAnimation = Tween<double>(
          begin: _rotateAnimation.value,
          end: _rotateAnimation.value - pi / 2,
        ).animate(
          CurvedAnimation(
            parent: _rotateController,
            curve: Curves.bounceOut,
          ),
        );

        _rotateController
          ..reset()
          ..forward();
      }
    });
  }

  @override
  void dispose() {
    _rotateController.dispose();
    _flipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1)).then(
      (value) => _rotateController.forward(),
    );
    return Scaffold(
      appBar: AppBar(
        title: const FittedBox(
          fit: BoxFit.scaleDown,
          child: Text('flip and rotate the circle'),
        ),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _rotateController,
          builder: (context, child) {
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..rotateZ(
                  _rotateAnimation.value,
                ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedBuilder(
                    animation: _flipController,
                    builder: (context, child) {
                      return Transform(
                        alignment: Alignment.centerRight,
                        transform: Matrix4.identity()
                          ..rotateY(_flipAnimation.value),
                        child: ClipPath(
                          clipper: const MyClipper(circleSide: CircleSide.left),
                          child: Container(
                            color: Colors.teal,
                            width: 150,
                            height: 150,
                          ),
                        ),
                      );
                    },
                  ),
                  AnimatedBuilder(
                    animation: _flipController,
                    builder: (context, child) {
                      return Transform(
                        alignment: Alignment.centerLeft,
                        transform: Matrix4.identity()
                          ..rotateY(_flipAnimation.value),
                        child: ClipPath(
                          clipper:
                              const MyClipper(circleSide: CircleSide.right),
                          child: Container(
                            color: Colors.yellow,
                            width: 150,
                            height: 150,
                          ),
                        ),
                      );
                    },
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

enum CircleSide {
  left,
  right,
}

extension ToPath on CircleSide {
  Path path(Size size) {
    final path = Path();
    late Offset offset;
    late bool clockwise;

    switch (this) {
      case CircleSide.left:
        path.moveTo(size.width, 0);
        offset = Offset(size.width, size.height);
        clockwise = false;
        break;
      case CircleSide.right:
        offset = Offset(0, size.height);
        clockwise = true;
        break;
    }
    path.arcToPoint(
      offset,
      radius: Radius.circular(size.width / 2),
      clockwise: clockwise,
    );
    path.close();
    return path;
  }
}

class MyClipper extends CustomClipper<Path> {
  final CircleSide circleSide;

  const MyClipper({required this.circleSide});

  @override
  getClip(Size size) => circleSide.path(size);

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return true;
  }
}
