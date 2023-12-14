import 'dart:math';

import 'package:animation_flutter/main.dart';
import 'package:flutter/material.dart';

class AnimationPage extends StatefulWidget {
  const AnimationPage({super.key});

  @override
  State<AnimationPage> createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage>
    with TickerProviderStateMixin {
  final ValueNotifier<double> _animationControllerValue = ValueNotifier(0.0);

  final ValueNotifier<bool> _boolControllerValue = ValueNotifier(false);

  final GlobalKey _listKey = GlobalKey<AnimatedListState>();

  late List<AnimationController> _animationControllers;

  late AnimationController _controllerForBuilder;

  late Animation<Color?> colorAnimation;

  // late Animation<double> curve;

  @override
  void initState() {
    super.initState();

    _controllerForBuilder = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();

    _animationControllers = List.generate(
      mockString.length,
      (index) => AnimationController(
        vsync: this,
        duration: const Duration(seconds: 3),
      ),
    );

    // curve = CurvedAnimation(
    //     parent: _controllerForBuilder, curve: Curves.easeInExpo);
    colorAnimation = ColorTween(begin: Colors.amber, end: Colors.deepPurple)
        .animate(_controllerForBuilder);

    for (int i = 0; i < mockString.length; i++) {
      _animationControllers[i].forward();
    }
  }

  void changeBool() {
    _boolControllerValue.value = !_boolControllerValue.value;
  }

  void startAnimation() {
    if (_animationControllerValue.value == 0.0) {
      Future.delayed(const Duration(seconds: 1), () {
        _animationControllerValue.value = 1.0;
      });
    } else {
      Future.delayed(const Duration(seconds: 1), () {
        _animationControllerValue.value = 0.0;
      });
    }
  }

  void changeContainerColorAnimation() {
    if (_controllerForBuilder.value == 0.0) {
      Future.delayed(const Duration(seconds: 1), () {
        _controllerForBuilder.forward();
      });
    } else {
      Future.delayed(const Duration(seconds: 1), () {
        _controllerForBuilder.reverse();
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _animationControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Center(
              child: ValueListenableBuilder(
                valueListenable: _animationControllerValue,
                builder: (context, value, child) {
                  return Stack(
                    children: [
                      Column(
                        children: [
                          AnimatedContainer(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: ColorTween(
                                begin: Colors.red,
                                end: Colors.blue,
                              )
                                  .animate(
                                    CurvedAnimation(
                                      parent: AlwaysStoppedAnimation(value),
                                      curve: Curves.linear,
                                    ),
                                  )
                                  .value,
                            ),
                            duration: const Duration(seconds: 3),
                            width: 200,
                            height: 200,
                            child: Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  startAnimation();
                                },
                                child: const Text('Animate Color'),
                              ),
                            ),
                          ),
                          AnimatedOpacity(
                            opacity: _animationControllerValue.value,
                            duration: const Duration(seconds: 1),
                            child: const Text(
                              "hello There",
                              style: TextStyle(fontSize: 23),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          AnimatedBuilder(
                            animation: _controllerForBuilder,
                            builder: (context, child) {
                              return InkWell(
                                onTap: () {
                                  changeContainerColorAnimation();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: colorAnimation.value,
                                  ),
                                  height: 90,
                                  width: 180,
                                ),
                              );
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TweenAnimationBuilder(
                            tween: Tween<double>(begin: 1, end: 0),
                            duration: const Duration(seconds: 3),
                            curve: Curves.easeIn,
                            builder: (context, value, child) {
                              return Transform.translate(
                                offset: Offset(value * 100, 0),
                                child: Transform.rotate(
                                  angle: _controllerForBuilder.value * 2.0 * pi,
                                  child: child,
                                ),
                              );
                            },
                            child: Card(
                              child: Image.asset(
                                mockString[0],
                              ),
                            ),
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     ElevatedButton(
                          //       onPressed: () {
                          //         _addItem("assets/images/pic8.png");
                          //       },
                          //       child: const Text("Add"),
                          //     ),
                          //     const SizedBox(
                          //       width: 10,
                          //     ),
                          //     ElevatedButton(
                          //       onPressed: () {
                          //         // _removeItem();
                          //       },
                          //       child: const Text("Remove"),
                          //     ),
                          //   ],
                          // ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 500,
                            child: AnimatedList(
                              initialItemCount: mockString.length,
                              key: _listKey,
                              itemBuilder: (context, index, animation) =>
                                  AnimatedWidget(
                                animationController:
                                    _animationControllers[index],
                                index: index,
                                item: mockString[index],
                              ),
                            ),
                          ),
                        ],
                      ),
                      ValueListenableBuilder(
                        valueListenable: _boolControllerValue,
                        builder: (context, value, child) => AnimatedPositioned(
                          width: _boolControllerValue.value ? 240.0 : 60.0,
                          height: _boolControllerValue.value ? 60.0 : 240.0,
                          top: _boolControllerValue.value ? 50.0 : 150.0,
                          duration: const Duration(seconds: 2),
                          curve: Curves.fastOutSlowIn,
                          child: GestureDetector(
                            onTap: () {
                              changeBool();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(2),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.amberAccent,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Center(
                                  child: Text('Tap me'),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Widget _buildItem(String item, Animation<double> animation, int index) {}

  void _addItem(String newItem) {
    mockString.add(newItem);
    _animationControllers.add(
      AnimationController(
        vsync: this,
        duration: const Duration(
          seconds: 3,
        ),
      )..forward(),
    );

    (_listKey.currentState as AnimatedListState).insertItem(
      mockString.length - 1,
      duration: const Duration(seconds: 3),
    );
  }

  void _removeItem() {
    if (mockString.isNotEmpty) {
      final removedItem = mockString.removeLast();

      (_listKey.currentState as AnimatedListState).removeItem(
        mockString.length,
        (context, animation) => AnimatedWidget(
          animationController: _animationControllers.last,
          index: mockString.length - 1,
          item: removedItem,
        ),
        duration: const Duration(seconds: 2),
      );
      _animationControllers.last.reverse().whenComplete(() {
        _animationControllers.last.dispose();
        _animationControllers.removeLast();
      });
    }
  }
}

class AnimatedWidget extends StatelessWidget {
  const AnimatedWidget({
    super.key,
    required this.animationController,
    required this.index,
    required this.item,
  });

  final AnimationController animationController;
  final int index;
  final String item;

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1, 1),
        end: const Offset(0, 0),
      ).animate(
        CurvedAnimation(
          parent: animationController,
          curve: Interval(
            0.2 * index,
            1.0,
            curve: Curves.easeInOut,
          ),
        ),
      ),
      child: SizedBox(
        height: 80,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          child: Image.asset(
            item,
          ),
        ),
      ),
    );
  }
}
