import 'package:equatable/equatable.dart';

class Umkm extends Equatable {
  final String id;
  final String nama;
  final String jenis;

  Umkm({required this.id, required this.nama, required this.jenis});

  factory Umkm.fromJson(Map<String, dynamic> json) {
    return Umkm(
      id: json['id'],
      nama: json['nama'],
      jenis: json['jenis'],
    );
  }

  @override
  List<Object> get props => [id, nama, jenis];
}

class UmkmDetail extends Equatable {
  final String id;
  final String nama;
  final String jenis;
  final String omzetBulan;
  final String lamaUsaha;
  final String memberSejak;
  final String jumlahPinjamanSukses;

  UmkmDetail({
    required this.id,
    required this.nama,
    required this.jenis,
    required this.omzetBulan,
    required this.lamaUsaha,
    required this.memberSejak,
    required this.jumlahPinjamanSukses,
  });

  factory UmkmDetail.fromJson(Map<String, dynamic> json) {
    return UmkmDetail(
      id: json['id'],
      nama: json['nama'],
      jenis: json['jenis'],
      omzetBulan: json['omzet_bulan'],
      lamaUsaha: json['lama_usaha'],
      memberSejak: json['member_sejak'],
      jumlahPinjamanSukses: json['jumlah_pinjaman_sukses'],
    );
  }

  @override
  List<Object> get props => [
        id,
        nama,
        jenis,
        omzetBulan,
        lamaUsaha,
        memberSejak,
        jumlahPinjamanSukses,
      ];
}
