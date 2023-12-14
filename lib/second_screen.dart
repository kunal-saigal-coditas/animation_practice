import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({
    super.key,
    required this.imageAddress,
    required this.index,
  });
  final String imageAddress;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Hero(
              tag: 'pic$index',
              child: SizedBox(
                height: 100,
                width: 200,
                child: Image.asset(
                  imageAddress,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
