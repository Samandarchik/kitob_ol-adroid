import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kitob_ol/color.dart';
import 'package:kitob_ol/core/data/local/token_storage.dart';
import 'package:kitob_ol/core/di/di.dart';
import 'package:kitob_ol/home/model/book_model.dart';
import 'package:kitob_ol/home/service/book_service.dart';
import 'package:kitob_ol/home/ui/details.dart';
import 'package:kitob_ol/login/ui/register.dart';
import 'package:kitob_ol/widget/add_remove.dart';
import 'package:kitob_ol/widget/text_class.dart';

class MyCardBook extends StatefulWidget {
  final BookModel book;
  const MyCardBook({
    super.key,
    required this.book,
  });

  @override
  State<MyCardBook> createState() => _MyCardBookState();
}

class _MyCardBookState extends State<MyCardBook> {
  TokenStorage tokenStorage = sl<TokenStorage>();
  TextClass textClass = TextClass();
  bool isRegistered = false;

  @override
  void initState() {
    super.initState();
    checkToken();
  }

  void checkToken() async {
    bool result = tokenStorage.getToken().isNotEmpty;
    setState(() {
      isRegistered = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Details(
                      book: widget.book,
                    )));
        await BookService().getBook(widget.book.id);
      },
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
                tag: widget.book.id,
                child: Image.network(
                  widget.book.imageUrl,
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
                          widget.book.title,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                      style: const ButtonStyle(
                          backgroundColor:
                              WidgetStatePropertyAll<Color>(kGreyContainer)),
                      onPressed: () {
                        if (isRegistered) {
                          addRemove(widget.book.id, widget.book.isFavourite);

                          setState(() {
                            widget.book.isFavourite = widget.book.isFavourite;
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            duration: const Duration(seconds: 1),
                            content: Row(
                              children: [
                                Text("register".tr()),
                                const Spacer(),
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Register()));
                                    },
                                    child: Text("register".tr()))
                              ],
                            ),
                          ));
                        }
                      },
                      icon: Icon(
                        widget.book.isFavourite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        size: MediaQuery.of(context).size.width * .05,
                        color: Colors.red,
                      ))
                ],
              ),
            ),
            Text(
              "  ${textClass.formatNumberWithSpaces(widget.book.price)} ${"sum".tr()}",
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
