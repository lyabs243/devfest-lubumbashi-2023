import 'package:devfest_lushi_2023/animation.dart';
import 'package:devfest_lushi_2023/components/app_button.dart';
import 'package:devfest_lushi_2023/custom_painter.dart';
import 'package:devfest_lushi_2023/utils.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Devfest Lubumbashi 23'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(pagePadding),
          child: Column(
            children: [
              AppButton(
                text: 'Custom Painter',
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const CustomPainterTest(),
                    )
                  );
                },
              ),
              AppButton(
                text: 'Animations',
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const AnimationTest(),
                    )
                  );
                },
              ),
              AppButton(
                text: 'Lottie',
                onPressed: () {},
              ),
              AppButton(
                text: 'Rive',
                onPressed: () {},
              ),
              AppButton(
                text: 'All in one',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
