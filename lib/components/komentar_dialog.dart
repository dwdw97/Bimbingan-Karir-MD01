import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lapor_book/components/input_widget.dart';
import 'package:lapor_book/components/styles.dart';
import 'package:lapor_book/components/validators.dart';
import 'package:lapor_book/models/laporan.dart';
import 'package:lapor_book/models/akun.dart';

class KomentarDialog extends StatefulWidget {
  @override
  _KomentarDialogState createState() => _KomentarDialogState();
}

class _KomentarDialogState extends State<KomentarDialog> {
  late String komentator;
  late String komentar;
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  void addKomentar() async {
    CollectionReference komentarCollection = _firestore.collection('komentar');
    final id = komentarCollection.doc().id;

    try {
      await komentarCollection.doc(id).set({
        'uid': _auth.currentUser!.uid,
        'komentar': komentar,
        'komentarId': id,
      }).catchError((e) {
        throw e;
      });
      Navigator.popAndPushNamed(context, '/dashboard');
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: primaryColor,
      content: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              "Tambah Komentar",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            InputLayout(
                'Komentar',
                TextFormField(
                    onChanged: (String value) => {
                          setState(() {
                            komentar = value;
                          })
                        },
                    validator: notEmptyValidator,
                    decoration: customInputDecoration("Komentar Anda"))),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                addKomentar();
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text('Simpan Komentar'),
            ),
          ],
        ),
      ),
    );
  }
}
