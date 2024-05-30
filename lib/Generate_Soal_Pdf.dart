import 'dart:async';
import 'dart:typed_data';

import 'package:Bupin/models/soal.dart';
import 'package:Bupin/pdf_soal.dart';
import 'package:pdf/pdf.dart';






const printAllx = [
  PrintAll(printAll, true),
];
class PrintAll {
  const PrintAll(this.builder, [this.needsData = false]);

  final LayoutCallbackWithData9 builder;

  final bool needsData;
}

typedef LayoutCallbackWithData9 = Future<Uint8List> Function(
    PdfPageFormat pageFormat, List<dynamic> list,List<WiidgetOption> listOption,int skor );


