import 'package:flutter/material.dart';
import 'package:kitob_ol/color.dart';
import 'package:kitob_ol/widget/text_class.dart';

class MyCard extends StatelessWidget {
  final String title;
  final String image;
  final String city;
  final int index;
  final int price;
  final VoidCallback onTap;
  final bool isFavorite;

  const MyCard(
      {super.key,
      required this.index,
      required this.price,
      required this.onTap,
      required this.title,
      required this.city,
      required this.image,
      required this.isFavorite});

  @override
  Widget build(BuildContext context) {
    TextClass textClass = TextClass();
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: kGrey,
            ),
            borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              child: Image.network(
                image,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 10, 0, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .29,
                        child: Text(
                          title,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                      Text(
                        city,
                        style: TextStyle(fontSize: 11),
                      )
                    ],
                  ),
                  IconButton(
                      style: const ButtonStyle(
                          backgroundColor:
                              WidgetStatePropertyAll<Color>(kGreyContainer)),
                      onPressed: () {},
                      icon: Icon(
                        isFavorite ? Icons.favorite_border : Icons.favorite,
                        size: MediaQuery.of(context).size.width * .05,
                        color: Colors.red,
                      ))
                ],
              ),
            ),
            Text(
              " ${textClass.formatNumberWithSpaces(price)} So'm",
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 20, color: Colors.red),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
