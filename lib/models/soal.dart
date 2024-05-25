import 'dart:developer';

class WidgetQuestion {
  final String id;
  final String imageUrl;
  final String text;
  final List<WiidgetOption> options;
  bool isLocked;
  WiidgetOption? selectedWiidgetOption;
  WiidgetOption correctAnswer;

  WidgetQuestion({
    required this.imageUrl ,
    required this.text,
    required this.options,
    this.isLocked = false,
    this.selectedWiidgetOption,
    required this.id,
    required this.correctAnswer,
  });
  factory WidgetQuestion.fromMap(Map<String, dynamic> data) {
    log("WIDGETQUESTU");
    return WidgetQuestion(
        text: data["question"],
        options: (data["incorrect_answers"] as List)
            .map((e) => WiidgetOption(isCorrect: false, text: e))
            .toList()..add(  WiidgetOption(isCorrect: true, text: data["correct_answer"]))..shuffle(),
        id: data["idsoal"],
        imageUrl: data["questionpicture"],
        correctAnswer:
            WiidgetOption(isCorrect: true, text: data["correct_answer"]));
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
