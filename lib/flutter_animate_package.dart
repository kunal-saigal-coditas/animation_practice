import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnimatePackagePractice extends StatefulWidget {
  const AnimatePackagePractice({super.key});

  @override
  State<AnimatePackagePractice> createState() => _AnimatePackagePracticeState();
}

class _AnimatePackagePracticeState extends State<AnimatePackagePractice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Animate(
            effects: const [
              FadeEffect(
                duration: Duration(seconds: 2),
              ),
              ScaleEffect(
                duration: Duration(seconds: 2),
              ),
            ],
            child: const Text("Fade Effect and Scale Effect"),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(".animate method")
              .animate(
                delay: Duration(seconds: 1),
              )
              .scale(
                duration: const Duration(seconds: 2),
              )
              .flip(
                duration: const Duration(seconds: 2),
              ),
        ],
      ),
    );
  }
}
