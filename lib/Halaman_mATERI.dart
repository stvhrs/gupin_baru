import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:share_plus/share_plus.dart';

class PDFViewerCachedFromUrl extends StatefulWidget {
  final String bab;
  PDFViewerCachedFromUrl({Key? key, required this.url, required this.color,required this.bab})
      : super(key: key);

  final String url;
  final Color color;
  @override
  State<PDFViewerCachedFromUrl> createState() => _PDFViewerCachedFromUrlState();
}

class _PDFViewerCachedFromUrlState extends State<PDFViewerCachedFromUrl> {
  String _filePath = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
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
                log(_filePath);
                final result = await Share.shareXFiles([XFile('${_filePath}')],
                    text: 'Share PDF');

                if (result.status == ShareResultStatus.success) {
                  print('Thank you for sharing the picture!');
                }
              },
              icon: Icon(
                Icons.share,
                color: Colors.white,
              ))
        ],
        title:  Text(
          'Rangkuman '+widget.bab,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: const PDF().cachedFromUrl(
        whenDone: (filePath) {
          _filePath = filePath;
          // setState(() {

          // });
        },
        widget.url,
        placeholder: (double progress) => Center(child: Text('$progress %')),
        errorWidget: (dynamic error) => Center(child: Text(error.toString())),
      ),
    );
  }
}
