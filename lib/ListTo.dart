import 'dart:math';

import 'package:Bupin/ApiServices.dart';
import 'package:Bupin/Halaman_Mapel/Tryout.dart';
import 'package:Bupin/Halaman_Soal/quiz_screen.dart';
import 'package:Bupin/models/To.dart';
import 'package:Bupin/models/soal.dart';
import 'package:Bupin/styles/PageTransitionTheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListTo extends StatefulWidget {
  final Color color;
  final bool ptsorpas;
  final String mapel;
  const ListTo(this.color, this.ptsorpas, this.mapel);

  @override
  State<ListTo> createState() => _ListToState();
}

class _ListToState extends State<ListTo> {
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
      final WidgetQuestion selectedQuestion = allQuestions[randomIndex];

      if (!randomQuestions.contains(selectedQuestion)) {
        randomQuestions.add(selectedQuestion);
        randomOptions.add(selectedQuestion.options);
      }
    }

    return Map.fromIterables(
        randomQuestions..shuffle(), randomOptions..shuffle());
  }

  @override
  Widget build(BuildContext context) {
    List<TryOut> tryoutku = ApiService.listTryout!
        .where((element) => element.color == widget.color)
        .toList();

    return Scaffold(
      backgroundColor:Color.fromARGB(255, 237, 240, 247),
      appBar: AppBar(
        backgroundColor: widget.color, leading: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context, false);
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Center(
                                  child: Icon(
                                    Icons.arrow_back_rounded,
                                    color: widget.color,
                                    size: 15,
                                    weight: 100,
                                  ),
                                ),
                              )),
                        ),
        title: Text(
          widget.ptsorpas
              ? "PTS ${widget.mapel}"
              : "PAS ${widget.mapel}",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: [                              Positioned.fill(
                                  child: Container(
                                color: Color.fromARGB(255, 237, 240, 247),
                              )),
                              
                              Positioned.fill(
                                child:   Image.asset(
                                      "asset/Halaman_Scan/Doodle Halaman Scan@4x.png",color: widget.color,
                                      repeat: ImageRepeat.repeatY,
                                    
                                  
                                ),
                              ),
          ListView.builder(padding: EdgeInsets.all(15),
            itemCount: tryoutku.length,
            itemBuilder: (context, index) => FutureBuilder(
                future: ApiService()
                    .getToDetail(tryoutku[index].idmapel!, widget.ptsorpas),
                builder: (context, snapshot) { 
                  
                
                   if(snapshot.connectionState == ConnectionState.waiting){ 
                    
                    return TryoutItem("", widget.color,[],[]);}else{   Map<dynamic, dynamic> randomQuestionsMap =
                                getRandomQuestionsAndOptions(
                                    snapshot.data!, snapshot.data!.length);
          
                            List<dynamic> randomQuestions =
                                randomQuestionsMap.keys.toList();
                            dynamic randomOptions =
                                randomQuestionsMap.values.toList();
                    return  TryoutItem(tryoutku[index].namaMapel!, widget.color,randomQuestions,randomOptions);
                                }
                     
                }),
          ),
        ],
      ),
    );
  }
}
