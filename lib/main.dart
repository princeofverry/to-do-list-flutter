import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void todoDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: Center(
                  child: Column(
                children: [
                  Text('Tambah Transaksi'),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), hintText: "Judul"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                      maxLines: 4,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Isi Detail")),
                  SizedBox(
                    height: 10,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Batal'),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(onPressed: () {}, child: Text('Simpan'))
                  ])
                ],
              )),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[400],
        body: SafeArea(
            child: Card(
          // ambil data dari yang sudah ada!
          child: ListTile(
            onTap: () {
              todoDialog();
            },
            title: Text('Judul'),
            subtitle: Text('Detail dari judul'),
            trailing:
                ElevatedButton(child: Icon(Icons.delete), onPressed: () {}),
          ),
        )),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            todoDialog();
          },
          child: Icon(Icons.add),
        ));
  }
}
