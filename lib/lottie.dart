import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';

class LottieTest extends StatelessWidget {

  final List<Item> items = [
    Item(
      title: 'DevFest Lubumbashi 2023',
      body: 'Bienvenue au DevFest Lubumbashi 2023, la plus grande conférence de développeurs en Afrique.',
      image: 'assets/expert.json',
    ),
    Item(
      title: 'Conférence',
      body: 'Participez à la conférence et apprenez des experts dans plusieurs domaines comme le développement web, mobile, cloud, etc.',
      image: 'assets/conference.json',
    ),
    Item(
      title: 'Workshop',
      body: 'Participez aux workshops et apprenez des experts dans plusieurs domaines comme le développement web, mobile, cloud, etc.',
      image: 'assets/workshop.json',
    ),
  ];

  LottieTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lottie Test')),
      body: IntroductionScreen(
        globalBackgroundColor: Theme.of(context).colorScheme.inversePrimary,
        dotsDecorator: DotsDecorator(
          color: Colors.white,
          activeColor: Colors.red,
          activeSize: const Size(20, 10),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        pages: List.generate(
          items.length,
          (index) {
            return PageViewModel(
              title: items[index].title,
              body: items[index].body,
              decoration: PageDecoration(
                pageColor: Theme.of(context).colorScheme.inversePrimary,
                bodyFlex: 2,
                imageFlex: 5,
                bodyTextStyle: const TextStyle(
                ),
              ),
              image: Center(
                child: Lottie.asset(
                  items[index].image,
                ),
              ),
            );

          },
        ),
        showNextButton: false,
        done: Container(),
        onDone: () {

        },
      ),
    );
  }

}

class Item {
  final String title;
  final String body;
  final String image;

  Item({
    required this.title,
    required this.body,
    required this.image,
  });
}