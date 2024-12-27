import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  final bool drawet;
  const MyAppBar({super.key, this.drawet = true});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(
          "assets/image/logo.png",
          width: 100,
        ),
        drawet
            ? Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              )
            : SizedBox(),
      ],
    );
  }
}
