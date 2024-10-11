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
  late bool scanned;
  Barcode? result;
  QRViewController? controller;

  @override
  void dispose() {
    controller?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.height < 400)
        ? MediaQuery.of(context).size.width / 2
        : MediaQuery.of(context).size.width / 2;
    return Consumer<CameraProvider>(builder: (context, data, x) {
      log("consumer");
      if (controller != null && data.scanned == false) {
        controller!.resumeCamera();
      }

      return SafeArea(
        child: Scaffold(
          body: Column(
            children: <Widget>[
              Expanded(
                  flex: 3,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          QRView(
                            key: qrKey,
                            onQRViewCreated: (controller2) {
                              controller = controller2;
                              controller2!.scannedDataStream.listen(
                                (scanData) async {
                                  log(scanData.code.toString());
                                  if (data.scanned == false) {
                                    if (scanData.code!.contains("VID")) {
                                      controller2.pauseCamera();

                                      data.scaning = true;

                                      ApiService()
                                          .pushToVideo(scanData.code!, context);
                                    } else if (scanData.code!.contains("UJN")) {
                                      controller2.pauseCamera();

                                      data.scaning = true;

                                      ApiService()
                                          .pushToCbt(scanData.code!, context);
                                    }
                                  }
                                },
                              );
                            },
                            overlay: QrScannerOverlayShape(
                                borderColor: Theme.of(context).primaryColor,
                                borderRadius: 6,
                                borderLength: 30,
                                borderWidth: 10,
                                cutOutSize: scanArea),
                            onPermissionSet: (ctrl, p) =>
                                _onPermissionSet(context, ctrl, p),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 1.7,
                            height: MediaQuery.of(context).size.width / 1.7,
                            child: const ScanningEffect(
                              enableBorder: false,
                              scanningColor: Colors.white,
                              delay: Duration(seconds: 1),
                              duration: Duration(seconds: 2),
                              child: SizedBox(),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.7,
                        height: MediaQuery.of(context).size.width / 1.7,
                        child: const ScanningEffect(
                          enableBorder: false,
                          scanningColor: Color.fromRGBO(236, 180, 84, 1),
                          delay: Duration(seconds: 1),
                          duration: Duration(seconds: 2),
                          child: SizedBox(),
                        ),
                      ),
                    ],
                  )),
              Expanded(
                flex: 2,
                child: Stack(
                  children: [
                    Image.asset(
                      "asset/Halaman_Scan/Doodle Halaman Scan@4x.png",
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.fitWidth,
                      repeat: ImageRepeat.repeat,
                    ),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton.filled(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white)),
                          color: Colors.white,
                          highlightColor: Colors.grey,
                          onPressed: () {
                            Navigator.pop(context, false);
                          },
                          icon: Icon(
                            Icons.arrow_back_rounded,
                            color: Theme.of(context).primaryColor,
                          )),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            flex: 6,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 0),
                              child: Stack(
                                alignment: Alignment.bottomLeft,
                                children: [
                                  const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Spacer(
                                        flex: 2,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 16),
                                        child: Text(
                                          "Scan",
                                          style: TextStyle(
                                              fontSize: 40,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w900),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 16),
                                        child: Text(
                                          "Akses Video & Soal",
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: Color.fromRGBO(
                                                  236, 180, 84, 1),
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                      Spacer(
                                        flex: 4,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                              flex: 8,
                              child: Image.asset(
                                "asset/Halaman_Scan/Hasan Scan2.png",
                                scale: 0.7,
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
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
