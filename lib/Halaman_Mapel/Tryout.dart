import 'package:Bupin/ApiServices.dart';
import 'package:Bupin/HalamanVideoGupin.dart';
import 'package:Bupin/Halaman_Soal/quiz_screen.dart';
import 'package:Bupin/Halaman_Video.dart';
import 'package:Bupin/models/Video.dart';
import 'package:Bupin/styles/PageTransitionTheme.dart';
import 'package:Bupin/styles/capital.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'package:timeline_tile/timeline_tile.dart';

class TryoutItem extends StatefulWidget {
  final String judul;
  final Color color;
  final List<dynamic> questionlenght;

  final dynamic optionsList;
  TryoutItem(this.judul, this.color, this.questionlenght, this.optionsList);

  @override
  State<TryoutItem> createState() => _TryoutItemState();
}

class _TryoutItemState extends State<TryoutItem> {
  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      alignment: TimelineAlign.start,
      indicatorStyle: IndicatorStyle(
          color: widget.color, padding: EdgeInsets.only(right: 20), width: 11),
      afterLineStyle: LineStyle(color: widget.color, thickness: 5),
      beforeLineStyle: LineStyle(color: widget.color, thickness: 5),
      endChild: Stack(
        alignment: Alignment.topLeft,
        clipBehavior: Clip.none,
        children: [
          InkWell(
            onTap: widget.judul==""?null: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => QuizScreen(
                    color: widget.color,
                    questionlenght: widget.questionlenght,
                    optionsList: widget.optionsList,
                    topicType: widget.judul),
              ));
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 20),
              height: MediaQuery.of(context).size.width * 0.17,
              child: Container(
                // padding: EdgeInsets.all(10),
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 0.5,
                    blurRadius: 5,
                    offset: Offset(0, 0), // changes position of shadow
                  ),
                ], borderRadius: BorderRadius.circular(3), color: Colors.white),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: AnimatedOpacity(
                            duration: const Duration(milliseconds: 500),
                            opacity: widget.judul == "" ? 0 : 1.0,
                            child: Text(
                              widget.judul.toTitleCase(),
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 12,
                              ),
                              overflow: TextOverflow.clip,
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
