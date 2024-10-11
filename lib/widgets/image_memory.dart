import 'dart:convert';

import 'package:flutter/material.dart';

class Base64Image extends StatefulWidget {
  final String image;
  const Base64Image(this.image);

  @override
  State<Base64Image> createState() => _Base64ImageState();
}

class _Base64ImageState extends State<Base64Image>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Center(
      child: Image.memory(
        base64Decode(
          widget.image
              .replaceAll("data:image/png;base64,", "")
             
        ),
        height: MediaQuery.of(context).size.width * 9 / 16,
        gaplessPlayback: true,
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
