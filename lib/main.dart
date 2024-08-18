import 'package:flutter/material.dart';
import 'package:to_do_list/data/database.dart';

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
  // koneksi database
  final database = MyDatabase();
  TextEditingController titleTEC = new TextEditingController();
  TextEditingController detailTEC = new TextEditingController();

  Future insert(String title, String detail) async {
    await database
        .into(database.todos)
        .insert(TodosCompanion.insert(title: title, detail: detail));
  }

  Future<List<Todo>> getAll() {
    return database.select(database.todos).get();
  }

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
                    controller: titleTEC,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), hintText: "Judul"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                      controller: detailTEC,
                      maxLines: 4,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Isi Detail")),
                  SizedBox(
                    height: 10,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true)
                            .pop('dialog');
                      },
                      child: Text('Batal'),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                        onPressed: () {
                          insert(titleTEC.text, detailTEC.text);
                          setState(() {});
                          // back to route
                          Navigator.of(context, rootNavigator: true)
                              .pop('dialog');
                          titleTEC.clear();
                          detailTEC.clear();
                        },
                        child: Text('Simpan'))
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
            // pelajarin lagi dah yang ini
            child: FutureBuilder<List<Todo>>(
                future: getAll(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    print(snapshot.data.toString());
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {
                            return Card(
                              // ambil data dari yang sudah ada!
                              child: ListTile(
                                onTap: () {
                                  todoDialog();
                                },
                                title: Text(snapshot.data![index].title),
                                subtitle: Text(snapshot.data![index].detail),
                                trailing: ElevatedButton(
                                    child: Icon(Icons.delete),
                                    onPressed: () {}),
                              ),
                            );
                          });
                    } else {
                      return Center(child: Text('Belum ada data!'));
                    }
                  }
                })),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            todoDialog();
          },
          child: Icon(Icons.add),
        ));
  }
}
