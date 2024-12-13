import 'dart:convert';
import 'dart:developer';

import 'package:Bupin/Halaman_Soal.dart';
import 'package:Bupin/Halaman_Video.dart';
import 'package:Bupin/PageTransitionTheme.dart';
import 'package:Bupin/models/Het.dart';
import 'package:Bupin/models/Mapel.dart';
import 'package:Bupin/models/To.dart';
import 'package:Bupin/models/User.dart';
import 'package:Bupin/models/Video.dart';
import 'package:Bupin/models/soal.dart';
import 'package:Bupin/models/soal_scan.dart' as v2;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

const List<String> list = <String>[
  'SD/MI  I',
  'SD/MI  II',
  'SD/MI  III',
  'SD/MI  IV',
  'SD/MI  V',
  'SD/MI  VI',
  'SMP/MTS  VII',
  "SMP/MTS  VIII",
  "SMP/MTS  IX",
  "SMA/MA  X",
  "SMA/MA  XI",
  "SMA/MA  XII"
];
const List<String> listKelas = <String>[
  'I',
  'II',
  'III',
  'IV',
  'V',
  'VI',
  'VII',
  "VIII",
  "IX",
  "X",
  "XI",
  "XII"
];

class ApiService {
  static User? user;
  static List<Mapel>? listMapel;

