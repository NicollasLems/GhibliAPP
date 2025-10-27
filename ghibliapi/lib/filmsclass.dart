
class Film {
  String? id;
  String? title;
  String? originalTitle;
  String? image;
  String? originalTitleRomanised;
  String? description;
  String? director;
  String? producer;
  String? releaseDate;
  String? runningTime;
  String? rtScore;
  String? url;
  List<String>? people;
  List<String>? species;
  List<String>? locations;
  List<String>? vehicles;

  Film({
    this.id,
    this.title,
    this.originalTitle,
    this.image,
    this.originalTitleRomanised,
    this.description,
    this.director,
    this.producer,
    this.releaseDate,
    this.runningTime,
    this.rtScore,
    this.url,
    this.people,
    this.species,
    this.locations,
    this.vehicles,
  });

  /// Construtor completo — converte um JSON em um objeto Film
  Film.fromJson(Map<String, dynamic> data)
      : id = data['id'] as String?,
        title = data['title'] as String?,
        originalTitle = data['original_title'] as String?,
        originalTitleRomanised = data['original_title_romanised'] as String?,
        image = data['image'] as String?,
        description = data['description'] as String?,
        director = data['director'] as String?,
        producer = data['producer'] as String?,
        releaseDate = data['release_date'] as String?,
        runningTime = data['running_time'] as String?,
        rtScore = data['rt_score'] as String?,
        people = const [],
        species = const [],
        locations = const [],
        vehicles = const [],
        url = data['url'] as String?;
}

class Person {
  String? id;
  String? name;
  String? gender;
  String? age;
  String? eyeColor;
  String? hairColor;
  String? species;
  String? url;
  List<String>? films; 
  Person({
    this.id,
    this.name,
    this.gender,
    this.age,
    this.eyeColor,
    this.hairColor,
    this.species,
    this.url,
    this.films,
  });

  Person.fromJson(Map<String, dynamic> data)
      : id = data['id'] as String?,
        name = data['name'] as String?,
        gender = data['gender'] as String?,
        age = data['age'] as String?,
        eyeColor = data['eye_color'] as String?,
        hairColor = data['hair_color'] as String?,
        species = data['species'] as String?,
        url = data['url'] as String?,
        films = (data['films'] as List<dynamic>?)
            ?.map((film) => film as String)
            .toList();
}
