import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:equatable/equatable.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


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


class UmkmCubit extends Cubit<List<Umkm>> {
  UmkmCubit() : super([]);

  final String apiUrl = 'http://178.128.17.76:8000';

  Future<void> getDaftarUmkm() async {
    final response = await http.get(Uri.parse('$apiUrl/daftar_umkm'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['data'];
      final umkms = data.map((umkm) => Umkm.fromJson(umkm)).toList();
      emit(umkms);
    } else {
      throw Exception('Failed to load UMKM data');
    }
  }

  Future<UmkmDetail> getDetailUmkm(String id) async {
    final response = await http.get(Uri.parse('$apiUrl/detil_umkm/$id'));

    if (response.statusCode == 200) {
      return UmkmDetail.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load UMKM detail');
    }
  }
}



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => UmkmCubit()..getDaftarUmkm(),
        child: UmkmListPage(),
      ),
    );
  }
}

class UmkmListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar UMKM'),
      ),
      body: BlocBuilder<UmkmCubit, List<Umkm>>(
        builder: (context, state) {
          if (state.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: state.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(state[index].nama),
                subtitle: Text(state[index].jenis),
                onTap: () async {
                  UmkmDetail detail = await context.read<UmkmCubit>().getDetailUmkm(state[index].id);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UmkmDetailPage(detail: detail),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class UmkmDetailPage extends StatelessWidget {
  final UmkmDetail detail;

  UmkmDetailPage({required this.detail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(detail.nama),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nama: ${detail.nama}'),
            Text('Jenis: ${detail.jenis}'),
            Text('Omzet Bulan: ${detail.omzetBulan}'),
            Text('Lama Usaha: ${detail.lamaUsaha}'),
            Text('Member Sejak: ${detail.memberSejak}'),
            Text('Jumlah Pinjaman Sukses: ${detail.jumlahPinjamanSukses}'),
          ],
        ),
      ),
    );
  }
}
