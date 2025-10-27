import 'package:flutter/material.dart';
import 'filmsclass.dart';

class Persons extends StatefulWidget {
  final List<Person> People;

  const Persons({super.key, required  this.People});

  @override
  State<Persons> createState() => _FilmsTableState();
}

class _FilmsTableState extends State<Persons> {
  @override
  
  void initState() {
    super.initState();
    ();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(10, 18, 60, 1),
      appBar: AppBar(
        title: const Text('Tabela de Personagens do Estúdio Ghibli', style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        ),
        backgroundColor: const Color.fromARGB(255, 4, 8, 59),
      ),
      body: ListView.builder(
        itemCount: widget.People.length,
        itemBuilder: (context, index) {
          final people = widget.People[index];
          return SizedBox(
           height: 200,
           width: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(255, 9, 68, 95),
                ),
                child:  Column(
                children: [
                  Text("${people.name ?? 'No Name'} - Características do Personagem:", style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),),
                  Text("Name: ${people.name ?? 'No Name'}", style: TextStyle(
                    color: Colors.white),),
                  Text("Age: ${people.age ?? 'No Age'}", style: TextStyle(
                    color: Colors.white),),
                  Text("Hair Color: ${people.hairColor ?? 'No HairColor'} ", style: TextStyle(
                    color: Colors.white),),
                  Text("Eye Color: ${people.eyeColor ?? 'No EyeColor'}", style: TextStyle(
                    color: Colors.white),),
                  Text("Gender: ${people.gender ?? 'No Gender'}", style: TextStyle(
                    color: Colors.white),),
                ],
              ),
              ),
            ],
           ),
          );

        },
      ),
    );
  }
}