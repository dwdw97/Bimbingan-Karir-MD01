import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lapor_book/components/list_item.dart';
import 'package:lapor_book/models/akun.dart';
import 'package:lapor_book/models/komentar.dart';
import 'package:lapor_book/models/laporan.dart';

class AllLaporan extends StatefulWidget {
  final Akun akun;
  const AllLaporan({super.key, required this.akun});

  @override
  State<AllLaporan> createState() => _AllLaporanState();
}

class _AllLaporanState extends State<AllLaporan> {
  // @override
  // Widget build(BuildContext context) {
  //   return Center(
  //     child: Text('All Laporan'),
  //   );
  // }



  final _firestore = FirebaseFirestore.instance;

  List<Laporan> listLaporan = [];

  void getTransaksi() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firestore.collection('laporan').get();

      setState(() {
        listLaporan.clear();
        for (var documents in querySnapshot.docs) {
          // List<dynamic>? komentarData = documents.data()['komentar'];
          

          // List<Komentar>? listKomentar = komentarData?.map((map) {
          //   return Komentar(
          //     pelapor: map['pelapor'],
          //     isi: map['isi'],
          //   );
          // }).toList();

          listLaporan.add(
            Laporan(
              uid: documents.data()['uid'],
              docId: documents.data()['docId'],
              judul: documents.data()['judul'],
              instansi: documents.data()['instansi'],
              deskripsi: documents.data()['deskripsi'],
              pelapor: documents.data()['pelapor'],
              status: documents.data()['status'],
              foto: documents.data()['foto'],
              tgl_lapor: documents['tgl_lapor'].toDate(),
              koordinat: documents.data()['koordinat'],
              komentar: documents.data()['komentar'],
              likes: documents.data()['likes'],
            ),
          );
        }
      });
    } catch (e) {
      final snackbar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    getTransaksi(); // fungsi get berada di fungsi build agar menjadi realtime

    return SafeArea(
      child: Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1 / 1.234,
                  ),
                  itemCount: listLaporan.length,
                  itemBuilder: (context, index) {
                    return ListItem(
                      laporan: listLaporan[index],
                      akun: widget.akun,
                      isLaporanku: false,
                    );
                  }),
            ),
    );
  }
}