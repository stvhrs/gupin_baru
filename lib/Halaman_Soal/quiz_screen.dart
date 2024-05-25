import 'dart:async';

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
    
  const ClipPad({
    this.padding = EdgeInsets.zero
  });
  
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

  void startTimerOnQuestions() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          if (questionTimerSeconds > 0) {
            questionTimerSeconds--;
          } else {
            _timer?.cancel();
            navigateToNewScreen();
          }
        });
      }
    });
  }

  void stopTime() {
    _timer?.cancel();
  }

  void navigateToNewScreen() {
    if (_questionNumber < widget.questionlenght.length) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 100),
        curve: Curves.linear,
      );
      // setState(() {
        _questionNumber++;
        isLocked = false;
      // });
      _resetQuestionLocks();
      startTimerOnQuestions();
    } else {
      _timer?.cancel();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultsScreen(
            score: score,color: widget.color,
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
    startTimerOnQuestions();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
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
        backgroundColor: bgColor3,appBar: PreferredSize(preferredSize: Size.fromHeight(MediaQuery.of(context).size.height*0.2
        ), child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 0, right: 0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 20),
                    child:  
                        Text(
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
                  Padding(
                    padding: const EdgeInsets.only(right: 14, bottom: 10),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            CupertinoIcons.clear,
                            color: Colors.white,
                            weight: 10,
                          ),
                        ),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: TweenAnimationBuilder<double>(
                                duration: const Duration(seconds: 1),
                                curve: Curves.linear,
                                tween: Tween<double>(
                                  begin: 0,
                                  end: 1 - (questionTimerSeconds / 60),
                                ),
                                builder: (context, value, _) =>
                                    LinearProgressIndicator(
                                      minHeight: 20,
                                      value: value,
                                      backgroundColor: Colors.white,
                                      valueColor:
                                          AlwaysStoppedAnimation(bgColor),
                                    )),
                          ),
                        ),
                      ],
                    ),
                  ),
                 ClipRect(
  clipper: const ClipPad(
    padding: EdgeInsets.only( top:30)
  ),
  child:
                     Container(
                      padding:
                          const EdgeInsets.only(top: 10, left: 10, right: 10),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20),),
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
        ),),
        body: 
                           
                             Container(color: Colors.white,padding: EdgeInsets.symmetric(horizontal: 8),
                               child: PageView.builder(
                                  controller: _controller,
                                  physics: const NeverScrollableScrollPhysics(),pageSnapping: false,
                                  itemCount: widget.questionlenght.length,
                                  onPageChanged: (value) {
                                    // setState(() {
                                      _questionNumber = value + 1;
                                      isLocked = false;
                                      _resetQuestionLocks();
                                    // });
                                  },
                                  itemBuilder: (context, index) {
                                    final WidgetQuestion myquestions =
                                        widget.questionlenght[index];
                                    var optionsIndex = widget.optionsList[index];
                               
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ListView(
                                        children: [
                                          myquestions.imageUrl != ""
                                              ? Container(
                                                  alignment: Alignment.center,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(5),
                                                      child:
                                                          FadeInImage.assetNetwork(
                                                        placeholder:
                                                            "asset/loading.png",
                                                        placeholderColor:
                                                            widget.color,
                                                        height:
                                                            MediaQuery.of(context)
                                                                    .size
                                                                    .width *
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
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(
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
                                              final letters = optionsLetters[
                                                  myquestions.options.indexOf(e)];
                                                                     
                                              if (myquestions.isLocked) {
                                                if (questionOption ==
                                                    myquestions
                                                        .selectedWiidgetOption) {
                                                  color = questionOption.isCorrect!
                                                      ? Colors.green
                                                      : Colors.red;
                                                } else if (questionOption
                                                    .isCorrect!) {
                                                  color = Colors.green;
                                                }
                                              }
                                              return InkWell(
                                                onTap: () {
                                                  print(optionsIndex);
                                                  stopTime();
                                                  if (!myquestions.isLocked) {
                                                    setState(() {
                                                      myquestions.isLocked = true;
                                                      myquestions
                                                              .selectedWiidgetOption =
                                                          questionOption;
                                                    });
                                                                     
                                                    isLocked = myquestions.isLocked;
                                                    if (myquestions
                                                        .selectedWiidgetOption!
                                                        .isCorrect!) {
                                                      score++;
                                                    }
                                                  }
                                                },
                                                child: Container(
                                                  padding: const EdgeInsets.all(10),
                                                  margin:
                                                      const EdgeInsets.symmetric(
                                                          vertical: 8),
                                                  decoration: BoxDecoration(
                                                    border:
                                                        Border.all(color: color),
                                                    color: Colors.grey.shade100,
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(10)),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      questionOption.text!
                                                              .contains("https")
                                                          ? Row(
                                                              children: [
                                                                Flexible(
                                                                  child: Text(
                                                                    "$letters",
                                                                    style:
                                                                        const TextStyle(
                                                                            fontSize:
                                                                                16),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          left: 10),
                                                                  child: ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .circular(
                                                                                  5),
                                                                      child: FadeInImage
                                                                          .assetNetwork(
                                                                        placeholder:
                                                                            "asset/loading.png",
                                                                        placeholderColor:
                                                                            widget
                                                                                .color,
                                                                        image: myquestions
                                                                            .imageUrl,
                                                                      )),
                                                                ),
                                                              ],
                                                            )
                                                          : Flexible(
                                                              child: Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Text(
                                      letters,                                                                    style:
                                                                          const TextStyle(
                                                                              fontSize:
                                                                                  16),
                                                                    
                                                                  ),
                                                                  Flexible(
                                                                    child: Padding(
                                                                      padding:
                                                                          const EdgeInsets
                                                                              .only(left: 10,
                                                                              right:
                                                                                  4),
                                                                      child: Text(
                                                                        "${questionOption.text}",
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                16),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                      isLocked == true
                                                          ? questionOption
                                                                  .isCorrect!
                                                              ? const Icon(
                                                                  Icons
                                                                      .check_circle,
                                                                  color:
                                                                      Colors.green,
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
                                              );
                                            }).toList(),
                                          ),
                                          isLocked
                                              ? Center(
                                                  child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(20.0),
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
          startTimerOnQuestions();
        } else {
          _timer?.cancel();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ResultsScreen(
                score: score,color: widget.color,
                totalQuestions: widget.questionlenght.length,
                whichTopic: widget.topicType,
              ),
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
