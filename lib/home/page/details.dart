import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:kitob_ol/color.dart';
import 'package:kitob_ol/home/page/description.dart';
import 'package:kitob_ol/text_style.dart';
import 'package:kitob_ol/widget/my_botton_text.dart';
import 'package:kitob_ol/widget/text_class.dart';

class Details extends StatelessWidget {
  final String description;
  final String id;
  final String sellerId;
  final String publisherId;
  final String categoryId;
  final String translatorId;
  final String authorId;
  final String languageId;
  final String title;
  final int totalPages;
  final int price;
  final String imageUrl;
  final String imgUrl;
  final String writingType;
  final int viewCount;
  final String cityName;
  final String coverType;
  final String coverFormat;
  final String shitrixCode;
  final String createdAt;
  final String publishedYear;
  final bool isNew; // is_new nullable bo'lishi mumkin

  const Details(
      {required this.id,
      required this.description,
      required this.sellerId,
      required this.publisherId,
      required this.categoryId,
      required this.translatorId,
      required this.authorId,
      required this.languageId,
      required this.title,
      required this.totalPages,
      required this.price,
      required this.imageUrl,
      required this.imgUrl,
      required this.writingType,
      required this.viewCount,
      required this.cityName,
      required this.coverType,
      required this.coverFormat,
      required this.shitrixCode,
      required this.createdAt,
      required this.isNew,
      required this.publishedYear});

  @override
  Widget build(BuildContext context) {
    Map<String, String> h1 = {
      "Muallif": authorId,
      "Tarjimon": translatorId,
      "Kategoriya": categoryId,
      "ISBN(ID)": shitrixCode,
      "Muqova": coverType,
      "Safiha": totalPages.toString(),
      "Holati": isNew ? "Yangi" : "O'qilgan",
      "Qog’oz formati": coverFormat,
      "Tili": languageId,
      "Yozuvi": writingType,
      "Nashriyot": publisherId,
      "Yili": publishedYear
    };

    Size size = MediaQuery.of(context).size;
    TextClass textClass = TextClass();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
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
                    itemBuilder: (context, index) => Container(
                      height: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(imageUrl),
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
                const SizedBox(
                  height: 20,
                ),
                const Text("Narx"),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "${textClass.formatNumberWithSpaces(price)} So'm",
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
                    "Ko'rishlar soni:$viewCount    ",
                    style: kTSFW,
                  ),
                ),
                SizedBox(height: 15),
                // Additional info button
                MyBottonText(
                  text: "Qo'shimcha malumot",
                  boxColor: kGrey,
                  textColor: imageColor,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DescriptionPage(description: description)));
                  },
                ),
                // Contact button (bottom sheet)
                MyBottonText(
                  top: 10,
                  text: "Murojat",
                  boxColor: imageColor,
                  textColor: kWhite,
                  onTap: () {},
                ),
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
