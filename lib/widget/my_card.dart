import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kitob_ol/color.dart';
import 'package:kitob_ol/home/model/favourite_model.dart';
import 'package:kitob_ol/login/ui/register.dart';
import 'package:kitob_ol/widget/add_remove.dart';
import 'package:kitob_ol/widget/text_class.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyCardBook extends StatefulWidget {
  final BookModel book;
  final VoidCallback onTap;
  const MyCardBook({super.key, required this.book, required this.onTap});

  @override
  State<MyCardBook> createState() => _MyCardBookState();
}

class _MyCardBookState extends State<MyCardBook> {
  TextClass textClass = TextClass();
  bool isRegistered = false;

  Future<bool> isRegister() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token') != null;
  }

  @override
  void initState() {
    super.initState();
    checkToken();
  }

  void checkToken() async {
    bool result = await isRegister();
    setState(() {
      isRegistered = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
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
                tag: widget.book.id!,
                child: Image.network(
                  widget.book.imageUrl!,
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
                          widget.book.title!,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                      Text(
                        widget.book.cityName!['uz'] ?? "",
                        style: TextStyle(fontSize: 11),
                      )
                    ],
                  ),
                  IconButton(
                      style: const ButtonStyle(
                          backgroundColor:
                              WidgetStatePropertyAll<Color>(kGreyContainer)),
                      onPressed: () {
                        if (isRegistered) {
                          addRemove(widget.book.id!,
                              widget.book.isFavorite ?? false, true);

                          setState(() {
                            widget.book.isFavorite = !widget.book.isFavorite!;
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("login".tr())));
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Register()));
                        }
                      },
                      icon: Icon(
                        widget.book.isFavorite!
                            ? Icons.favorite
                            : Icons.favorite_border,
                        size: MediaQuery.of(context).size.width * .05,
                        color: Colors.red,
                      ))
                ],
              ),
            ),
            Text(
              "  ${textClass.formatNumberWithSpaces(widget.book.price!)} ${"sum".tr()}",
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
