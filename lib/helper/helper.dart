
import 'package:flutter/material.dart';
import 'package:html/parser.dart' as html;
import 'package:html/dom.dart' as dom;

class Helper {
  static Color lightenColor(Color color, [double amount = 0.15]) {
    // Use Color.lerp to mix the color with white
    return Color.lerp(color, Colors.white, amount)!;
  }

  static Color darkenColor(Color color, [double amount = 0.15]) {
    // Use Color.lerp to mix the color with white
    return Color.lerp(color, Colors.black, amount)!;
  }

  static String decodeHtml(String htmlString) {
    // Replace Unicode escape sequences
    String decoded = htmlString
        .replaceAll(r'\u003C', '<') // Replace \u003C with <
        .replaceAll(r'\u003E', '>'); // Replace \u003E with >

    // Remove HTML tags using a regular expression
    String withoutHtmlTags = decoded.replaceAll(RegExp(r'<[^>]*>'), '');

    return withoutHtmlTags.replaceAll(RegExp(r'&[a-zA-Z0-9#]+;'), '');
  }

  static bool containsArabic(String input) {
    final arabicRegExp = RegExp(r'[\u0600-\u06FF]');
    return arabicRegExp.hasMatch(input);
  }

  static String extractArabic(String input) {
    final arabicRegExp = RegExp(r'[\u0600-\u06FF]+');

    final matches = arabicRegExp.allMatches(input);
    return matches.map((match) => match.group(0)).join(' ');
    // Combine all matches into a single string
  }

  static String extractBase64FromImgTag(String htmlString) {
    // Regular expression to find base64 data inside the img tag
    RegExp regExp = RegExp(
        r'<img[^>]+src="data:image\/[^;]+;base64,([^"]+)"[^>]*>',
        caseSensitive: false);

    // Search for the base64 data
    Match? match = regExp.firstMatch(htmlString);

    if (match != null) {
      // Return the base64 part
      return match.group(1) ?? '';
    }

    return 'No base64 data found';
  }

  static List<String> convertToList(String encodedString) {
    // Decode the encoded string
    String decodedString = encodedString
        .replaceAll(r"\u003C", "<")
        .replaceAll(r"\u003E", ">")
        .replaceAll(r"\u0026", "&")
        .replaceAll(r"\r\n", "")
        .replaceAll(r"\u0027", "'");

    // Parse the decoded string to handle HTML tags
    var document = html.parse(decodedString);

    // Prepare the list for text items
    List<String> textList = [];

    // Handle paragraph text
    String paragraphText =
        document.getElementsByTagName('p').map((e) => e.text).join('\n');
    if (paragraphText.isNotEmpty) {
      textList.add(paragraphText);
    }

    // Handle ordered list items and convert to numbered items
    var listItems = document.getElementsByTagName('li');
    for (var i = 0; i < listItems.length; i++) {
      textList.add('${i + 1}. ${listItems[i].text}');
    }

    // Extract base64 image data
    RegExp base64RegExp = RegExp(r'data:image/png;base64,([^"]+)');
    String? base64Image;
    final match = base64RegExp.firstMatch(decodedString);
    if (match != null) {
      base64Image = match.group(1); // Get the base64 string
    }

    if (base64Image != null) {
      // Log or process the base64 image string
      print(base64Image);
      textList.add(base64Image); // Add base64 image to the list
    }

    return textList;
  }

  static String addSpaceAfterCapitalized(String text) {
    // Check if the string is fully capitalized
    if (text == text.toUpperCase()) {
      return text; // If the string is all capitalized, return it as is
    }

    return text.replaceAllMapped(RegExp(r'[A-Z]'), (Match match) {
      return ' ${match.group(0)}'; // Add a space before the capital letter
    }).trim(); // Remove any leading spaces
  }

