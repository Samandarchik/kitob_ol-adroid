import 'package:flutter/material.dart';
import 'package:kitob_ol/color.dart';

class MySlider extends StatefulWidget {
  const MySlider({super.key});

  @override
  State<MySlider> createState() => _MySliderState();
}

class _MySliderState extends State<MySlider> {
  PageController pageController = PageController();
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * .2,
      child: PageView.builder(
        
        controller: pageController,
        itemCount: 4,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            padding: const EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width * .9,
            decoration: BoxDecoration(
                color: imageColor, borderRadius: BorderRadius.circular(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "It is never \nlate to start \nreading!",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: kWhite, fontSize: 22),
                ),
                Image.asset("assets/image/book.png")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
