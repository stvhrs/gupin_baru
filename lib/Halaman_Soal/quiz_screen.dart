import 'dart:async';

import 'package:Bupin/Halaman_PDF_Soal.dart';
import 'package:Bupin/Halaman_Soal/results_screen.dart';
import 'package:Bupin/models/soal.dart';
import 'package:Bupin/styles/capital.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class QuizScreen extends StatefulWidget {
  final String topicType;
  final List<dynamic> questionlenght;
  final Color color;
  final dynamic optionsList;
  const QuizScreen(
      {super.key,
      required this.color,
      required this.questionlenght,
      required this.optionsList,
      required this.topicType});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

// The clip area can optionally be enlarged by a given padding.
class ClipPad extends CustomClipper<Rect> {
  final EdgeInsets padding;

  const ClipPad({this.padding = EdgeInsets.zero});

  @override
  Rect getClip(Size size) => padding.inflateRect(Offset.zero & size);

  @override
  bool shouldReclip(ClipPad oldClipper) => oldClipper.padding != padding;
}

class _QuizScreenState extends State<QuizScreen> {
  int questionTimerSeconds = 60;
  Timer? _timer;
  int _questionNumber = 1;
  PageController _controller = PageController();
  int score = 0;
  bool isLocked = false;
  List optionsLetters = ["A.", "B.", "C.", "D.", "E."];
  List<WiidgetOption> listSelectedOption = [];

  void navigateToNewScreen() {
    if (_questionNumber < widget.questionlenght.length) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 800),
        curve: Curves.linear,
      );
      // setState(() {
      _questionNumber++;
      isLocked = false;
      // });
      _resetQuestionLocks();
    } else {
      _timer?.cancel();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultsScreen(
            score: score,
            color: widget.color,
            totalQuestions: widget.questionlenght.length,
            whichTopic: widget.topicType,
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    if (widget.optionsList.length == 4) {
      optionsLetters = [
        "A.",
        "B.",
        "C.",
        "D.",
      ];
    }
    super.initState();
    _controller = PageController(initialPage: 0);
    _resetQuestionLocks();
  }

  @override
  Widget build(BuildContext context) {
    Color bgColor3 = widget.color;
    Color bgColor = widget.color.withOpacity(0.5);

    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pop();
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: bgColor3,
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.2),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 0, right: 0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 14, bottom: 10),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: GestureDetector(
                                onTap: () {
                                  // controller.pause();
                                  Navigator.pop(context, false);
                                },
                                child: Center(
                                  child: Icon(
                                    Icons.arrow_back_rounded,
                                    color: Colors.white,
                                    size: 20,
                                    weight: 100,
                                  ),
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10,),
                            child: Text(
                              "${widget.topicType.toTitleCase()}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ClipRect(
                      clipper: const ClipPad(padding: EdgeInsets.only(top: 30)),
                      child: Container(
                        padding:
                            const EdgeInsets.only(top: 10, left: 10, right: 10),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(20),
                          ),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.24),
                              blurRadius: 10.0,
                              offset: const Offset(10.0, 0),
                              spreadRadius: 2,
                            )
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Center(
                            child: Text(
                              "Pertanyaan $_questionNumber/${widget.questionlenght.length}",
                              style: TextStyle(
                                  fontSize: 16, color: Colors.grey.shade500),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: PageView.builder(
            controller: _controller,
            physics: const NeverScrollableScrollPhysics(),
            pageSnapping: false,
            itemCount: widget.questionlenght.length,
            onPageChanged: (value) {
              // setState(() {
              _questionNumber = value + 1;
              isLocked = false;
              _resetQuestionLocks();
              // });
            },
            itemBuilder: (context, index) {
              final WidgetQuestion myquestions = widget.questionlenght[index];
              var optionsIndex = widget.optionsList[index];

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    myquestions.imageUrl != ""
                        ? Container(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: FadeInImage.assetNetwork(
                                  placeholder: "asset/loading.png",
                                  placeholderColor: widget.color,
                                  height: MediaQuery.of(context).size.width *
                                      9 /
                                      16,
                                  image: myquestions.imageUrl,
                                ),
                              ),
                            ),
                          )
                        : SizedBox(),
                    Text(
                      myquestions.text,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 18,
                          ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Column(
                      children: myquestions.options.map((e) {
                        var color = Colors.grey.shade200;

                        var questionOption = e;
                        final letters =
                            optionsLetters[myquestions.options.indexOf(e)];

                        if (myquestions.isLocked) {
                          if (questionOption ==
                              myquestions.selectedWiidgetOption) {
                            color = questionOption.isCorrect!
                                ? Colors.green
                                : Colors.red;
                          } else if (questionOption.isCorrect!) {
                            color = Colors.green;
                          }
                        }
                        return InkWell(
                          onTap: () {
                            print(optionsIndex);

                            if (!myquestions.isLocked) {
                              listSelectedOption.add(questionOption);
                              setState(() {
                                myquestions.isLocked = true;
                                myquestions.selectedWiidgetOption =
                                    questionOption;
                              });

                              isLocked = myquestions.isLocked;
                              if (myquestions
                                  .selectedWiidgetOption!.isCorrect!) {
                                score++;
                              }
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              border: Border.all(color: color),
                              color: Colors.grey.shade100,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Center(
                              child: Row(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Align(alignment: Alignment.topCenter,
                                    child: Text(
                                      "$letters",
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  questionOption.text!.contains("https")
                                      ? Expanded(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                child: AspectRatio(aspectRatio: 16/9,
                                                  child: FadeInImage.assetNetwork(
                                                      placeholder:
                                                          "asset/loading.png",
                                                      placeholderColor:
                                                          widget.color,
                                                      image:
                                                          questionOption.text!),
                                                )),
                                          ),
                                        )
                                      : Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 4),
                                            child: Text(
                                              "${questionOption.text}",
                                              style:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                          ),
                                        ),
                                  isLocked == true
                                      ? questionOption.isCorrect!
                                          ? const Icon(
                                              Icons.check_circle,
                                              color: Colors.green,
                                            )
                                          : const Icon(
                                              Icons.cancel,
                                              color: Colors.red,
                                            )
                                      : Opacity(
                                          opacity: 0,
                                          child: const Icon(
                                            Icons.check_circle,
                                            color: Colors.green,
                                          ),
                                        )
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    isLocked
                        ? Center(
                            child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: buildElevatedButton(),
                          ))
                        : const SizedBox.shrink(),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _resetQuestionLocks() {
    for (var question in widget.questionlenght) {
      question.isLocked = false;
    }
    questionTimerSeconds = 60;
  }

  ElevatedButton buildElevatedButton() {
    //  const Color bgColor3 = Color(0xFF5170FD);

    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(widget.color),
        fixedSize: MaterialStateProperty.all(
          Size(MediaQuery.sizeOf(context).width * 0.80, 40),
        ),
        elevation: MaterialStateProperty.all(4),
      ),
      onPressed: () {
        if (_questionNumber < widget.questionlenght.length) {
          _controller.nextPage(
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOut,
          );
          setState(() {
            _questionNumber++;
            isLocked = false;
          });
          _resetQuestionLocks();
        } else {
          _timer?.cancel();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HalamanPDFSoalState(widget.questionlenght,
                  listSelectedOption, widget.color, score, widget.topicType),
            ),
          );
        }
      },
      child: Text(
        _questionNumber < widget.questionlenght.length
            ? 'Selanjutnya'
            : 'Lihat Hasil',
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
      ),
    );
  }
}
