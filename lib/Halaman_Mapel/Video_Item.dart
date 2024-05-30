import 'package:Bupin/ApiServices.dart';
import 'package:Bupin/HalamanVideoGupin.dart';
import 'package:Bupin/Halaman_Video.dart';
import 'package:Bupin/Halaman_mATERI.dart';
import 'package:Bupin/models/Video.dart';
import 'package:Bupin/styles/capital.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class VideoItem extends StatefulWidget {
  final Video video;
  final String pdfUrl;
  final String judul;
  final Color color;
  VideoItem(this.video, this.judul, this.color, this.pdfUrl);

  @override
  State<VideoItem> createState() => _VideoItemState();
}

class _VideoItemState extends State<VideoItem> {
  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      alignment: TimelineAlign.start,
      indicatorStyle: IndicatorStyle(
          color: widget.color, padding: EdgeInsets.only(right: 20), width: 11),
      afterLineStyle: LineStyle(color: widget.color, thickness: 5),
      beforeLineStyle: LineStyle(color: widget.color, thickness: 5),
      endChild: Container(
              margin: EdgeInsets.only(bottom: 35),

        child: Column(
          children: [
            InkWell(
              onTap: widget.judul == ""
                  ? () {}
                  : () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => GupinVideo(
                          widget.video.linkVideo!,
                          widget.color,
                          widget.judul.toTitleCase(),
                        ),
                      ));
                    },
              child: Container(
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
                  ], borderRadius: BorderRadius.circular(8), color: Colors.white),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(3.0),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                widget.judul == ""
                                    ? Image.asset(
                                        "asset/loading.png",
                                        color: widget.color,
                                      )
                                    : FadeInImage.assetNetwork(
                                        placeholder: "asset/loading.png",
                                        placeholderColor: widget.color,
                                        image: widget.video.thumbnail,
                                      ),
                              ],
                            )),
                      ),
                      Expanded(
                        child: Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: AnimatedOpacity(
                              duration: const Duration(milliseconds: 1000),
                              opacity: widget.judul == "" ? 0 : 1.0,
                              child: Text(
                                widget.judul == ""
                                    ? ""
                                    : widget.judul.toTitleCase(),
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
            Container(width: 3,height:5,color: widget.color,),
            InkWell(
              child:Container(width: MediaQuery.of(context).size.width*0.4,
                   padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 0.5,
                      blurRadius: 5,
                      offset: Offset(0, 0), // changes position of shadow
                    ),
                  ], borderRadius: BorderRadius.circular(8), color: Colors.white),
                  child:
                 Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                   children: [Icon(Icons.collections_bookmark_rounded,color: widget.color,)
,                     Text("Rangkuman",style: TextStyle(fontSize: 12),),
                   ],
                 ),
              ),
              onTap:widget.pdfUrl == ""
                  ? () {}
                  :  () {

                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      PDFViewerCachedFromUrl(url: widget.pdfUrl,color: widget.color,bab: widget.judul,),
                ));

              },
            )
          ],
        ),
      ),
    );
  }
}