  static Color localColor(String mapel) {
    if (mapel.toUpperCase().contains("TIMUR")) {
      return const Color.fromARGB(255, 213, 172, 92);
    }
    if (mapel.toUpperCase().contains("SUNDA")) {
      return const Color.fromARGB(255, 184, 110, 54);
    }
    if (mapel.toUpperCase().contains("PRAKARYA") ||
        mapel.toUpperCase().contains("PKWU")) {
      return const Color.fromARGB(255, 234, 207, 185);
    }
    if (mapel.toUpperCase().contains("MUSIK")) {
      return const Color.fromARGB(255, 248, 152, 82);
    }
    if (mapel.toUpperCase().contains("PENJAS")||mapel.toUpperCase().contains("PJOK")) {
      return const Color.fromARGB(255, 191, 90, 66);
    }

    if (mapel.toUpperCase().contains("INFORMATIKA")) {
      return const Color.fromARGB(255, 72, 10, 120);
    }
    if (mapel.toUpperCase().contains("SENI")) {
      return const Color.fromARGB(255, 234, 207, 185);
    }
    if (mapel.toUpperCase().contains("AGAMA") ||
        mapel.toUpperCase().contains("AL-QURAN") ||
        mapel.toUpperCase().contains("ARAB") ||
        mapel.toUpperCase().contains("AKIDAH") ||
        mapel.toUpperCase().contains("QUR'AN") ||
        mapel.toUpperCase().contains("BTQ") ||
        mapel.toUpperCase().contains("PAI") ||
        mapel.toUpperCase().contains("FIKIH") ||
        mapel.toUpperCase().contains("QURDIS") ||
        mapel.toUpperCase().contains("SKI")) {
      return const Color.fromARGB(255, 63, 63, 63);
    }

    if (mapel.toUpperCase().contains("JAWA")) {
      return const Color.fromARGB(
        255,
        186,
        153,
        119,
      );
    }
    if (mapel.toUpperCase().contains("SEJARAH")) {
      return const Color.fromARGB(255, 117, 47, 17);
    }
    if (mapel.toUpperCase().contains("INDONESIA")) {
      return const Color.fromARGB(255, 72, 79, 155);
    }
    if (mapel.toUpperCase().contains("MATEMATIKA")) {
      return const Color.fromARGB(255, 153, 178, 219);
    }
    if (mapel.toUpperCase().contains("INGGRIS") ||
        mapel.toUpperCase().contains("ENGLISH")) {
      return const Color.fromARGB(255, 159, 101, 221);
    }
    if (mapel.toUpperCase().contains("IPA") ||
        mapel.toUpperCase().contains("ALAM") ||
        mapel.toUpperCase().contains("FISIKA")) {
      return const Color.fromARGB(255, 14, 13, 45);
    }
    if (mapel.toUpperCase().contains("IPS") ||
        mapel.toUpperCase().contains("GEOGRAFI") ||
        mapel.toUpperCase().contains("SOSIAL")) {
      return const Color.fromARGB(255, 101, 166, 225);
    }
    if (mapel.toUpperCase().contains("KIMIA")) {
      return const Color.fromARGB(255, 243, 80, 77);
    }
    if (mapel.toUpperCase().contains("BIOLOGI")) {
      return const Color.fromARGB(255, 171, 124, 93);
    }

    if (mapel.toUpperCase().contains("KIMIA")) {
      return const Color.fromARGB(255, 243, 80, 77);
    }
    if (mapel.toUpperCase().contains("ANTROPOLOGI")) {
      return const Color.fromARGB(255, 159, 146, 154);
    }
    if (mapel.toUpperCase().contains("EKONOMI")) {
      return const Color.fromARGB(255, 241, 192, 104);
    }
    if (mapel.toUpperCase().contains("PANCASILA")) {
      return const Color.fromARGB(255, 213, 160, 57);
    }
    if (mapel.toUpperCase().contains("SOSIOLOGI")) {
      return const Color.fromARGB(255, 120, 144, 198);
    }
    if (mapel.toUpperCase().contains("BAHASA")) {
      return const Color.fromARGB(255, 72, 79, 155);
    }
    return const Color.fromARGB(255, 75, 75, 75).withOpacity(0.2);
  }

  static removeKelas(input) {
    String delimiter = "KELAS";

    // Find the index of the delimiter
    int delimiterIndex = input.indexOf(delimiter);

    // Extract the substring after the delimiter
    String result = input.substring(delimiterIndex);

    return (result.replaceAll("KELAS", "")); // Output: world
  }

  static removeJudul(input) {
    String delimiter = "KELAS";

    // Find the index of the delimiter
    int delimiterIndex = input.indexOf(delimiter);

    // Extract the substring before the delimiter
    String result = input.substring(0, delimiterIndex);

    return (result); // Output: world
  }

