/*
 * Copyright (C) 3017, David PHAM-VAN <dev.nfet.net@gmail.com>
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
import 'package:Bupin/models/soal_scan.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:Bupin/helper/helper.dart';
import 'package:Bupin/models/soal.dart';
import 'package:collection/collection.dart';
import 'package:flutter/services.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import 'package:printing/printing.dart';

PdfColor green = PdfColor.fromHex("009933");

PdfColor red = PdfColor.fromHex("ff0000");

Future<Uint8List> printAll2(
  Quiz quiz,
) async {
  final document = Document();
  // TextStyle bold = TextStyle(fontWeight: FontWeight.bold);
  // TextStyle bold2 =
  //     TextStyle(fontSize: 15, fontWeight: FontWeight.bold);
  // TextStyle small = const TextStyle(fontSize: 10);
  ImageProvider asu = MemoryImage(
    (await rootBundle.load('asset/logo.png')).buffer.asUint8List(),
  );
  //  ImageProvider v = MemoryImage(
  //   (await rootBundle.load('asset/v.png')).buffer.asUint8List(),
  // );
  //  ImageProvider x = MemoryImage(
  //   (await rootBundle.load('asset/x.png')).buffer.asUint8List(),
  // );
  List optionsLetters = ["A.", "B.", "C.", "D.", "E."];

  final double percentageScore = (quiz.questions
              .where(
                (element) => element.selectedWiidgetOption!.isCorrect!,
              )
              .toList()
              .length /
          quiz.questions.length) *
      100;
  List<Widget> widgets = [];

  final theme = ThemeData.withFont(
    base: await PdfGoogleFonts.amiriRegular(),
  );
  widgets.add(Padding(
      padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 5),
      child: Column(children: [
        Divider(),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Image(asu, width: 60),
          Text(quiz.namaBab,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic)),
          Text(percentageScore.round().toString(),
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: percentageScore.round() < 76 ? red : green)),
        ]),
        Divider(thickness: 2),
      ])));
  for (var i = 0; i < quiz.questions.length; i++) {
    log("message");
    var data = quiz.questions[i];
    widgets.add(Container(
        child: Container(
            decoration: BoxDecoration(
                // color: Colors.red.shade600
                ),
            // elevation:1,
            // color: Colors.white, surfaceTintColor: Colors.grey.shade500,
            // shadowColor: Theme.of(context).colorScheme.primary,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    margin: EdgeInsets.all(5),
                    padding:
                        const EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "No. " +
                              (quiz.questions.indexOf(data) + 1).toString(),
                          style: TextStyle(
                              fontSize: 11, fontWeight: FontWeight.bold),
                        ),
                        ...data.text.map((e) {
                          return e.contains("data")
                              ? Image(
                                  MemoryImage(base64Decode(e.replaceAll(
                                      "data:image/png;base64,", ""))),
                                  width: 300)
                              : Helper.containsArabic(e)
                                  ? Text(Helper.extractArabic(e),
                                      textDirection: TextDirection.rtl)
                                  : Text(e);
                        }).toList(),
                        Column(
                          children: data.options.mapIndexed((j, e) {
                            final letters =
                                optionsLetters[data.options.indexOf(e)];
                            var questionOption = e;

                            return (questionOption.text!.isEmpty &&
                                        letters == "E." ||
                                    questionOption.text!.isEmpty &&
                                        letters == "D.")
                                ? SizedBox()
                                : Container(
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 0),
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "$letters",
                                            style:
                                                const TextStyle(fontSize: 11),
                                          ),
                                          questionOption.text!.contains("data")
                                              ? Flexible(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    child: ClipRRect(
                                                        child: Image(
                                                            MemoryImage(base64Decode(
                                                                questionOption
                                                                    .text!
                                                                    .replaceAll(
                                                                        "data:image/png;base64,",
                                                                        ""))),
                                                            width: 100)),
                                                  ),
                                                )
                                              : Flexible(
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 10, right: 4),
                                                    child: Text(
                                                      "${questionOption.text}",
                                                      style: TextStyle(
                                                          fontSize: 11),
                                                    ),
                                                  ),
                                                ),
                                          (questionOption.isCorrect!)
                                              ? Text(
                                                  " Benar",
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      color: green),
                                                )
                                              : (questionOption ==
                                                      quiz.questions
                                                          .map(
                                                            (e) => e
                                                                .selectedWiidgetOption,
                                                          )
                                                          .toList()[i])
                                                  ? Text(
                                                      " Salah",
                                                      style: TextStyle(
                                                          fontSize: 11,
                                                          color: red),
                                                    )
                                                  : SizedBox()
                                        ],
                                      ),
                                    ),
                                  );
                          }).toList(),
                        ),
                      ],
                    ),
                  )
                ]))));
  }
  document.addPage(
    MultiPage(
      pageTheme: PageTheme(
        theme: theme,
        margin: EdgeInsets.all(10),
        clip: true,
        pageFormat: PdfPageFormat.a4,
      ),

      build: (context) => widgets, //here goes the widgets list
    ),
  );
  return await document.save();
}
