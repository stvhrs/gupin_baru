import 'dart:async';
import 'dart:developer';
import 'dart:typed_data';

import 'package:Bupin/ApiServices.dart';
import 'package:Bupin/Halaman_Mapel/Tryout.dart';
import 'package:Bupin/camera_provider.dart';
import 'package:Bupin/helper/capital.dart';

import 'package:Bupin/models/soal_scan.dart';
import 'package:Bupin/pdf_v2.dart';
import 'package:Bupin/widgets/image_memory.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert';

import 'package:provider/provider.dart';

Image imageFromBase64String(String base64String) {
  return Image.memory(base64Decode(base64String));
}

Uint8List dataFromBase64String(String base64String) {
  return base64Decode(base64String);
}

String base64String(Uint8List data) {
  return base64Encode(data);
}

class HalamanSoal extends StatefulWidget {
  final String link;
  const HalamanSoal({super.key, required this.link});

  @override
  State<HalamanSoal> createState() => _HalamanSoalState();
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

class _HalamanSoalState extends State<HalamanSoal> {
  Quiz? data;
  int _questionNumber = 1;
  PageController _controller = PageController();
  List optionsLetters = ["A.", "B.", "C.", "D.", "E."];
  List<WiidgetOption> listSelectedOption = [];
  bool loading = true;
  WiidgetOption? _selcteed;
  @override
  void initState() {
    getUjian();
    super.initState();
    _controller = PageController(initialPage: 0);
  }

  getUjian() async {
    data = await ApiService.getUjian(widget.link);

    loading = false;
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () {
        Provider.of<CameraProvider>(context, listen: false).scaning = false;
       
        Navigator.of(context).pop();
        return Future.value(true);
      },
      child: Scaffold(
        bottomNavigationBar: loading
            ? SizedBox()
            : Container(
                padding: EdgeInsets.only(bottom: 50),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          if (_questionNumber >= 1) {
                            _controller.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                            setState(() {
                              _questionNumber--;
                            });
                          }
                        },
                        child: Text(
                          _questionNumber == 1 ? "Kembali" : 'Prev',
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.orange),
                          fixedSize: MaterialStateProperty.all(
                            Size(MediaQuery.sizeOf(context).width * 0.40, 40),
                          ),
                          elevation: MaterialStateProperty.all(4),
                        )),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(_selcteed == null
                                ? Colors.grey
                                : _questionNumber < data!.questions.length
                                    ? Theme.of(context).primaryColor
                                    : Colors.green),
                        fixedSize: MaterialStateProperty.all(
                          Size(MediaQuery.sizeOf(context).width * 0.40, 40),
                        ),
                        elevation: MaterialStateProperty.all(4),
                      ),
                      onPressed: _selcteed == null
                          ? null
                          : () {
                              if (_questionNumber < data!.questions.length) {
                                _controller.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                                setState(() {
                                  _questionNumber++;
                                  _selcteed = null;
                                });
                              } else {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HalamanPDFSoalState(
                                        data!,
                                        data!.namaBab,
                                       
                                  ),
                                ));
                              }
                            },
                      child: Text(
                        _questionNumber < data!.questions.length
                            ? 'Next'
                            : 'Lihat Hasil',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
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
                                  Provider.of<CameraProvider>(context,
                                          listen: false)
                                      .scaning = false;
                               

                                  Navigator.of(context).pop();
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
                              left: 10,
                            ),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: Text(
                                data?.namaBab.toTitleCase() ?? "",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400),
                                overflow: TextOverflow.ellipsis,
                              ),
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
                              loading
                                  ? ""
                                  : "Pertanyaan  $_questionNumber/${data?.questions.length ?? "0"}",
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
        body: loading
            ? Container(
                color: Colors.white,
                child: Center(
                  child: CircularProgressIndicator(),
                ))
            : Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: PageView.builder(
                  controller: _controller,
                  physics: const NeverScrollableScrollPhysics(),
                  pageSnapping: false,
                  itemCount: data!.questions.length,
                  onPageChanged: (value) {
                    // setState(() {
                    _questionNumber = value + 1;

                    // });
                  },
                  itemBuilder: (context, index) {
                    final WidgetQuestion myquestions = data!.questions[index];

                    return ListView(
                        padding: const EdgeInsets.all(8.0),
                        children: [
                          //  HtmlWidget(myquestions.htmlText),
                          ...myquestions.text
                              .map(
                                (e) => e.contains("image/png")
                                    ? Base64Image(e)
                                    : Text(e,style: TextStyle(fontSize: 16),),
                              )
                              .toList(),
                          const SizedBox(
                            height: 25,
                          ),
                          ...myquestions.options.map((e) {
                            var color = Colors.grey.shade200;

                            var questionOption = e;
                            String letters =
                                optionsLetters[myquestions.options.indexOf(e)];

                            return (questionOption.text!.isEmpty &&
                                        letters == "E." ||
                                    questionOption.text!.isEmpty &&
                                        letters == "D.")
                                ? SizedBox()
                                : InkWell(
                                    onTap: () {
                                      _selcteed = questionOption;
                                      setState(() {
                                        myquestions.selectedWiidgetOption =
                                            questionOption;
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1.3,
                                            color: myquestions
                                                        .selectedWiidgetOption ==
                                                    questionOption
                                                ? Colors.green
                                                : color),
                                        color: Colors.grey.shade100,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      child: Center(
                                        child: Row(
                                          // crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Align(
                                              alignment: Alignment.topCenter,
                                              child: Text(
                                                "$letters",
                                                style: const TextStyle(
                                                    fontSize: 16),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, right: 4),
                                                child: questionOption.text!
                                                        .contains(
                                                            "data:image/png;base64,")
                                                    ? Base64Image(
                                                        questionOption.text!)
                                                    : Text(
                                                        questionOption.text!,style: TextStyle(fontSize: 16),
                                                      ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                          }).toList(),
                        ]);
                  },
                ),
              ),
      ),
    );
  }
}
