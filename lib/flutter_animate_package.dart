import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnimatePackagePractice extends StatefulWidget {
  const AnimatePackagePractice({super.key});

  @override
  State<AnimatePackagePractice> createState() => _AnimatePackagePracticeState();
}

class _AnimatePackagePracticeState extends State<AnimatePackagePractice>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      _controller,
    );

    _controller.forward(); // Start the animation
  }

  void changeController() {
    if (_controller.isCompleted) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => changeController(),
              child: const Text("Tap Here"),
            ),
            const Text(
              "Fade Effect and Scale Effect",
              style: TextStyle(fontSize: 20),
            ).animate().scale().then(
                  delay: 2.seconds,
                ),
            // .fadeOut(),
            const SizedBox(
              height: 20,
            ),
            const Text(
              ".animate method",
              style: TextStyle(fontSize: 20),
            )
                .animate()
                .scale(
                  duration: const Duration(seconds: 2),
                )
                // .callback(
                //   duration: const Duration(seconds: 1),
                //   callback: (value) => log("Half"),
                // )
                .flip(
                  duration: const Duration(seconds: 2),
                  delay: const Duration(seconds: 1),
                )
                .tint(
                  color: Colors.purple,
                ),
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) => Opacity(
                opacity: _opacityAnimation.value,
                child: const FlutterLogo(size: 100),
              ),
            ),
            const FlutterLogo(
              size: 40,
            )
                .animate(
                  // controller: _controller,
                  onPlay: (controller) => controller.repeat(),
                )
                .shimmer()
                .shake(),
            Animate(
              onComplete: (controller) => controller.repeat(),
            )
                .custom(
                    duration: 5.seconds,
                    begin: 00,
                    end: 10,
                    builder: (_, value, __) => Opacity(
                          opacity: value / 10,
                          child: const FlutterLogo(
                            size: 40,
                          ),
                        )
                    // .animate()
                    // .listen(
                    //     callback: (value) => log('current opacity: $value'),),
                    )
                .rotate(duration: 2.seconds),
            Animate().toggle(
              duration: 2.seconds,
              builder: (_, value, __) => Visibility(
                visible: !value,
                child: const FlutterLogo(
                  size: 100,
                  style: FlutterLogoStyle.horizontal,
                ),
              ),
            ),
            const Text("Before Swap")
                .animate(controller: _controller)
                .swap(
                  duration: 2.seconds,
                  builder: (_, __) => const Text(
                    "After Swap",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ).animate().fadeIn(),
                )
                .fadeIn(),
            const Text(
              ".animate().move()",
              style: TextStyle(fontSize: 20),
            )
                .animate(
                  controller: _controller,
                  // onPlay: (controller) => controller.repeat(),
                )
                .fadeIn() // uses `Animate.defaultDuration`
                .scale() // inherits duration from fadeIn
                .move(
                  delay: 0.5.seconds,
                  duration: 0.5.seconds,
                  begin: const Offset(100, 0),
                  end: const Offset(0, 0),
                ), // runs after the above w/new duration
            Column(
              children: AnimateList(
                interval: 1.seconds,
                effects: [
                  FadeEffect(
                    duration: 1.seconds,
                  ),
                ],
                children: const [
                  Text("Hello"),
                  Text("There !"),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
// or shorthand:
            Column(
              children: const [
                Text("General"),
                Text("Kenobi"),
              ]
                  .animate(
                    interval: 1.seconds,
                  )
                  .scale(
                    duration: 1.seconds,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
