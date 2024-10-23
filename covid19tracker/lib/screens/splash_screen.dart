import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import 'homescreen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // Initialize the animation controller with a repeating animation
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(period: const Duration(seconds: 4));
    Timer(const Duration(seconds: 4),
        ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const HomeScreen()))
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // AnimatedBuilder rotates the smiley face image
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform.rotate(
                    // pi=3.65 maths pi value
                    // this 2 is the speed of rotating
                    angle: _controller.value * 1.8 * pi,
                    child: child,
                  );
                },
                child: SizedBox(
                  width: width * 0.6,
                  height: height * 0.4,
                  child: Image.asset("assets/images/virus.png", fit: BoxFit.fill),
                ),
              ),
              SizedBox(height: height * 0.08),
              // Display the text "Covid-19 Tracker"
              "Covid-19\nTracker".text.bold.italic.xl5.center.make(),
            ],
          ),
        ),
      ),
    );
  }
}
