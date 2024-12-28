import 'package:flutter/material.dart';
import 'package:kitob_ol/color.dart';
import 'package:kitob_ol/widget/dropdown.dart';
import 'package:kitob_ol/widget/my_botton_text.dart';
import 'package:kitob_ol/widget/my_text_field.dart';
import 'package:kitob_ol/widget/text_class.dart';

class FilterController extends StatefulWidget {
  const FilterController({super.key});

  @override
  State<FilterController> createState() => _FilterControllerState();
}

class _FilterControllerState extends State<FilterController> {
  TextClass textClass = TextClass();

  TextEditingController bookName = TextEditingController();
  TextEditingController kitobMuallifi = TextEditingController();
  TextEditingController address = TextEditingController();
  RangeValues _currentRangeValues = const RangeValues(10000, 50000);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyTextField(
          controller: bookName,
          label: "Kitob nomi",
          textInputType: TextInputType.text,
        ),
        MyTextField(
            controller: kitobMuallifi,
            label: "Kitob Muallifi",
            textInputType: TextInputType.text),
        const MyDropdown(
          items: ["Badily", "Fiction", "Non fiction", "Novels"],
          label: "Kategoriya",
        ),
        const MyDropdown(items: [
          "Azon",
          "Qamar",
          "Hilol Nashr",
        ], label: "Nashriyot"),
        const SizedBox(
          height: 10,
        ),
        const Text(
          'Narx',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        // Price Range Slider
        RangeSlider(
          values: _currentRangeValues,
          min: 10000,
          max: 50000,
          divisions: 40,
          activeColor: const Color(0xff2C3033),
          inactiveColor: const Color(0xffE0E0E0),
          onChanged: (RangeValues values) {
            setState(() {
              _currentRangeValues = values;
            });
          },
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            price(size, _currentRangeValues.start.toInt()),
            Container(
              height: 56,
              color: kGreyBorder,
              width: 2,
            ),
            price(size, _currentRangeValues.end.toInt()),
          ],
        ),
        const MyDropdown(
            items: ["O'zbek", "Rus tili", "Ingilis tili", "Nemis tili"],
            label: "Til"),
        MyTextField(
            controller: address,
            label: "Manzil",
            textInputType: TextInputType.text),
        MyBottonText(
            top: 10,
            textColor: kWhite,
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => BookListScreen(
              //             // priceMax: 800000,
              //             // priceMin: 2,
              //             //TODO Price Min Max
              //             // priceMin: _currentRangeValues.start.toInt(),
              //             // priceMax: _currentRangeValues.end.toInt(),
              //             )));
            },
            text: "Qidirish",
            boxColor: imageColor),
      ],
    );
  }

  Container price(Size size, int price) {
    return Container(
      width: size.width * .45,
      height: 56,
      decoration: const BoxDecoration(
        color: kGreyContainer,
      ),
      child: Center(
        child: Text(
          '${textClass.formatNumberWithSpaces(price)} uzs',
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
