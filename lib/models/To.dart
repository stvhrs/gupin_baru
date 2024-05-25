import 'package:flutter/material.dart';

class TryOut {
  final String? idmapel;

  final String? idKelas;

  final String? namaMapel;
  final Color color;
  final String asset;

  TryOut(this.idmapel, this.idKelas, this.namaMapel, this.color, this.asset);
  factory TryOut.fromMap(Map<String, dynamic> data) {
    String localAsset(String mapel) {
      if (mapel.toUpperCase().contains("PRAKARYA")) {
        return "asset/Icon/Fisika.png";
      }
      if (mapel.toUpperCase().contains("AGAMA") ||
          mapel.toUpperCase().contains("ARAB") ||mapel.toUpperCase().contains("AKIDAH") ||
          mapel.toUpperCase().contains("QUR'AN") ||
          mapel.toUpperCase().contains("PAI")) {
        return "asset/Icon/Agama.png";
      }

      if (mapel.toUpperCase().contains("INDONESIA")) {
        return "asset/Icon/Bahasa Indonesia.png";
      }
      if (mapel.toUpperCase().contains("MATEMATIKA")) {
        return "asset/Icon/Matematika.png";
      }
      if (mapel.toUpperCase().contains("INGGRIS")) {
        return "asset/Icon/Bahasa Inggris.png";
      }
      if (mapel.toUpperCase().contains("IPA") ||
          mapel.toUpperCase().contains("ALAM") ||
          mapel.toUpperCase().contains("FISIKA")) {
        return "asset/Icon/Fisika.png";
      }
      if (mapel.toUpperCase().contains("IPS") || mapel.toUpperCase().contains("SOSIAL")) {
        return "asset/Icon/Geografi.png";
      }
      if (mapel.toUpperCase().contains("KIMIA")) {
        return "asset/Icon/Kimia.png";
      }
      if (mapel.toUpperCase().contains("BIOLOGI")) {
        return "asset/Icon/Biologi.png";
      }

      if (mapel.toUpperCase().contains("KIMIA")) {
        return "asset/Icon/Kimia.png";
      }
      if (mapel.toUpperCase().contains("ANTROPOLOGI")) {
        return "asset/Icon/Antropologi.png";
      }
      if (mapel.toUpperCase().contains("EKONOMI")) {
        return "asset/Icon/Ekonomi.png";
      }
      if (mapel.toUpperCase().contains("PANCASILA")) {
        return "asset/Icon/Pancasila.png";
      }
      if (mapel.toUpperCase().contains("SOSIOLOGI")) {
        return "asset/Icon/Sosiologi.png";
      }
      if (mapel.toUpperCase().contains("SEJARAH")) {
        return "asset/Icon/Sejarah.png";
      }
      return "asset/Icon/Bahasa Inggris.png";
    }
    Color localColor(String mapel) {
      if (mapel.toUpperCase().contains("PRAKARYA")) {
        return Color.fromARGB(255, 247, 195, 26);
      }
      if (mapel.toUpperCase().contains("AGAMA") ||
          mapel.toUpperCase().contains("ARAB") ||mapel.toUpperCase().contains("AKIDAH") ||
          mapel.toUpperCase().contains("QUR'AN") ||
          mapel.toUpperCase().contains("PAI")) {
        return Color.fromARGB(255, 224, 184, 19);
      }

      if (mapel.toUpperCase().contains("INDONESIA")) {
        return Color.fromARGB(255, 72, 79, 155);
      }
      if (mapel.toUpperCase().contains("MATEMATIKA")) {
        return Color.fromARGB(255, 153, 178, 219);
      }
      if (mapel.toUpperCase().contains("INGGRIS")) {
        return Color.fromARGB(255, 159, 101, 221);
      }
      if (mapel.toUpperCase().contains("IPA") ||
          mapel.toUpperCase().contains("ALAM") ||
          mapel.toUpperCase().contains("FISIKA")) {
        return Color.fromARGB(255, 14, 13, 45);
      }
      if (mapel.toUpperCase().contains("IPS") || mapel.toUpperCase().contains("SOSIAL")) {
        return Color.fromARGB(255, 101, 166, 225);
      }
      if (mapel.toUpperCase().contains("KIMIA")) {
        return Color.fromARGB(255, 243, 80, 77);
      }
      if (mapel.toUpperCase().contains("BIOLOGI")) {
        return Color.fromARGB(255, 14, 31, 16);
      }

      if (mapel.toUpperCase().contains("KIMIA")) {
        return Color.fromARGB(255, 243, 80, 77);
      }
      if (mapel.toUpperCase().contains("ANTROPOLOGI")) {
        return Color.fromARGB(255, 159, 146, 154);
      }
      if (mapel.toUpperCase().contains("EKONOMI")) {
        return Color.fromARGB(255, 241, 192, 104);
      }
      if (mapel.toUpperCase().contains("PANCASILA")) {
        return Color.fromARGB(255, 213, 160, 57);
      }
      if (mapel.toUpperCase().contains("SOSIOLOGI")) {
        return Color.fromARGB(255, 120, 144, 198);
      }
      if (mapel.toUpperCase().contains("SEJARAH")) {
        return Color.fromARGB(255, 117, 47, 17);
      }
      return Color.fromARGB(255, 117, 47, 17);
    }

    return TryOut(
      data["idMapel"].toString(),
      data["idKelas"].toString(),
      data["namaMapel"].toString(),
      localColor(data["namaMapel"]),
      localAsset(data["namaMapel"]),
    );
  }
}
