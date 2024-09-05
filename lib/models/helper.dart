class Helper {
  
  int  getIndex(String idKelas)  {
    var daftarKelas = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
    int kelas = 0;

    if (idKelas == '17' || idKelas == '64') {
      kelas = daftarKelas[0];
    }
    if (idKelas == '48' || idKelas == '69') {
      kelas = daftarKelas[1];
    }
    if (idKelas == '49' || idKelas == '71') {
      kelas = daftarKelas[2];
    }
    if (idKelas == '18' || idKelas == '65') {
      kelas = daftarKelas[3];
    }
    if (idKelas == '50' || idKelas == '70') {
      kelas = daftarKelas[4];
    }
    if (idKelas == '51' || idKelas == '72') {
      kelas = daftarKelas[5];
    }
    if (idKelas == '16' ||
        idKelas == '66' ||
        idKelas == '58') {
      kelas = daftarKelas[6];
    }
    if (idKelas == '52' ||
        idKelas == '68' ||
        idKelas == '59') {
      kelas = daftarKelas[7];
    }
    if (idKelas == '53' || idKelas == '60') {
      kelas = daftarKelas[8];
    }
    if (idKelas == '19' ||
        idKelas == '67' ||
        idKelas == '61' ||
        idKelas == '29') {
      kelas = daftarKelas[9];
    }
    if (idKelas == '54' ||
        idKelas == '62' ||
        idKelas == '56') {
      kelas = daftarKelas[10];
    }
    if (idKelas == '55' ||
        idKelas == '63' ||
        idKelas == '57') {
      kelas = daftarKelas[11];
    }
    
     return kelas;}
   
}