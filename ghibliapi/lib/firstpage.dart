import 'dart:async';
import 'package:flutter/material.dart';
import 'main.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Página Inicial',
      home: const HomeStartPage(title: 'Ghibli App'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeStartPage extends StatefulWidget {
  const HomeStartPage({super.key, required this.title});
  final String title;

  @override
  State<HomeStartPage> createState() => _HomeStartPageState();
}

class _HomeStartPageState extends State<HomeStartPage> {
  @override
  Widget build(BuildContext context) {
        void iniciar() {
      Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage(title: '',)));
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
              const Text(
                "Ghibli Wiki",
                style: TextStyle(
                  fontSize: 36,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
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