  static localAsset(String mapel) {
    if (mapel.toUpperCase().contains("TIMUR")) {
      return "asset/Icon/Bahasa Jawa Timur.png";
    }
    if (mapel.toUpperCase().contains("SUNDA")) {
      return "asset/Icon/Bahasa Sunda.png";
    }
    if (mapel.toUpperCase().contains("PRAKARYA") ||
        mapel.toUpperCase().contains("PKWU")) {
      return "asset/Icon/Seni.png";
    }
    if (mapel.toUpperCase().contains("MUSIK")) {
      return "asset/Icon/Musik.png";
    }
    if (mapel.toUpperCase().contains("PENJAS")||mapel.toUpperCase().contains("PJOK")) {
      return "asset/Icon/Penjas.png";
    }
    if (mapel.toUpperCase().contains("SEJARAH")) {
      return "asset/Icon/Sejarah.png";
    }
    if (mapel.toUpperCase().contains("SENI")) {
      return "asset/Icon/Seni.png";
    }
    if (mapel.toUpperCase().contains("AGAMA") ||
        mapel.toUpperCase().contains("AL-QURAN") ||
        mapel.toUpperCase().contains("ARAB") ||
        mapel.toUpperCase().contains("AKIDAH") ||
        mapel.toUpperCase().contains("QUR'AN") ||
        mapel.toUpperCase().contains("PAI")) {
      return "asset/Icon/Agama.png";
    }

    if (mapel.toUpperCase().contains("INDONESIA")) {
      return "asset/Icon/Bahasa Indonesia.png";
    }
    // if (mapel.toUpperCase().contains("JAWA")) {
    //   return "asset/Icon/Jawa.png";
    // }
    if (mapel.toUpperCase().contains("MATEMATIKA")) {
      return "asset/Icon/Matematika.png";
    }
    if (mapel.toUpperCase().contains("INFORMATIKA")) {
      return "asset/Icon/Informatika.png";
    }
    if (mapel.toUpperCase().contains("INGGRIS")) {
      return "asset/Icon/Bahasa Inggris.png";
    }
    if (mapel.toUpperCase().contains("IPA") ||
        mapel.toUpperCase().contains("ALAM") ||
        mapel.toUpperCase().contains("FISIKA")) {
      return "asset/Icon/Fisika.png";
    }
    if (mapel.toUpperCase().contains("IPS") ||
        mapel.toUpperCase().contains("GEOGRAFI") ||
        mapel.toUpperCase().contains("SOSIAL")) {
      return "asset/Icon/Geografi.png";
    }
    if (mapel.toUpperCase().contains("KIMIA")) {
      return "asset/Icon/Kimia.png";
    }
    if (mapel.toUpperCase().contains("BIOLOGI")) {
      return "asset/Icon/Biologi.png";
    }

    if (mapel.toUpperCase().contains("KIMIA")) {
      return "asset/Icon/Kimia.png";
    }
    if (mapel.toUpperCase().contains("ANTROPOLOGI")) {
      return "asset/Icon/Antropologi.png";
    }
    if (mapel.toUpperCase().contains("EKONOMI")) {
      return "asset/Icon/Ekonomi.png";
    }
    if (mapel.toUpperCase().contains("PANCASILA")) {
      return "asset/Icon/Pancasila.png";
    }
    if (mapel.toUpperCase().contains("SOSIOLOGI")) {
      return "asset/Icon/Sosiologi.png";
    }
    if (mapel.toUpperCase().contains("SEJARAH")) {
      return "asset/Icon/Sejarah.png";
    }
    if (mapel.toUpperCase().contains("JAWA")) {
      return "asset/Icon/Jawa.png";
    }
    if (mapel.toUpperCase().contains("BAHASA")) {
      return "asset/Icon/Bahasa Indonesia.png";
    }
    return "asset/Icon/Agama.png";
  }

  static String localMapelName(String mapel) {
    if (mapel.toUpperCase().contains("PRAKARYA") ||
        mapel.toUpperCase().contains("PKWU")) {
      return "asset/Icon/Seni.png";
    }
    if (mapel.toUpperCase().contains("AGAMA") ||
        mapel.toUpperCase().contains("ARAB") ||
        mapel.toUpperCase().contains("AKIDAH") ||
        mapel.toUpperCase().contains("QUR'AN") ||
        mapel.toUpperCase().contains("PAI")) {
      return "PAI";
    }

    if (mapel.toUpperCase().contains("INDONESIA")) {
      return "Indonesia";
    }
    if (mapel.toUpperCase().contains("MATEMATIKA")) {
      return "Matematika";
    }
    if (mapel.toUpperCase().contains("INGGRIS")) {
      return "Inggris";
    }
    if (mapel.toUpperCase().contains("IPA") ||
        mapel.toUpperCase().contains("ALAM") ||
        mapel.toUpperCase().contains("FISIKA")) {
      return "IPA";
    }
    if (mapel.toUpperCase().contains("FISIKA")) {
      return "Fisika";
    }
    if (mapel.toUpperCase().contains("IPS") ||
        mapel.toUpperCase().contains("SOSIAL")) {
      return "IPS";
    }
    if (mapel.toUpperCase().contains("KIMIA")) {
      return "Kimia";
    }
    if (mapel.toUpperCase().contains("BIOLOGI")) {
      return "Biologi";
    }

    if (mapel.toUpperCase().contains("ANTROPOLOGI")) {
      return "Antropologi";
    }
    if (mapel.toUpperCase().contains("EKONOMI")) {
      return "Ekonomi";
    }
    if (mapel.toUpperCase().contains("PANCASILA")) {
      return "PPKN";
    }
    if (mapel.toUpperCase().contains("SOSIOLOGI")) {
      return "Sosiologi";
    }
    if (mapel.toUpperCase().contains("SEJARAH")) {
      return "Sejarah";
    }
    return mapel;
  }

  static List<String> convertSoal(String soal) {
    if (soal.isEmpty) {
      return [soal];
    }
    List<String> list = [];
    var document = html.parse(soal);
    for (var i = 0; i < document.querySelectorAll("p").length; i++) {
      var data = document.querySelectorAll("p")[i].innerHtml.toString();
      if (data.contains("img src")) {
        var image = document.querySelectorAll("p")[i];
        dom.Element? link = image.querySelector('img');
        String? imageLink = link != null ? link.attributes['src'] : "";
        list.add(imageLink.toString());
      } else {
        list.add(document.querySelectorAll("p")[i].text);
      }
    }
    return list;
  }

  static String printDuration(Duration duration) {
    String negativeSign = duration.isNegative ? '-' : '';
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60).abs());
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60).abs());
    return "$twoDigitMinutes:$twoDigitSeconds";
  }
}
