import 'package:flutter/material.dart';
import 'home.dart';
import 'class.dart';
import 'methods.dart';

class FilmsTable extends StatefulWidget {
  final List<Film> AllFilms;
  
  const FilmsTable({super.key, required this.AllFilms});

  @override
  State<FilmsTable> createState() => _FilmsTable();
}

class _FilmsTable extends State<FilmsTable> {



  @override
  
  void initState() {
    super.initState();
    ();
  }



   @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: IconButton(onPressed:() {
      Navigator.push(context,
      MaterialPageRoute(builder: (context) => FilmsPage()));
      }, icon: Icon(Icons.subdirectory_arrow_left_outlined, color: Colors.white,)),

      body: ListView.builder(
        itemExtent: 300,
        itemCount: widget.AllFilms.length,
        itemBuilder: (context, index) {
          final film = widget.AllFilms[index];
          return Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 4, 44, 64),
            ),
            child: Row(
              mainAxisAlignment:MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 450,
                  height: 600,
                  child:  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.circular(20),
                      color: const Color.fromARGB(31, 108, 196, 255),
                    ),
                    child: Row(

                   mainAxisAlignment:MainAxisAlignment.center,
                  children: [ 
                  SizedBox(
                    width: 200,
                    height: 250,
                    child: Image(image: NetworkImage(film.image ?? "No Image"), fit: BoxFit.fill,),
                  ),
                 SizedBox(
                  width: 10,
                 ),
                Column(
                  children: [
                      buildText(film.title ?? 'No Title', fontSize: 10, fontColor: Colors.white, fontWeight: FontWeight.bold, alignment: TextAlign.center),
                      buildText(film.releaseDate ?? 'No Date', fontSize: 5, fontColor: Colors.white, fontWeight: FontWeight.bold, alignment: TextAlign.center),
                SizedBox(
                      width: 200,
                      height: 200,
                      child: buildText(film.description ?? 'No Desc', fontSize: 5,  fontColor: Colors.white, fontWeight: FontWeight.bold, alignment: TextAlign.justify)
                      )     
                  ],
                     ),
                  ]
                ),
                  ),   
                )
              ],
            ),
          );
        },
      ),
      
    );
  }

}
