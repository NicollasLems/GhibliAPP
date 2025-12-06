import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'class.dart';
import 'FilmsTable.dart';
import 'Credits.dart';
import 'main.dart';
import 'methods.dart';

class FilmsPage extends StatelessWidget {
  const FilmsPage({super.key});

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
  State<MyHomePage> createState() => Home();
}

class Home extends State<MyHomePage> {  
  Future<void> AdicionarURL(String url) async {
  final Uri uri = Uri.parse(url);
  launchUrl(uri);
}

  Film? FilteredFilm;
  List<Film> Favoritefilms = [];
  List<Film> films = [];

  List<Person> people = [];

  int currentIndex = 0;

  bool HasImage = true;
  bool Carousel = true;
  bool Search = false;

@override
void initState(){
  super.initState();
  getFilm();
  currentIndex = 0;
}

  Future<void> getFilm() async{
  List url = [
  'https://ghibliapi.vercel.app/films',
  'https://ghibliapi.vercel.app/people',
  ];

  var filmsResponse = await http.get(Uri.parse(url[0]));
  var peopleResponse = await http.get(Uri.parse(url[1]));

  if (filmsResponse.statusCode == 200 && peopleResponse.statusCode == 200){
    final List<dynamic> FilmResponseData = jsonDecode(filmsResponse.body);
    final List<dynamic> PeopleResponseData = jsonDecode(peopleResponse.body);
    
    setState((){
     films = FilmResponseData.map((json) => Film.fromJson(json)).toList();
     people = PeopleResponseData.map((json) => Person.fromJson(json)).toList();
      List<String> FavoriteFilms = [
      'Ponyo',
      'Howl\'s Moving Castle',
      'The Wind Rises',
      'Spirited Away',
    ];
      if(FavoriteFilms.isNotEmpty){
      Favoritefilms = films.where((film) => FavoriteFilms.contains(film.title)).toList();
      currentIndex = Favoritefilms.isNotEmpty ? 0 : 0;
      }
    });
    }  
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

            Container(
              alignment: Alignment.center,
              width: 200,
              height: 60,
              child: buildText("Ghibli Wiki", fontSize: 30, fontColor:  Colors.blue, fontWeight: FontWeight.normal),
            ),
          
          Container(
            width: 300,
            decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30)
          ),

