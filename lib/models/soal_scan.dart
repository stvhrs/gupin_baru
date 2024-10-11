import 'dart:developer';

import 'package:Bupin/helper/helper.dart';

class Quiz {
  final List<WidgetQuestion> questions;
  final String namaBab;
  final String namaMapel;

  Quiz({
    required this.questions,
    required this.namaBab,
    required this.namaMapel,
  });

  factory Quiz.fromMap(Map<String, dynamic> data, Map<String, dynamic> data2) {
    return Quiz(
        questions: (data2["data"]["soal"] as List<dynamic>)
            .map(
              (e) => WidgetQuestion.fromMap(e),
            )
            .toList(),
        namaBab: data["namaBab"],
        namaMapel: data["namaMapel"]);
  }
}

class WidgetQuestion {
  final List<String> text;
  final String htmlText;
  final List<WiidgetOption> options;

  WiidgetOption? selectedWiidgetOption;

  WidgetQuestion({
    required this.htmlText,
    required this.text,
    required this.options,

    this.selectedWiidgetOption,
  });

  factory WidgetQuestion.fromMap(Map<String, dynamic> data) {
    return WidgetQuestion(
      htmlText: data["soal"],
      text: Helper.convertSoal(data["soal"]).map((e) => e).toList(),
      options: [
        WiidgetOption(
            isCorrect: data["jawaban"] == "pilA",
            text: Helper.convertSoal(data["pilA"])[0]),
        WiidgetOption(
            isCorrect: data["jawaban"] == "pilB",
            text: Helper.convertSoal(data["pilB"])[0]),
        WiidgetOption(
            isCorrect: data["jawaban"] == "pilC",
            text: Helper.convertSoal(data["pilC"])[0]),
        WiidgetOption(
            isCorrect: data["jawaban"] == ("pilD"),
            text: Helper.convertSoal(data["pilD"])[0]),
        WiidgetOption(
            isCorrect: data["jawaban"] == ("pilE"),
            text: Helper.convertSoal(data["pilE"])[0])
      ],
    );
  }
}

class WiidgetOption {
  final String? text;
  final bool? isCorrect;

  const WiidgetOption({
    this.text,
    this.isCorrect,
  });
}
