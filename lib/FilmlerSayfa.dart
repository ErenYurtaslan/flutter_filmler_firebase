import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_filmler_firebase/DetaySayfa.dart';
import 'package:flutter_filmler_firebase/Filmler.dart';
import 'package:flutter_filmler_firebase/Kategoriler.dart';


// ignore: must_be_immutable
class FilmlerSayfa extends StatefulWidget {

  Kategoriler kategori;


  FilmlerSayfa({super.key, required this.kategori});

  @override
  State<FilmlerSayfa> createState() => _FilmlerSayfaState();
}

class _FilmlerSayfaState extends State<FilmlerSayfa> {

  var refFilmler = FirebaseDatabase.instance.ref().child("filmler");



  @override
  Widget build(BuildContext context) {
    return Scaffold(




      appBar: AppBar(
        title: Text("Filmler: ${widget.kategori.kategori_ad}"),
      ),





      body: StreamBuilder<DatabaseEvent>(
          stream: refFilmler.orderByChild("kategori_ad").equalTo(widget.kategori.kategori_ad).onValue,
          builder: (context, event){
            if(event.hasData){
              var filmlerListesi = <Filmler>[];
              var gelenDeger = event.data!.snapshot.value as dynamic;
              if(gelenDeger != null){
                gelenDeger.forEach((key, nesne){
                  var gelenFilm = Filmler.fromJson(key, nesne);
                  filmlerListesi.add(gelenFilm);
                });
              }
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio:  4/7,),
                itemCount: filmlerListesi.length,
                itemBuilder: (context, index){
                  var film = filmlerListesi[index];
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> Detay(film: film)));
                    },
                    child: Card(
                      color: Colors.blue.shade300,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network("http://kasimadalan.pe.hu/filmler/resimler/${film.film_resim}"),
                          ),
                          Text(film.film_ad, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold ),
                          ),
                        ],
                      ),
                    ),
                  );
                },

              );
            }else{
              return const Center();
            }
          }
      ),






    );
  }
}


