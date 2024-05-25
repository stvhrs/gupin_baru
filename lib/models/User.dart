import 'dart:developer';

class User {
  final String jenjang;
  final String idSiswa;
  final String idKelas;
  final String username;
  final String kelas;
  final String kodeSekolah;
  final String idJurusan;

  User(this.jenjang, this.idSiswa,this.kelas, this.idKelas, this.username,
      this.kodeSekolah, this.idJurusan);
  factory User.fromMap(Map<String, dynamic> data) {
    getJenjang(String idKelas){ var daftarKelas = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
    int kelas = 0;
const List<String> list = <String>[
      'SD  I',
      'SD  II',
      'SD  III',
      'SD  IV',
      'SD  V',
      'SD  VI',
      'SMP VII',
      "SMP VIII",
      "SMP IX",
      "SMA X",
      "SMA XI",
      "SMA XII"
    ];
    if (data["id_kelas"] == '17' || data["id_kelas"] == '64') {
      kelas = daftarKelas[0];
    }
    if (data["id_kelas"] == '48') {
      kelas = daftarKelas[1];
    }
    if (data["id_kelas"] == '49') {
      kelas = daftarKelas[2];
    }
    if (data["id_kelas"] == '18' || data["id_kelas"] == '65') {
      kelas = daftarKelas[3];
    }
    if (data["id_kelas"] == '50') {
      kelas = daftarKelas[4];
    }
    if (data["id_kelas"] == '51') {
      kelas = daftarKelas[5];
    }
    if (data["id_kelas"] == '16' ||
        data["id_kelas"] == '66' ||
        data["id_kelas"] == '58') {
      kelas = daftarKelas[6];
    }
    if (data["id_kelas"] == '52' ||
        data["id_kelas"] == '68' ||
        data["id_kelas"] == '59') {
      kelas = daftarKelas[7];
    }
    if (data["id_kelas"] == '53' || data["id_kelas"] == '60') {
      kelas = daftarKelas[8];
    }
    if (data["id_kelas"] == '19' ||
        data["id_kelas"] == '67' ||
        data["id_kelas"] == '61' ||
        data["id_kelas"] == '29') {
      kelas = daftarKelas[9];
    }
    if (data["id_kelas"] == '54' ||
        data["id_kelas"] == '62' ||
        data["id_kelas"] == '56') {
      kelas = daftarKelas[10];
    }
    if (data["id_kelas"] == '55' ||
        data["id_kelas"] == '63' ||
        data["id_kelas"] == '57') {
      kelas = daftarKelas[11];
    }
    
    return  list[kelas-1];
}
  getKelas(String idKelas){ var daftarKelas = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
    int kelas = 0;

    if (data["id_kelas"] == '17' || data["id_kelas"] == '64') {
      kelas = daftarKelas[0];
    }
    if (data["id_kelas"] == '48') {
      kelas = daftarKelas[1];
    }
    if (data["id_kelas"] == '49') {
      kelas = daftarKelas[2];
    }
    if (data["id_kelas"] == '18' || data["id_kelas"] == '65') {
      kelas = daftarKelas[3];
    }
    if (data["id_kelas"] == '50') {
      kelas = daftarKelas[4];
    }
    if (data["id_kelas"] == '51') {
      kelas = daftarKelas[5];
    }
    if (data["id_kelas"] == '16' ||
        data["id_kelas"] == '66' ||
        data["id_kelas"] == '58') {
      kelas = daftarKelas[6];
    }
    if (data["id_kelas"] == '52' ||
        data["id_kelas"] == '68' ||
        data["id_kelas"] == '59') {
      kelas = daftarKelas[7];
    }
    if (data["id_kelas"] == '53' || data["id_kelas"] == '60') {
      kelas = daftarKelas[8];
    }
    if (data["id_kelas"] == '19' ||
        data["id_kelas"] == '67' ||
        data["id_kelas"] == '61' ||
        data["id_kelas"] == '29') {
      kelas = daftarKelas[9];
    }
    if (data["id_kelas"] == '54' ||
        data["id_kelas"] == '62' ||
        data["id_kelas"] == '56') {
      kelas = daftarKelas[10];
    }
    if (data["id_kelas"] == '55' ||
        data["id_kelas"] == '63' ||
        data["id_kelas"] == '57') {
      kelas = daftarKelas[11];
    }
    log(kelas.toString());
    return kelas.toString();
}
   log("USERRRR;");
    return User(
       getJenjang(  data["id_kelas"]),
        data["id_siswa"].toString(),getKelas(  data["id_kelas"]),
        data["id_kelas"].toString(),
        data["nis"].toString(),
        data["kode_sekolah"].toString(),
        data["id_jurusan"].toString());
  }
}
