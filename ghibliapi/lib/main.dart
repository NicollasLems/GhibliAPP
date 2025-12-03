import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:ghibliapi/films_table.dart';
import 'package:ghibliapi/persons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'firstpage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'filmsclass.dart';
import 'Credits.dart';

void main() {
  runApp(const FilmsPage());
}

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
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {  
    Future<void> AdicionarURL(String url) async {
  final Uri uri = Uri.parse(url);
  launchUrl(uri);
}
  Film? FilteredFilm;
  List<Film> Favoritefilms = [];
  List<Film> films = [];

  List<Person> people = [];
//  List<Person> FindPersonFilm = [];

  int currentIndex = 0;

  bool HasImage = true;
  bool Carousel = true;
  bool Search = false;

@override
void initState(){
  super.initState();
  getFilm();
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
              child: Text(
                "Ghibli Wiki",
              style: TextStyle(
                fontSize: 30,
                color:  Colors.blue,
              ),
              ),
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
    (film) => (film.title ?? '').toLowerCase() == inputName.toLowerCase(),
    );
    
 if (filmFound == ''){
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
                child: Text("Escolha dos Editores",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
              ),
              ),
              DotsIndicator(
              decorator: DotsDecorator(
              size: const Size(5, 5),
              activeColor: Colors.grey,
              activeSize: const Size(5,5),
              color: Colors.black,
              ),
              dotsCount: Favoritefilms.length,
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
                  child: Text(FilteredFilm?.title ?? "No Title",
                  textAlign: TextAlign.center, 
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                  ),
                  ),
                 ),
                SizedBox(
                  width: 200,
                  child: Text(FilteredFilm?.director ?? 'No Director',
                    textAlign: TextAlign.center, 
                    style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                  ),),
                 ),
                SizedBox(
                  width: 200,
                  height: 300,
                  child: Text(FilteredFilm?.description ?? "No Description",
                  textAlign: TextAlign.justify,
                   style: TextStyle(
                    color: Colors.white,
                    fontSize: 14
                  ),),
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
              child: Text("Tabela de filmes",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            )),
           
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
                  Text(film.title ?? 'No Title', 
                  style: TextStyle(
                    color: Colors.white),
                  ),
                  Text(film.director ?? "No Director",
                  style: TextStyle(
                    color: Colors.white),
                  ),
                  Text(film.releaseDate ?? "No Date", 
                  style: TextStyle(
                    color: Colors.white),
                  ),
                

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
            height: 50,
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
            child: Text(
            "CRÉDITOS À API UTILIZADA",
             textAlign: TextAlign.center,
             style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue,
              fontSize: 10,
             ),),
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
                  MaterialPageRoute(builder: (context) => StartPage()));
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