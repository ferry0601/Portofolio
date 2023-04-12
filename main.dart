import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/sql_helper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter CRUD',
      theme: ThemeData(
     
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter CRUD Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController jalanController = TextEditingController();
  TextEditingController kelurahanController = TextEditingController();
  TextEditingController kecamatanController = TextEditingController();
  TextEditingController provinsiController = TextEditingController();

  @override
  void initState(){
    refreshAlamat();
    super.initState();
  }
  
  //ambildata
  List<Map<String, dynamic>> alamat = [];
  void refreshAlamat() async{
    final data = await SQLHelper.getAlamat();
    setState(() {
      alamat = data;
    });
  }


  @override
  Widget build(BuildContext context) {
  print(alamat);
    return Scaffold(
      appBar: AppBar(
       
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: alamat.length,
        itemBuilder: (context, index)=> Card(
          margin: const EdgeInsets.all(15),
          child: ListTile(
            title: Text(alamat[index]['jalan']),
            subtitle: Text(alamat[index]['kelurahan']['kecamatan']['provinsi']),
            
          ),
          
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          modalForm();
        },
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

//fungsi tambah
Future<void> tambahAlamat() async{
  await SQLHelper.tambahAlamat(
    jalanController.text, kelurahanController.text, kecamatanController.text, provinsiController.text
    );
  refreshAlamat();
}

//form tambah
void modalForm() async{
  showModalBottomSheet(context: context, builder: (_)=> Container(
    padding: const EdgeInsets.all(15),
    child: SingleChildScrollView(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
      TextField(
        controller: jalanController,
        decoration: const InputDecoration(hintText: 'jalan'),
      ),
      const SizedBox(height: 10,
      ),
      TextField(
        controller: kelurahanController,
        decoration: const InputDecoration(hintText: 'kelurahan'),
      ),
      const SizedBox(height: 10,
      ),
      TextField(
        controller: kecamatanController,
        decoration: const InputDecoration(hintText: 'kecamatan'),
      ),
      const SizedBox(height: 10,
      ),
      TextField(
        controller: provinsiController,
        decoration: const InputDecoration(hintText: 'provinsi'),
      ),
      const SizedBox(height: 10,
      ),
      ElevatedButton(onPressed: () async{
        await tambahAlamat();
      },
      child: const Text('tambah'))
    ],
    ),
    ),
  ));
  
}
}
