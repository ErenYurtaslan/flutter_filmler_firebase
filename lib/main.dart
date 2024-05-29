import 'package:flutter_filmler_firebase/FilmlerSayfa.dart';
import 'package:flutter_filmler_firebase/Kategoriler.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  const Anasayfa(),
    );
  }
}

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});



  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {

  var refKategoriler = FirebaseDatabase.instance.ref().child("kategoriler");


  @override
  Widget build(BuildContext context) {
    return Scaffold(


      appBar: AppBar(
        title: const Text("Kategoriler"),
      ),






      body: StreamBuilder<DatabaseEvent>(
          stream: refKategoriler.onValue,
          builder: (context, event){
            if(event.hasData){
              var kategoriListesi = <Kategoriler>[];
              var gelenDeger = event.data!.snapshot.value as dynamic;
              if(gelenDeger != null){
                gelenDeger.forEach((key, nesne){
                  var gelenKategori = Kategoriler.fromJson(key, nesne);
                  kategoriListesi.add(gelenKategori);
                });
              }
              return ListView.builder(
                itemCount: kategoriListesi!.length,
                itemBuilder: (context, index){
                  var kategori = kategoriListesi[index];
                  return GestureDetector(
                    onTap: (){
                     Navigator.push(context, MaterialPageRoute(builder: (context)=>FilmlerSayfa(kategori: kategori,)));
                    },
                    child: Card(
                      child: SizedBox(
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(kategori.kategori_ad),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }else{
              return  Container(
                color: Colors.indigo.shade200,
              );
            }
          }
      ),






    );
  }
}