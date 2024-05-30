import 'dart:typed_data';

import 'package:Bupin/ApiServices.dart';
import 'package:Bupin/Generate_Soal_Pdf.dart';
import 'package:Bupin/models/soal.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';

class HalamanPDFSoalState extends StatefulWidget {
  final Color color;
  final List<dynamic> list;
  final List<WiidgetOption> listOption;
  final int skor;
  final String judul;
  const HalamanPDFSoalState(this.list, this.listOption, this.color, this.skor,this.judul);

  @override
  State<HalamanPDFSoalState> createState() => _HalamanPDFSoalStateState();
}

class _HalamanPDFSoalStateState extends State<HalamanPDFSoalState>
    with AutomaticKeepAliveClientMixin {
  void _showPrintedToast(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Document printed successfully'),
      ),
    );
  }

  void _showSharedToast(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Document shared successfully'),
      ),
    );
  }

  List optionsLetters = ["A.", "B.", "C.", "D.", "E."];
  @override
  void initState() {
    if (widget.list[0].options.length == 4) {
      optionsLetters = [
        "A.",
        "B.",
        "C.",
        "D.",
      ];
    }
    super.initState();
  }

  Uint8List? asu;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(title: Text(widget.judul,style: TextStyle(color: Colors.white),),
        backgroundColor: widget.color,
        leading: Padding(
          padding: const EdgeInsets.all(15.0),
          child: GestureDetector(
              onTap: () {
                // controller.pause();
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
        actions: [
          IconButton(
              onPressed: () async {
                await Printing.sharePdf(
                    bytes: asu!, filename: ApiService.user!.jenjang+"_"+widget.judul+".pdf" );
              },
              icon: Icon(
                Icons.share,
                color: Colors.white,
              ))
        ],
      ),
      backgroundColor: Colors.white,
      body: PdfPreview(
        loadingWidget: const Text('Loading...'),
        // onError: (context, error) => const Text('Error...'),
        maxPageWidth: MediaQuery.of(context).size.width,
        pdfFileName: 'Laporan_Bulanan.pdf',
        canDebug: false, allowPrinting: false, actions: [], allowSharing: false,
        build: (format) async {
          asu = await printAllx[0]
              .builder(format, widget.list, widget.listOption, widget.skor);
          return printAllx[0]
              .builder(format, widget.list, widget.listOption, widget.skor);
        },
        onPrinted: _showPrintedToast,
        canChangeOrientation: false,
        canChangePageFormat: false,
        onShared: _showSharedToast,
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
