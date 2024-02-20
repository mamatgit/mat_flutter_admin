import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart'; 
import 'package:latihan_yutub/tampil.dart';

class UpdateDataPage extends StatefulWidget {
  final int id;

  const UpdateDataPage({Key? key, required this.id}) : super(key: key);

  @override
  _UpdateDataPageState createState() => _UpdateDataPageState();
}

class _UpdateDataPageState extends State<UpdateDataPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController lembagaController = TextEditingController();
  final TextEditingController keperluanController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Datanya'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: namaController,
                decoration: InputDecoration(labelText: 'Nama'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama Anda tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email / No. Telp'),
                validator: (value) {
                 
                  return null;
                },
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: genderController,
                decoration: InputDecoration(labelText: 'Gender'),
                validator: (value) {
                  
                  return null;
                },
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: lembagaController,
                decoration: InputDecoration(labelText: 'Lembaga'),
                validator: (value) {
                 
                  return null;
                },
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: keperluanController,
                decoration: InputDecoration(labelText: 'Keperluan'),
                validator: (value) {
                 
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    updateData();
                  }
                },
                child: Text('Update'),
              ),
                SizedBox(width: 15),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                   style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                   ),
                  child: Text(
                    'Kembali',
                  style: TextStyle(

                    fontWeight: FontWeight.normal,
                  ),
                  ),
                   
                  
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> updateData() async {
    DateTime now = DateTime.now();
    String date = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);

    var url = Uri.parse("http://171.151.50.172/flutter_koneksi/update.php");
    var response = await http.post(url, body: {
      "id": widget.id.toString(),
      "nama": namaController.text,
      "email": emailController.text,
      "gender": genderController.text,
      "lembaga": lembagaController.text,
      "keperluan": keperluanController.text,
      "tanggal": date,
    });

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Data berhasil diupdate'),
      ));

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Gagal memperbarui data'),
      ));
    }
  }
}
