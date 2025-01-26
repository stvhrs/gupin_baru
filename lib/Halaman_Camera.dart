import 'dart:developer';
import 'dart:io';

import 'package:Bupin/ApiServices.dart';
import 'package:Bupin/camera_provider.dart';
import 'package:Bupin/widgets/scann_aniamtion/scanning_effect.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRViewExample extends StatefulWidget {
  final bool scanned;
  const QRViewExample(this.scanned, {super.key});

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  @override
  void initState() {
    if (mounted) {
      NetworkInfo.checkConnectivity(context);
    }
    log("init");
    Provider.of<CameraProvider>(context, listen: false).scaning = false;

    super.initState();
  }

  late bool scanned;
  Barcode? result;
  @override
  void dispose() {
    // if (mounted) {
    //   Provider.of<CameraProvider>(context, listen: false).dispose();
    // }
    super.dispose();
  }

  // @override
  // didChangeDependencies() {
  //   log("didchange");
  //   Provider.of<CameraProvider>(context, listen: false).scaning = false;
  //   log(Provider.of<CameraProvider>(context, listen: false).scanned.toString() +
  //       "now");
  //   if (Provider.of<CameraProvider>(context, listen: false).controller !=
  //           null &&
  //       Provider.of<CameraProvider>(context, listen: false).scanned == false) {
  //     Provider.of<CameraProvider>(context, listen: false).resume();
  //   }
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.height < 400)
        ? MediaQuery.of(context).size.width / 1.3
        : MediaQuery.of(context).size.width / 1.3;
    return Consumer<CameraProvider>(builder: (context, data, x) {
      // log("consumer");
      // if (data.controller != null && data.scanned == false) {
      //   data.controller!.resumeCamera();
      // }

      return Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      QRView(
                        key: qrKey,
                        onQRViewCreated: (controller2) {
                          data.setCon = controller2;
                          data.controller?.scannedDataStream.listen(
                            (scanData) async {
                              log(scanData.code.toString());
                              if (data.scanned == false) {
                                if (scanData.code!.contains("VID")) {
                                  data.pause();
                                  data.scaning = true;

                                  ApiService()
                                      .pushToVideo(scanData.code!, context);
                                } else if (scanData.code!.contains("UJN")) {
                                  data.pause();

                                  data.scaning = true;

                                  ApiService()
                                      .pushToCbt(scanData.code!, context);
                                }
                              }
                            },
                          );
                        },
                        overlay: QrScannerOverlayShape(
                            overlayColor: Colors.black.withOpacity(0.7),
                            borderColor: Colors.white,
                            borderRadius: 12,
                            borderLength: 144.4,
                            borderWidth: 3,
                            cutOutSize: scanArea),
                        onPermissionSet: (ctrl, p) =>
                            _onPermissionSet(context, ctrl, p),
                      ),
                      Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                                top: 48, bottom: 16, left: 16, right: 16),
                            child: Center(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      icon: const Icon(
                                        Icons.arrow_back_rounded,
                                        color: Colors.white,
                                      )),
                                  const Text(
                                    "Scan Qr",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.white),
                                  ),
                                  IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.arrow_back_rounded,
                                        color: Colors.transparent,
                                      )),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 26.0),
                            margin: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 26.0),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.25),
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                    flex: 1,
                                    child: Image.asset(
                                      "asset/Points.png",
                                      width: 20,
                                      color: Colors.white,
                                    )),
                                const Flexible(
                                  flex: 6,
                                  child: Text(
                                    'Scan QR di buku belajar Bupin dan dapatkan 100 points!',
                                    style: TextStyle(
                                      color: Colors.white, // Text color
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          const Spacer(),
                          const Spacer(),
                          const Spacer(),
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.white,
                            child: IconButton(
                              onPressed: () {
                                data.setflash();
                              },
                              icon: Icon(data.flased
                                  ? IconsaxPlusBold.flash_1
                                  : IconsaxPlusLinear.flash_1),
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ],
                  ),

                  // SizedBox(
                  //   width: MediaQuery.of(context).size.width / 1.2,
                  //   height: MediaQuery.of(context).size.width / 1.2,
                  //   child:  ScannerAnimation(
                  //   false,
                  //    MediaQuery.of(context).size.width / 1.2,,
                  //   animation: _animationController as Animation<double>,
                  // ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}

final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
  log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
  if (!p) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('no Permission')),
    );
  }
}

class ScannerAnimation extends AnimatedWidget {
  final bool stopped;
  final double width;

  const ScannerAnimation(
    this.stopped,
    this.width, {
    super.key,
    required Animation<double> animation,
  }) : super(
          listenable: animation,
        );

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable as Animation<double>;
    final scorePosition = (animation.value * 440) + 16;

    Color color1 = Color(0x5532CD32);
    Color color2 = Color(0x0032CD32);

    if (animation.status == AnimationStatus.reverse) {
      color1 = Color(0x0032CD32);
      color2 = Color(0x5532CD32);
    }

    return Positioned(
      bottom: scorePosition,
      left: 16.0,
      child: Opacity(
        opacity: (stopped) ? 0.0 : 1.0,
        child: Container(
          height: 60.0,
          width: width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.1, 0.9],
              colors: [color1, color2],
            ),
          ),
        ),
      ),
    );
  }
}
