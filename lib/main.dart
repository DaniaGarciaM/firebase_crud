import 'package:flutter/material.dart';
import 'package:good_movies/movies_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
    apiKey: 'AIzaSyBjDswZe4QxEvbEPeTezEvd-AqqPHAQaEw',
    appId: '1:703878788378:android:32f6b0bcef7431b1e428a3',
    messagingSenderId: '703878788378',
    projectId: 'good-movies-53cc5',
    storageBucket: 'good-movies-53cc5.firebasestorage.app',
  ));
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MoviesScreen(),
    );
  }
}