  static List<TryOut>? listTryout;
  Future<List<Het>> fetchHet(String dropdownValue) async {
    try {
      List<Het> listHet = [];
      final dio = Dio();
      int data = list.indexOf(dropdownValue);
      final response =
          await dio.get("https://bupin.id/api/het?kelas=${listKelas[data]}");

      if (response.statusCode == 200) {
        for (Map<String, dynamic> element in response.data) {
          listHet.add(Het.fromMap(element));
        }

        return listHet;
      }
      {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<String> fetchCs() async {
    try {
      final dio = Dio();

      final response = await dio.get("https://bupin.id/api/cs/");

      if (response.statusCode == 200) {
        return response.data[0]["num"];
      }
      {
        return "6282171685885";
      }
    } catch (e) {
      return "6282171685885";
    }
  }

  static Future<Map<String, dynamic>> checkBanner() async {
    try {
      final dio = Dio();
      final response = await dio.get("https://bupin.id/api/banner/");

      return response.data[0];
    } catch (e) {
      return {};
    }
  }

  static Future<String> getThumnial(String link) async {
    final dio = Dio();
    String id = link.replaceAll("https://www.youtube.com/watch?v=", "");
    final response = await dio.get(
        "https://www.googleapis.com/youtube/v3/videos?part=snippet&id=${id}&key=AIzaSyDgsDwiV1qvlNa7aes8aR1KFzRSWLlP6Bw");

    return (response.data["items"][0]["snippet"]["thumbnails"]["medium"]["url"]
        as String);
  }

  static Future<bool> isVertical(String video) async {
    log(video);
    final dio = Dio();
    final response = await dio.get(
        "https://www.googleapis.com/youtube/v3/videos?part=snippet&id=${video}&key=AIzaSyDgsDwiV1qvlNa7aes8aR1KFzRSWLlP6Bw");
    log(response.data["items"].toString());
    if ((response.data["items"][0]["snippet"]["localized"]["description"]
            as String)
        .contains("ctv")) {
      return true;
    }
    {
      return false;
    }
  }

 
  static Future<v2.Quiz> getUjian(String link) async {
    log(link);
    final dio = Dio();
    String newLink =
        link.replaceRange(0, 22, "https://buku.bupin.id/api/ujn.php");
    log(newLink);
    final response = await dio.get(newLink);

    String jenjang = "sd";
    if ((response.data["namaKelas"] as String).contains("SD")) {
      jenjang = "sd";
    }
    if ((response.data["namaKelas"] as String).contains("SMP")) {
      jenjang = "smp";
    }
    if ((response.data["namaKelas"] as String).contains("SMA")) {
      jenjang = "sma";
    }
    final response2 = await dio.get(
        "https://cbt.api.bupin.id/api/mapel/${response.data["idUjian"]}?level=$jenjang");

    return v2.Quiz.fromMap(response.data, response2.data);
  }

  
  pushToVideo(String link, BuildContext context) {
    Navigator.of(context).push(CustomRoute(
      builder: (context) => HalamanVideo(link),
    ));
    return;
  }

  pushToCbt(String scanResult, BuildContext context) {
    log(scanResult);
     Navigator.of(context).push(CustomRoute(
      builder: (context) => HalamanSoal(
        link: scanResult,
      ),
    ));
    return;
  }
 
  Future<bool> scanQrVideo(String link, BuildContext context) async {
    return await pushToVideo(link, context);
  }

  Future<bool> login(String kodeSekolah, String username) async {
    final dio = Dio();
    final response = await dio.post(
        "https://bupin.id/api/apigurupintar/api-cobalogin.php?username=$username&kode_sekolah=$kodeSekolah");
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (response.data == null || response.data.toString().contains("gagal")) {
      return false;
    } else {
      user = User.fromMap(response.data["data"][0]);
      await prefs.setString("newGupin", jsonEncode(response.data["data"][0]));
      await getMapel();
      await getTo();

      return true;
    }
  }

  Future<bool> logout() async {
    final dio = Dio();
    final response = await dio.post(
        "https://bupin.id/api/apigurupintar/api-cobalogut.php?id_siswa=${user!.idSiswa}");
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool cleared = await prefs.clear();
    if (response.statusCode == 200 && cleared) {
      return true;
    }
    {
      return false;
    }
  }

  Future<bool> autoLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var credential = prefs.getString(
      "newGupin",
    );

    if (credential != null) {
      user = User.fromMap(jsonDecode(credential));
      log(credential.toString());
      await getMapel();
      await getTo();
      return true;
    } else {
      prefs.clear();
      return false;
    }
  }

  Future<void> getTo() async {
    var daftarKelas = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
    int kelas = 0;
    log(user!.idKelas);
    if (user!.idKelas == '17' || user!.idKelas == '64') {
      kelas = daftarKelas[0];
    }
    if (user!.idKelas == '48' || user!.idKelas == '69') {
      kelas = daftarKelas[1];
    }
    if (user!.idKelas == '49' || user!.idKelas == '71') {
      kelas = daftarKelas[2];
    }
    if (user!.idKelas == '18' || user!.idKelas == '65') {
      kelas = daftarKelas[3];
    }
    if (user!.idKelas == '50' || user!.idKelas == '70') {
      kelas = daftarKelas[4];
    }
    if (user!.idKelas == '51' || user!.idKelas == '72') {
      kelas = daftarKelas[5];
    }
    if (user!.idKelas == '16' ||
        user!.idKelas == '66' ||
        user!.idKelas == '58') {
      kelas = daftarKelas[6];
    }
    if (user!.idKelas == '52' ||
        user!.idKelas == '68' ||
        user!.idKelas == '59') {
      kelas = daftarKelas[7];
    }
    if (user!.idKelas == '53' || user!.idKelas == '60') {
      kelas = daftarKelas[8];
    }
    if (user!.idKelas == '19' ||
        user!.idKelas == '67' ||
        user!.idKelas == '61' ||
        user!.idKelas == '29') {
      kelas = daftarKelas[9];
    }
    if (user!.idKelas == '54' ||
        user!.idKelas == '62' ||
        user!.idKelas == '56') {
      kelas = daftarKelas[10];
    }
    if (user!.idKelas == '55' ||
        user!.idKelas == '63' ||
        user!.idKelas == '57') {
      kelas = daftarKelas[11];
    }
    final dio = Dio();
    final response =
        await dio.get("https://bupin.id/api/api-mapel-to.php?kelas=$kelas");
    if (response.data == null || response.data.isEmpty) {
      return;
    } else {
      List<TryOut> tempListTryout = [];
      listTryout = tempListTryout;
      for (Map<String, dynamic> element in response.data) {
        if (!listTryout!
            .map((e) => e.namaMapel)
            .toList()
            .contains(element["namaMapel"])) {
          log(element["namaMapel"] + " Tryout");
          listTryout!.add(TryOut.fromMap(element));
        }
      }

      ;
      return;
    }
  }

  Future<void> getMapel() async {
    final dio = Dio();
    final response = await dio.get(
        "https://bupin.id/api/apigurupintar/api-materipusat.php?kode_sekolah=PUSAT-12345&id_kelas=${user!.idKelas}");

    if (response.data == null) {
      return;
    } else {
      List<Mapel> tempListMapel = [];

      for (Map<String, dynamic> element in response.data) {
        if (!tempListMapel
            .map((e) => e.mapel)
            .toList()
            .contains(element["mapel"])) {
          log(element["mapel"] + " Mapel");
          tempListMapel.add(Mapel.fromMap(element));
        }
      }
      listMapel = tempListMapel;
      ;
      return;
    }
  }

  Future<List<Video>> getMapelDetail(String idMapel) async {
    final dio = Dio();
    final response = await dio.get(
        "https://bupin.id/api/apigurupintar/api-detailmateripusat.php?kode_sekolah=PUSAT-12345&id_mapel=$idMapel&id_kelas=${user!.idKelas}&id_jurusan=${user!.idJurusan}");

    if (response.data == null) {
      return [];
    } else {
      List<Video> tempListMapel = [];

      for (Map<String, dynamic> element in response.data) {
        if (!tempListMapel
            .map((e) => e.linkVideo)
            .toList()
            .contains(element["mapel"])) {
          element["thumbnail"] = await getThumnial(element["link_youtube"]);
          tempListMapel.add(Video(
              (element["link_youtube"] as String),
              element["judul_materi"],
              element["link_youtube"],
              element["thumbnail"],
              element["nama_file"]));
        }
      }

      ;
      return tempListMapel;
    }
  }

  Future<List<WidgetQuestion>>? getToDetail(
      String idMapel, bool ptsOrpas) async {
    final dio = Dio();
    int status = ptsOrpas ? 1 : 2;
    final response = await dio.get(
      "https://bupin.id/api/api-tryout-new.php?kelas=${user!.kelas}&mapel=$idMapel&status=$status",
    );
log( "https://bupin.id/api/api-tryout-new.php?kelas=${user!.kelas}&mapel=$idMapel&status=$status");
    if (response.data == null) {
      return [];
    } else {
      List<WidgetQuestion> tempListTo = [];
      log(response.data.toString());
      for (var element in response.data["results"]) {
        tempListTo.add(WidgetQuestion.fromMap(element));
      }

      ;
      return tempListTo;
    }
  }
}
