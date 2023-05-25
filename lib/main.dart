import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'umkm_cubit.dart';
import 'umkm.dart';

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
