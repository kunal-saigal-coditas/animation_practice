// import 'package:animation_flutter/animation_page.dart';
import 'package:animation_flutter/flutter_animate_package.dart';
import 'package:animation_flutter/second_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      home: const AnimatePackagePractice(),
      // home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Animation"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 200,
                child: ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 10,
                  ),
                  itemCount: mockString.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SecondPage(
                              imageAddress: mockString[index],
                              index: index,
                            ),
                          ),
                        );
                      },
                      child: Hero(
                        tag: "pic$index",
                        child: SizedBox(
                          height: 40,
                          child: Image.asset(
                            mockString[index],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<String> mockString = [
  "assets/images/pic1.png",
  "assets/images/pic2.png",
  "assets/images/pic3.png",
  "assets/images/pic4.png",
  "assets/images/pic5.png",
];
