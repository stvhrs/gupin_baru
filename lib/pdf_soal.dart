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

import 'dart:async';
import 'dart:developer';
import 'package:Bupin/models/soal.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

PdfColor green = PdfColor.fromHex("009933");

PdfColor red = PdfColor.fromHex("ff0000");

Future<Uint8List> printAll(PdfPageFormat format, List<dynamic> as,
    List<WiidgetOption> listSelectedOption, int skor) async {
  final document = pw.Document();
  // pw.TextStyle bold = pw.TextStyle(fontWeight: pw.FontWeight.bold);
  // pw.TextStyle bold2 =
  //     pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold);
  // pw.TextStyle small = const pw.TextStyle(fontSize: 10);
  pw.ImageProvider asu = pw.MemoryImage(
    (await rootBundle.load('asset/logo.png')).buffer.asUint8List(),
  );
  //  pw.ImageProvider v = pw.MemoryImage(
  //   (await rootBundle.load('asset/v.png')).buffer.asUint8List(),
  // );
  //  pw.ImageProvider x = pw.MemoryImage(
  //   (await rootBundle.load('asset/x.png')).buffer.asUint8List(),
  // );
  List optionsLetters = ["A.", "B.", "C.", "D.", "E."];

  final double percentageScore = (skor / as.length) * 100;

  final int roundedPercentageScore = percentageScore.round();
  document.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(10),
      build: ((pw.Context context) {
        final int betul = skor;
        final int salah = as.length - betul;

        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          mainAxisAlignment: pw.MainAxisAlignment.center,
          children: [
            pw.Container(
                alignment: pw.Alignment.center,
                padding: pw.EdgeInsets.all(0),
                child: pw.Text(
                  "Skor Anda ",
                  style: pw.TextStyle(
                      fontSize: 30,
                      fontWeight: pw.FontWeight.bold,
                      color: roundedPercentageScore >= 75 ? green : red),
                )),
            pw.Container(
              alignment: pw.Alignment.center,
              padding: pw.EdgeInsets.all(5),
              child: pw.Text(
                "$roundedPercentageScore",
                style: pw.TextStyle(
                    fontSize: 150,
                    fontWeight: pw.FontWeight.bold,
                    color: roundedPercentageScore >= 75 ? green : red),
              ),
            ),
            pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      children: [
                        pw.Container(
                            padding: pw.EdgeInsets.all(0),
                            child: pw.Text(
                              "Benar  ",
                              style: pw.TextStyle(
                                fontSize: 25,
                              ),
                            )),
                        pw.Container(
                            padding: pw.EdgeInsets.all(0),
                            child: pw.Text(
                              betul.toString(),
                              style: pw.TextStyle(fontSize: 25, color: green),
                            )),
                      ]),
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      children: [
                        pw.Container(
                            padding: pw.EdgeInsets.all(0),
                            child: pw.Text(
                              "Salah  ",
                              style: pw.TextStyle(
                                fontSize: 25,
                              ),
                            )),
                        pw.Container(
                            padding: pw.EdgeInsets.all(0),
                            child: pw.Text(
                              salah.toString(),
                              style: pw.TextStyle(fontSize: 25, color: red),
                            )),
                      ]),
                ])
          ],
        );
      })));
  los(List<dynamic> data, List<dynamic> dataOption) async {
    document.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(10),
        build: ((pw.Context context) {
          return pw.Stack(alignment: pw.Alignment.center, children: [
            pw.Opacity(
              opacity: 0.2,
              child: pw.Image(asu, width: 300),
            ),
            pw.Container(
                child: pw.Container(
                    decoration: pw.BoxDecoration(border: pw.Border.all()
                        // color: Colors.red.shade600
                        ),
                    // elevation:1,
                    // color: Colors.white, surfaceTintColor: Colors.grey.shade500,
                    // shadowColor: Theme.of(context).colorScheme.primary,
                    child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        mainAxisSize: pw.MainAxisSize.max,
                        children: [
                          ...data.mapIndexed((index, element) {
                            final WidgetQuestion myquestions = data[index];

                            return pw.Container(
                              margin: pw.EdgeInsets.all(5),
                              padding: const pw.EdgeInsets.only(
                                top: 20,
                                left: 20,
                              ),
                              child: pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Text(
                                    "No. " +
                                        (as.indexOf(myquestions) + 1)
                                            .toString(),
                                    style: pw.TextStyle(
                                        fontSize: 11,
                                        fontWeight: pw.FontWeight.bold),
                                  ),
                                  // myquestions.imageUrl != ""
                                  //                           ? pw.Container(
                                  //                               alignment:pw. Alignment.center,
                                  //                               child: pw.Padding(
                                  //                                 padding:
                                  //                                     const pw.EdgeInsets.all(8),
                                  //                                 child: pw.ClipRRect(

                                  //                                   child:
                                  //                                     pw.  Image(
                                  //                                   netImage
                                  //                                   ),
                                  //                                 ),
                                  //                               ),
                                  //                             )
                                  //                           : pw.SizedBox(),
                                  pw.Padding(
                                    padding:
                                        const pw.EdgeInsets.only(bottom: 10),
                                    child: pw.Text(
                                      myquestions.text,
                                      style: pw.TextStyle(fontSize: 11),
                                    ),
                                  ),

                                  // ...myquestions.options.map((e) {

                                  //   return Text(e.toString());}).toList()

                                  pw.Column(
                                    children:
                                        myquestions.options.mapIndexed((i, e) {
                                      final letters = optionsLetters[
                                          myquestions.options.indexOf(e)];
                                      var questionOption = e;

                                      return pw.Container(
                                        child: pw.Container(
                                          margin: const pw.EdgeInsets.symmetric(
                                              vertical: 3),
                                          decoration: pw.BoxDecoration(
                                            borderRadius:
                                                const pw.BorderRadius.all(
                                                    pw.Radius.circular(10)),
                                          ),
                                          child: pw.Row(
                                            crossAxisAlignment:
                                                pw.CrossAxisAlignment.start,
                                            children: [
                                              pw.Text(
                                                "$letters",
                                                style: const pw.TextStyle(
                                                    fontSize: 11),
                                              ),
                                              // questionOption.text!.contains("https")
                                              //     ? pw.Flexible(
                                              //         child:pw. Padding(
                                              //           padding:
                                              //               const pw.EdgeInsets.only(left: 10),
                                              //           child: pw.ClipRRect(

                                              //               child: Image.network(
                                              //                   questionOption.text!)),
                                              //         ),
                                              //       )
                                              //     :

                                              pw.Flexible(
                                                child: pw.Padding(
                                                  padding: pw.EdgeInsets.only(
                                                      left: 10, right: 4),
                                                  child: pw.Text(
                                                    "${questionOption.text}",
                                                    style: pw.TextStyle(
                                                        fontSize: 11),
                                                  ),
                                                ),
                                              ),

                                              (questionOption.isCorrect!)
                                                  ? pw.Text(
                                                      " Benar",
                                                      style: pw.TextStyle(
                                                          fontSize: 11,
                                                          color: green),
                                                    )
                                                  : (questionOption ==
                                                          dataOption[index])
                                                      ? pw.Text(
                                                          " Salah",
                                                          style: pw.TextStyle(
                                                              fontSize: 11,
                                                              color: red),
                                                        )
                                                      : pw.SizedBox()
                                            ],
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            );
                          }).toList()
                        ])))
          ]);
        })));
  }

  List<dynamic> temp = [];
  temp.addAll(as);
  List<dynamic> temp2 = [];
  temp2.addAll(listSelectedOption);

  for (var i = 0; i < as.length; i++) {
    if (i % 5 == 0 && i > 0) {
      los(as.getRange(i - 5, i).toList(),
          listSelectedOption.getRange(i - 5, i).toList());
      for (var element in as.getRange(i - 5, i).toList()) {
        temp.remove(element);
       
      }
      for (var element in listSelectedOption.getRange(i - 5, i).toList()) {
       temp2.remove(element);
      }
    } else if (i + 1 == listSelectedOption.length && i % 5 != 0) {
      log(temp.length.toString());
      log(temp2.length.toString());
      los(temp, temp2);
    }
  }
  return await document.save();
}
