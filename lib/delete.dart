import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:latihan_yutub/tampil.dart';

class DeleteDataPage extends StatelessWidget {
  final int id;

  DeleteDataPage({required this.id});

  Future<void> _deleteData(BuildContext context) async {
    try {
      final response = await http.post(
        Uri.parse("http://171.151.50.172/flutter_koneksi/delete.php"),
        body: {"id": id.toString()},
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Data berhasil dihapus'),
        ));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Gagal menghapus data'),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Terjadi kesalahan: $e'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hapus Datanya'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.delete_sharp,
              size: 100,
              color: Colors.red,
            ),
            SizedBox(height: 16),
            Text(
              'Apakah Anda yakin ingin menghapus data ini?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _deleteData(context);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                  ),
                  child: Text(
                    'Ya',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),

                SizedBox(width: 16),
                
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                    style:ElevatedButton.styleFrom(
                      primary: Colors.red,
                    ),
                  child: Text(
                    'Tidak',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
