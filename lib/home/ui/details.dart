import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:kitob_ol/color.dart';
import 'package:kitob_ol/home/model/favourite_model.dart';
import 'package:kitob_ol/home/ui/description.dart';
import 'package:kitob_ol/text_style.dart';
import 'package:kitob_ol/widget/my_botton_text.dart';
import 'package:kitob_ol/widget/text_class.dart';
import 'package:url_launcher/url_launcher.dart';

class Details extends StatelessWidget {
  final BookModel book;

  const Details({
    super.key,
    required this.book,
  });

  @override
  Widget build(BuildContext context) {
    Map<String, String> h1 = {
      "author".tr(): book.authorName!,
      "translator".tr(): book.translatorName,
      // "categorie".tr(): book.categoryName?['uz'] ?? "",
      "id".tr(): book.shitrixCode!,
      "cover".tr(): book.coverType == "soft" ? "Qattiq" : "Yumshoq",
      "page".tr(): book.totalPages.toString(),
      "status".tr(): book.isNew! ? "Yangi" : "O'qilgan",
      "paperFormat".tr(): book.coverFormat!,
      "language".tr(): book.languageName.uz,
      "writing".tr(): book.writingType == "latin" ? "Lotin" : "Ruscha",
      "publisher".tr(): book.publisherName,
      "year".tr(): book.publishedYear.toString()
    };

    Size size = MediaQuery.of(context).size;
    TextClass textClass = TextClass();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          book.title!,
          style: kTSFWB18.copyWith(fontSize: 22),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * .28,
                  child: PageView.builder(
                    itemCount: 2,
                    itemBuilder: (context, index) => Hero(
                      tag: book.id!,
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                                index == 0 ? book.imageUrl : book.imgUrl),
                            fit: BoxFit.contain,
                          ),
                          gradient: const LinearGradient(
                            colors: [kImagesBackStart, kImagesBackEnd],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                              right: size.width * .5, left: size.width * .05),
                          child: const FittedBox(
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text("price".tr()),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "${textClass.formatNumberWithSpaces(book.price!)} ${"sum".tr()}",
                  style: kTSFWB18.copyWith(fontSize: 24),
                ),
                const SizedBox(
                  height: 20,
                ),
                MasonryGridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemCount: h1.length,
                  itemBuilder: (context, index) {
                    String key = h1.keys.elementAt(index);
                    String value = h1[key] ?? 'Ma\'lumot mavjud emas';
                    return InfoGrid(
                      h1: key,
                      p: value,
                    );
                  },
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    "${"viewsNumber".tr()}: ${book.viewCount}    ",
                    style: kTSFW,
                  ),
                ),
                SizedBox(height: 15),
                // Additional info button
                MyBottonText(
                  text: "detail".tr(),
                  boxColor: kGrey,
                  textColor: imageColor,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DescriptionPage(
                                description: book.description!)));
                  },
                ),
                // Contact button (bottom sheet)
                MyBottonText(
                    top: 10,
                    text: "call".tr(),
                    boxColor: imageColor,
                    textColor: kWhite,
                    onTap: () async {
                      final Uri url =
                          Uri(scheme: "tel", path: book.sellerPhoneNumber);
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Not Number")));
                      }
                    }),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class InfoGrid extends StatelessWidget {
  final String h1;
  final String p;
  const InfoGrid({super.key, required this.h1, required this.p});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: size.width * .02, vertical: size.height * .012),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                h1,
                style: TextStyle(color: Colors.black45),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 2.5,
                child: Text(
                  maxLines: 2,
                  p,
                  style: kTSFW,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
