import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

class CameraProvider extends ChangeNotifier {
  late bool scanned;

  QRViewController? controller;
  bool flased = false;
  @override
  dispose() {
    controller?.dispose();
    flased = false;
  }

  set scaning(val) {
    scanned = val;
    log("scanning");
  }

  set setCon(val) {
    controller = val;
    log("set");
    notifyListeners();
  }

  setflash() {
    flased = !flased;
    controller?.toggleFlash();
    log("flash");
    notifyListeners();
  }

  pause() {
    controller!.pauseCamera();
    log("akti pause2");
  }

  resume() {
    controller!.resumeCamera();
    log("akti resume2");
    notifyListeners();
    
  }
}

 
  // saveRecentSoal() {}
  // getRecentSoal() {}