          child: TextField(
          onSubmitted: (String inputName) async {
          var filmFound = films.firstWhere(
          (film) => (film.title ?? 'Spirited Away').toLowerCase() == inputName.toLowerCase(),
         );
           if (filmFound.title!.isEmpty){
           Carousel = true;
           Search = false;
           filmFound = films.first;
           }
           else{
            setState((){
             FilteredFilm = filmFound;
             Carousel = false;
             Search = true;
           }
            );
          }
          },
            textAlign: TextAlign.left,
            decoration: InputDecoration(
              border: InputBorder.none,
              icon: Icon(Icons.zoom_in, color: Colors.black,),
              hintText: "buscar",
              hintStyle: TextStyle(
              color: Colors.grey,
              ),
            ),
          ),
          ),
          SizedBox(
            height: 10,
          ),
          Visibility(
            visible: Carousel,
            child:
          Container(
            width: 300,
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("Favorites_Background.png"), fit: BoxFit.fill)
            ),
            child: Row(
            children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              SizedBox(
                width: 80,
                height: 50,
                child: buildText("Escolha dos Editores", fontSize: 12, fontWeight: FontWeight.bold, alignment: TextAlign.center, fontStyle: FontStyle.italic, fontColor: Colors.black),
              ),
              DotsIndicator(
              decorator: DotsDecorator(
              size: const Size(5, 5),
              activeColor: Colors.grey,
              activeSize: const Size(5,5),
              color: Colors.black,
              ),
              dotsCount: Favoritefilms.length > 0 ? Favoritefilms.length : 5,
              position: currentIndex.toDouble(),
            ),
            ],
            ),

            Container(
              width: 215,
              height: 220,
              child: CarouselSlider(
            options: CarouselOptions(
            viewportFraction: 1,
            enlargeCenterPage: true,
            enableInfiniteScroll: true,
            autoPlay: true,
            onPageChanged:(index, reason) => 
            setState((){
               currentIndex = index;
              }),
            
            
          ),
              items: Favoritefilms.map((favoritefilm) => Container( 
              decoration: BoxDecoration(
              image: DecorationImage(
              image: NetworkImage("${favoritefilm.image}"),
              fit: BoxFit.fill,
              )
              ),
            )
            ).toList(),
               ),	
            )
          
            ],
            )
          ),
          ),
          Visibility(
            visible: Search,
            child: Container(
              decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(image: NetworkImage(FilteredFilm?.image ?? 'No Image'), opacity: 0.3, fit: BoxFit.fill)
              ),
              height: 500,
              width: 300,
            child: Column(
              children: [
                Row(children: [  
                IconButton(onPressed: (){
                      setState(() {
                        Carousel = true;
                        Search = false;
                        });

                },  
                 icon: Icon(Icons.arrow_back, color: const Color.fromARGB(255, 255, 255, 255),) ),],),
                SizedBox(
                  width: 100,
                  child:
                   buildText(FilteredFilm?.title ?? "No Title", fontSize: 16, fontWeight: FontWeight.bold, fontColor: Colors.white, alignment: TextAlign.center)
                 ),
                SizedBox(
                  width: 200,
                  child: buildText(FilteredFilm?.director ?? 'No Director', fontSize: 16, fontWeight: FontWeight.bold, fontColor: Colors.white, alignment: TextAlign.center)
                 ),
                SizedBox(
                  width: 200,
                  height: 300,
                  child: buildText(FilteredFilm?.description ?? "No Description", fontSize: 14, fontWeight: FontWeight.normal, fontColor: Colors.white, alignment: TextAlign.justify)    
                 ),
              ],
            ),
          ), ),
       Visibility(
       visible: Carousel,
       child: Container(
          width: 300,
          height: 50,
          child: Row(
          children: [
            GestureDetector(
              child: buildText("Tabela de filmes", fontSize: 20, fontWeight: FontWeight.normal, fontColor: Colors.white, alignment: TextAlign.justify),   
              onTap: (){
                  Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FilmsTable(AllFilms: films)));
                  },
            ),
            Icon(Icons.arrow_circle_right, color: Colors.white, size: 20),
          ],
          ),
        ),),
      
        Visibility(
          visible: Carousel,
          child: Container(
            width: 302,
            height: 260,
          child: SizedBox(
            width: 300,
            height: 200,
            child: CarouselSlider(
            options: CarouselOptions(
            enlargeFactor: 0,
            viewportFraction: 0.6,
            enlargeCenterPage: true,
            enableInfiniteScroll: true,
            autoPlay: true,
          ),
              items: films.map((film) => 
              Column(
                children: [
                  Container(
                    width: 240,
                    height: 180,
                    child: GestureDetector(
                      onTap: (){
                        //AdicionarURL(film.url ?? 'No Url'); 
                      },
                      child: Image.network("${film.image}", fit: BoxFit.fill,),
                    ) 
              ),
              buildText(film.title ?? "No Title", fontSize: 15, fontWeight: FontWeight.normal, fontColor: Colors.white, alignment: TextAlign.justify),
              buildText(film.director ?? "No Director", fontSize: 15, fontWeight: FontWeight.normal, fontColor: Colors.white, alignment: TextAlign.justify),
              buildText(film.releaseDate ?? "No Date", fontSize: 15, fontWeight: FontWeight.normal, fontColor: Colors.white, alignment: TextAlign.justify),
               ],                
              ),
            ).toList(),
               ),
            ),
            ),
        ),
        
        Visibility(
          visible: Carousel,
          child: SizedBox(
            height: 40,
              width: 200,
              child: GestureDetector(
          onTap: (){      
                  Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CreditsPage()));
                  },
          child: Container(
            alignment: AlignmentDirectional.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(200),
              color: const Color.fromARGB(122, 10, 35, 78)
            ),
            child: buildText("CRÉDITOS À API UTILIZADA", fontSize: 10, fontWeight: FontWeight.bold, fontColor: Colors.blue, alignment: TextAlign.center),
            )
            ),
            )),

            Visibility(
          visible: Carousel,
            child:
            Container(
            width: 330,
            height: 50,
            decoration: BoxDecoration(
          ),
                child: Row(
                spacing: 80,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(onPressed: (){
                  Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyApp()));
                  }, icon: Icon(Icons.home, color: Colors.white,)),
                ],
              )       
              )
              ) 
          ], 
        ),
      ),
      )
    );
  }
}