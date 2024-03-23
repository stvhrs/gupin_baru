import 'dart:math';

import 'package:Bupin/ApiServices.dart';
import 'package:Bupin/Halaman_Mapel/Video_Item.dart';

import 'package:Bupin/Halaman_Soal/quiz_screen.dart';
import 'package:Bupin/models/soal.dart';
import 'package:Bupin/styles/PageTransitionTheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HalamanMapel extends StatefulWidget {
  final Color color;
  final String judul;
  final String image;
  HalamanMapel({required this.color, required this.judul, required this.image});

  @override
  State<HalamanMapel> createState() => _HalamanMapelState();
}

Map<dynamic, dynamic> getRandomQuestionsAndOptions(
  List<dynamic> allQuestions,
  int count,
) {
  final randomQuestions = <dynamic>[];
  final randomOptions = <dynamic>[];
  final random = Random();

  if (count >= allQuestions.length) {
    count = allQuestions.length;
  }

  while (randomQuestions.length < count) {
    final randomIndex = random.nextInt(allQuestions.length);
    final selectedQuestion = allQuestions[randomIndex];

    if (!randomQuestions.contains(selectedQuestion)) {
      randomQuestions.add(selectedQuestion);
      randomOptions.add(selectedQuestion.options);
    }
  }

  return Map.fromIterables(randomQuestions, randomOptions);
}

Map<dynamic, dynamic> randomQuestionsMap = getRandomQuestionsAndOptions(
    widgetQuestionsList, widgetQuestionsList.length);

List<dynamic> randomQuestions = randomQuestionsMap.keys.toList();
dynamic randomOptions = randomQuestionsMap.values.toList();

class _HalamanMapelState extends State<HalamanMapel> {
  bool _stretch = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.color,
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              pinned: true,
              stretch: _stretch,
              onStretchTrigger: () async {
                // Triggers when stretching
              },
              // [stretchTriggerOffset] describes the amount of overscroll that must occur
              // to trigger [onStretchTrigger]
              //
              // Setting [stretchTriggerOffset] to a value of 300.0 will trigger
              // [onStretchTrigger] when the user has overscrolled by 300.0 pixels.

              expandedHeight: MediaQuery.of(context).size.width * 0.3,
              collapsedHeight: MediaQuery.of(context).size.width * 0.3,
              backgroundColor: widget.color, foregroundColor: widget.color,
              surfaceTintColor: widget.color,
              flexibleSpace: FlexibleSpaceBar(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                        Icons.arrow_back_rounded,
                        color: Colors.white,
                      ),
                    ),
                    Spacer(),
                    Text(
                      widget.judul,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      "Kelas 12",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                titlePadding: EdgeInsets.only(right: 50, bottom: 20, left: 20),
                background: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(),
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        SizedBox(),
                        Positioned(
                          bottom: -2,
                          child: Image.asset(
                            "asset/Icon/Wave 1.png",
                            width: MediaQuery.of(context).size.width * 0.5,
                            color: Colors.white.withOpacity(0.05),
                          ),
                        ),
                        Image.asset(
                          "asset/Icon/Wave 2.png",
                          width: MediaQuery.of(context).size.width * 0.6,
                          color: Colors.white.withOpacity(0.1),
                        ),
                        Hero(
                            tag: widget.judul,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                widget.image,
                                width: MediaQuery.of(context).size.width * 0.3,
                              ),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return
                    Container(
                      padding: EdgeInsets.only(top: 15,left: 15,right: 15),
                       color: Color.fromARGB(255, 235, 240, 242),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "Persiapan Ujian",
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                              Icon(
                                Icons.local_fire_department_sharp,
                                color: Colors.red,
                                size: 18,
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 15),
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                      top: 8, bottom: 8, left: 8, right: 8),
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: widget.color.withOpacity(0.1),
                                          spreadRadius: 0.5,
                                          blurRadius: 6,
                                          offset: Offset(0,
                                              0), // changes position of shadow
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(3),
                                      color: Colors.white),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(CustomRoute(
                                        builder: (context) => QuizScreen(
                                            color: widget.color,
                                            questionlenght: randomQuestions,
                                            optionsList: randomOptions,
                                            topicType: widget.judul),
                                      ));
                                    },
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 5),
                                          child: Image.asset("asset/uts.png",
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.08,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.08),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 5, right: 5),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "PAT",
                                                style: TextStyle(
                                                    fontSize: 11,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                              Text("Berbasis CBT",
                                                  style:
                                                      TextStyle(fontSize: 10)),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  padding: EdgeInsets.only(
                                      top: 8, bottom: 8, left: 8, right: 8),
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: widget.color.withOpacity(0.1),
                                          spreadRadius: 0.5,
                                          blurRadius: 6,
                                          offset: Offset(0,
                                              0), // changes position of shadow
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(3),
                                      color: Colors.white),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 5),
                                        child: Image.asset(
                                          "asset/uas.png",
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.08,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.08,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(left: 5, right: 5),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "PAS",
                                              style: TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            Text("Berbasis CBT",
                                                style: TextStyle(fontSize: 10)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Spacer(),
                                Spacer(),
                                Spacer(),
                                Spacer()
                              ],
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 5, bottom: 15),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Divider(
                                      color: widget.color.withOpacity(0.8),
                                      thickness: 2,
                                      indent: 5,
                                      endIndent: 10,
                                    ),
                                  ),
                                  Text(
                                    "Video Pembelajaran",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18,
                                        color: widget.color.withOpacity(0.8)),
                                  ),
                                  Expanded(
                                    child: Divider(
                                      color: widget.color.withOpacity(0.8),
                                      thickness: 2,
                                      indent: 10,
                                      endIndent: 5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ), Stack(clipBehavior: Clip.none,children: [
                    Positioned.fill(
                        child: Container(
                      color: Color.fromARGB(255, 237, 240, 247),
                    )),
                    Positioned.fill(
                     
                        child: Image.asset(
                          "asset/bg mapel.png",
                          repeat: ImageRepeat.repeatY,color: widget.color.withOpacity(0.1),
                        ),
                      
                    ), Positioned.fill(
                      child: ColorFiltered(
                        colorFilter: ColorFilter.matrix(<double>[
                          0.2126,
                          0.7152,
                          0.0722,
                          0,
                          0,
                          0.2126,
                          0.7152,
                          0.0722,
                          0,
                          0,
                          0.2126,
                          0.7152,
                          0.0722,
                          0,
                          0,
                          0,
                          0,
                          0,
                          1,
                          0,
                        ]),
                        child: Opacity(opacity: 0.15,
                          child: Image.asset(
                            "asset/bg mapel.png",
                            repeat: ImageRepeat.repeatY,
                          ),
                        ),
                      ),
                    ),
                          Column(children: 
                          List.generate(
                              10,
                              (index) => VideoItem(
                                    "25_TSBl5Y_s",
                                    widget.color,
                                    index,
                                  )))
                        ],
                      )]),
                    );
                 
                },
                childCount: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
