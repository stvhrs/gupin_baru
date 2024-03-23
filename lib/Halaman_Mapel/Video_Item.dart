import 'package:Bupin/ApiServices.dart';
import 'package:Bupin/Halaman_Video.dart';
import 'package:Bupin/styles/PageTransitionTheme.dart';

import 'package:flutter/material.dart';

import 'package:timeline_tile/timeline_tile.dart';

class VideoItem extends StatefulWidget {
  final String ytId;
  final Color color;
  final int bab;

  VideoItem(
    this.ytId,
    this.color,
    this.bab,
  );

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
      isFirst: widget.bab == 0,
      isLast: widget.bab == 9,
      afterLineStyle: LineStyle(color: widget.color, thickness: 5),
      beforeLineStyle: LineStyle(color: widget.color, thickness: 5),
      endChild: Stack(
        alignment: Alignment.topLeft,
        clipBehavior: Clip.none,
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(CustomRoute(
                builder: (context) => HalamanVideo(
                  link: "https://buku.bupin.id/?VID-383985.264738031829804",
                  color: widget.color,
                ),
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
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(3.0),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              FutureBuilder(
                                  future: ApiService.getThumnial(widget.ytId),
                                  builder: (context, snapshot) {
                                    return FadeInImage(
                                        fit: BoxFit.fitWidth,
                                        placeholder:
                                            AssetImage('asset/place.png'),
                                        image: snapshot.data != null
                                            ? NetworkImage(snapshot.data!)
                                            : (AssetImage('asset/place.png')
                                                as ImageProvider));
                                  }),
                              Icon(
                                Icons.play_circle_outline_rounded,
                                color: Colors.white,
                              )
                            ],
                          )),
                    ),
                    Expanded(
                      child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(
                            "Tembung Mocopat Guru Gatra",
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: 12,
                            ),
                            overflow: TextOverflow.clip,
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                    padding:
                        EdgeInsets.only(top: 2, bottom: 2, right: 3, left: 3),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: widget.color),
                    child: Text(
                      "Bab ${widget.bab}",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w700),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
