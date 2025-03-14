import 'package:flutter/material.dart';
import 'package:kitob_ol/color.dart';
import 'package:kitob_ol/home/model/favourite_model.dart';
import 'package:kitob_ol/widget/text_class.dart';

class MyCardBook extends StatelessWidget {
  final BookModel book;
  final VoidCallback onTap;
  const MyCardBook({super.key, required this.book, required this.onTap});

  @override
  Widget build(BuildContext context) {
    TextClass textClass = TextClass();
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: kWhite,
            border: Border.all(
              color: kGrey,
            ),
            borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              child: Hero(
                tag: book.id!,
                child: Image.network(
                  book.imageUrl!,
                  errorBuilder: (context, error, stackTrace) {
                    return Text("       Image olishda xatolik");
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 0, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .7,
                        child: Text(
                          book.title!,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                      Text(
                        book.cityName!['uz'] ?? "",
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
                        Icons.favorite_border,
                        size: MediaQuery.of(context).size.width * .05,
                        color: Colors.red,
                      ))
                ],
              ),
            ),
            Text(
              "  ${textClass.formatNumberWithSpaces(book.price!)} So'm",
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
