import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:latihan_yutub/delete.dart'; 
import 'package:latihan_yutub/update.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _listdata = [];
  bool _isloading = true;

  Future<void> _getData() async {
    try {
      final response = await http.get(Uri.parse("http://171.151.50.172/flutter_koneksi/tampil.php"));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _listdata = data;
          _isloading = false;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        title: Text(
          "Tampil data",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
          
          ),
          backgroundColor: Colors.teal,
      ),
      body: _isloading
          ? Center(
            child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _listdata.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 4, 
                  margin: EdgeInsets.all(8), 
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16), 
                    title: Text(
                      _listdata[index]["nama"],
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 8),
                        Text("Tanggal: ${_listdata[index]["tanggal"]}"),
                        Text("Email: ${_listdata[index]["email"]}"),
                        Text("Gender: ${_listdata[index]["gender"]}"),
                        Text("Lembaga: ${_listdata[index]["lembaga"]}"),
                        Text("Keperluan: ${_listdata[index]["keperluan"]}"),
                      ],
                    ),
                    trailing: Wrap(
                      spacing: 8,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            int id = int.parse(_listdata[index]["id"]);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UpdateDataPage(id: id),
                              ),
                            );
                          },
                          child: Text('Update'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            int id = int.parse(_listdata[index]["id"]);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DeleteDataPage(id: id),
                              ),
                            );
                          },
                        
                          style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                          ),
                          child: Text(
                            'Delete',
                            style: TextStyle(
                            fontWeight: FontWeight.normal,
                            ),
                            ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
