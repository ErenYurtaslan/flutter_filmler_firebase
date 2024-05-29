import 'package:flutter_filmler_firebase/Filmler.dart';
import 'package:flutter/material.dart';


// ignore: must_be_immutable
class Detay extends StatefulWidget {

  Filmler film;


  Detay({super.key, required this.film});

  @override
  State<Detay> createState() => _DetayState();
}

class _DetayState extends State<Detay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(widget.film.film_ad),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Image.network("http://kasimadalan.pe.hu/filmler/resimler/${widget.film.film_resim}"),
            Text("Yönetmen : ${widget.film.yonetmen_ad}", style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold ),),
            Text("Çıkış Yılı : ${widget.film.film_yil.toString()}", style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold ),),
          ],
        ),
      ),
    );
  }
}
