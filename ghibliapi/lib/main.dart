import 'package:flutter/material.dart';
import 'package:ghibliapi/home.dart';
import 'dart:async';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'methods.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Página Inicial',
      home: const StartPage(title: 'Ghibli App'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class StartPage extends StatefulWidget {
  const StartPage({super.key, required this.title});
  final String title;

  @override
  State<StartPage> createState() => _StartPage();
}

class _StartPage extends State<StartPage> {

  @override
  Widget build(BuildContext context) {
        void iniciar() async {
      Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage(title: 'Ghibli Wiki',)),
      );
    }
        Timer(const Duration(seconds: 15), iniciar);
    return Scaffold(
      body: Center(
        child: 
      Container(
        width: 300,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("Start_Background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               buildText("Ghibli Wiki", fontSize: 36, fontColor: Colors.white, fontWeight: FontWeight.bold),
          LoadingAnimationWidget.hexagonDots(
                color: Colors.blue,
                size: 50,
          )
            ],
          ),
        ),
      ),
      )
    );
  }
}