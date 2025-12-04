
import 'package:flutter/material.dart';
import 'package:formattingapi/home.dart';
import 'package:url_launcher/url_launcher.dart';
import 'methods.dart';
void main() {
  runApp(const CreditsPage());
}

class CreditsPage extends StatelessWidget {
  const CreditsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Filmes',
      home: const MyHomePage(title: 'Ghibli Wiki'),
      debugShowCheckedModeBanner: false,
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
  Future<void> AdicionarURL(String url) async {
  final Uri uri = Uri.parse(url);
  launchUrl(uri);
}

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("Films_Background.png"),
          opacity: 1,
          ),
        ),
        child: Center(
         child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            SizedBox(
              height: 46,
            ),
            Container(
              alignment: Alignment.center,
              width: 200,
              height: 60,
              child: buildText("Ghibli Wiki", fontSize: 30, fontColor: Colors.blue)
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromARGB(255, 7, 33, 78),
              ),
              height: 400,
              width: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
              height: 50,
            ),
                  Text("API UTILIZADA:", style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),),
                  GestureDetector(
                    onTap:() {
                    AdicionarURL("https://ghibliapi.vercel.app/#section/Studio-Ghibli-API");
                    },
                    child: Text("https://ghibliapi.vercel.app/#section/Studio-Ghibli-API", textAlign: TextAlign.center, style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 0, 195, 255)
                    ),),
                  ),
                  buildText("Descrição", fontSize: 15, fontWeight: FontWeight.bold, fontColor: Colors.white, alignment: TextAlign.justify),
                  buildText("API destinada à filmes do Estúdio Ghibli. Dessa forma, possui o título do filme, diretor, ano de lançamento, imagem, personagens, espécies, veículos, dentre muitos outros dados. Pegamos algumas dessas informações para trazer um breve resumo de cada filme dentro dessa API, além de seu título, diretor e descrição, pegamos também as próprias imagens do filme respectivo.", fontSize: 12, fontWeight: FontWeight.normal, fontColor: Colors.white),
                  buildText("Comandos.", fontSize: 15, fontWeight: FontWeight.bold, fontColor: Colors.white),
                  buildText("Para a construção do conteúdo desse aplicativo, foi-se utilizado do GET para pegar dados da API.", fontSize: 15, fontWeight: FontWeight.normal, fontColor: Colors.white),
                ],
              ),
            ),
            SizedBox(
              height: 122,
            ),
            Container(
            width: 330,
            height: 50,
            decoration: BoxDecoration(
          ),
          
              child: Row(
                spacing: 80,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
            Container(
            width: 330,
            height: 50,
            decoration: BoxDecoration(
          ),
                child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(onPressed: (){
                  Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FilmsPage()));
                  }, icon: Icon(Icons.home, color: const Color.fromARGB(255, 255, 255, 255))),
                ],
              )
              
              )
                ],
              )
              
              )  
          
        
          ]
         ),
      ),
      )
      
      

    );
  }
}