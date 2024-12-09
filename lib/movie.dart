import 'package:cloud_firestore/cloud_firestore.dart';

class Movie {
  final String id;
  final String name;
  final String stars;
  final String year;

  Movie(
      {required this.id,
      required this.name,
      required this.stars,
      required this.year});

  //Convertir un Movie a Map
  Map<String, dynamic> toMap() {
    return {'name': name, 'stars': stars, 'year': year};
  }

  //Crear un Movie desde un DocumentSnapshot
  factory Movie.fromDocumentSnapShot(DocumentSnapshot doc) {
    return Movie(
        id: doc.id, 
        name: doc['name'], 
        stars: doc['stars'], 
        year: doc['year'],);
  }
}
