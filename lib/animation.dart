import 'package:flutter/material.dart';

class AnimationTest extends StatefulWidget {

  const AnimationTest({Key? key}) : super(key: key);

  @override
  State<AnimationTest> createState() => _AnimationTestState();

}

class _AnimationTestState extends State<AnimationTest> with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late final Animation<Alignment> _animation;
  late final Animation<double> _animationOpacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 5000),
      vsync: this,
    ) ..repeat(reverse: true);
    _animation = Tween<Alignment>(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ).animate(_controller);

    _animationOpacity = Tween<double>(
      begin: 0.2,
      end: 1
    ).animate(_controller);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Animation Test')),
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _animation,
            child: Image.asset(
              'assets/logo-devfest.jpg',
              width: 200,
              height: 200,
              opacity: _animationOpacity,
            ),
            builder: (context, child) {
              return Align(
                alignment: _animation.value,
                child: child,
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

}

