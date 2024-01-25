import 'package:lapor_book/models/komentar.dart';

class Laporan {
  final String uid;
  final String docId;

  final String judul;
  final String instansi;
  String? deskripsi;
  String? foto;
  final String pelapor;
  final String status;
  final DateTime tgl_lapor;
  final String koordinat;
  List<dynamic>? komentar;
  List<dynamic> likes;

  Laporan({
    required this.uid,
    required this.docId,
    required this.judul,
    required this.instansi,
    this.deskripsi,
    this.foto,
    required this.pelapor,
    required this.status,
    required this.tgl_lapor,
    required this.koordinat,
    this.komentar,
    required this.likes,
  });
}