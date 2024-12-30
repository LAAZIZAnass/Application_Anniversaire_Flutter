import 'package:first_app/ui/pages/autre.page.dart';
import 'package:first_app/ui/pages/counter.page.dart';
import 'package:first_app/ui/pages/gallery.page.dart';
import 'package:first_app/ui/pages/home.page.dart';
import 'package:first_app/ui/pages/login.page.dart';
import 'package:first_app/ui/pages/meteo.page.dart';
import 'package:first_app/ui/pages/travail.page.dart';
import 'package:flutter/material.dart' ;
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes:{
        "/":(context)=>LoginPage(),
        "/meteo":(context)=>MeteoPage(),
        "/gallery":(context)=>GalleryPage(),
        "/counter":(context)=>CounterPage(),
        "/home":(context)=>HomePage(),
        "/travail":(context)=>TravailPage(),
        "/autre":(context)=>AutrePage(),



      },
      theme: ThemeData(
        primarySwatch: Colors.deepOrange
      ),
      initialRoute: "/",
    );
  }
}


