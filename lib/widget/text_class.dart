class TextClass {
  String formatNumberWithSpaces(int number) {
    // Raqamni satrga aylantiramiz
    String numStr = number.toString();

    // Raqamni uch xonali guruhlarga ajratamiz
    List<String> chunks = [];
    int length = numStr.length;

    // Har uch xonali guruhni bo'laklarga ajratamiz
    while (length > 3) {
      chunks.insert(0, numStr.substring(length - 3, length));
      numStr = numStr.substring(0, length - 3);
      length = numStr.length;
    }

    // Oxirgi qismni qo'shamiz
    if (numStr.isNotEmpty) {
      chunks.insert(0, numStr);
    }

    // Har bir guruh orasiga bo'sh joy qo'yamiz
    return chunks.join(' ');
  }

  String formatPhoneNumber(String input) {
    // Faqat raqamlarni olish
    input = input.replaceAll(RegExp(r'[^0-9]'), '');

    // Telefon raqamini formatlash
    if (input.length <= 2) {
      return input;
    } else if (input.length <= 5) {
      return '${input.substring(0, 2)} ${input.substring(2)}';
    } else if (input.length <= 7) {
      return '${input.substring(0, 2)} ${input.substring(2, 5)} ${input.substring(5)}';
    } else if (input.length <= 10) {
      return '${input.substring(0, 2)} ${input.substring(2, 5)} ${input.substring(5, 7)} ${input.substring(7)}';
    }
    return input.substring(0, 13); // Maksimal 13 belgidan oshmasligi kerak
  }
}
