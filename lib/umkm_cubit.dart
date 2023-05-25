import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'umkm.dart';

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
