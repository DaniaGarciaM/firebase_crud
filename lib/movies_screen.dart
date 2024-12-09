import 'package:flutter/material.dart';
import 'package:good_movies/fire_store_service.dart';
import 'package:good_movies/movie.dart';
import 'package:flutter/widgets.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key});

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  final FireStoreService _fireStoreService = FireStoreService();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _starsController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();

  void _addMovie() {
    _fireStoreService.insertData('movies', {
      'name': _nameController.text,
      'year': _yearController.text,
      'stars': _starsController.text
    });
    _nameController.clear();
    _yearController.clear();
    _starsController.clear();
  }

  void _deleteMovie(String docId) {
    _fireStoreService.deleteData('movies', docId);
  }

  void _updateMovie(String docId){
    _fireStoreService.updateData('movies', docId, {
      'name': _nameController.text,
      'year': _yearController.text,
      'stars': _starsController.text
    });
    _nameController.clear();
    _yearController.clear();
    _starsController.clear();
  }

  void _showDialogEdit(Movie movie){
    _nameController.text = movie.name;
    _yearController.text = movie.year;
    _starsController.text = movie.stars;

    showDialog(context: context, builder: 
    (BuildContext context){
      return AlertDialog(title: const Text('Edit movie'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Name'),
          ),
          TextField(
            controller: _yearController,
            decoration: const InputDecoration(labelText: 'Year'),
          ),
          TextField(
            controller: _starsController,
            decoration: const InputDecoration(labelText: 'Stars'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => _updateMovie(movie.id), 
          child: const Text('Save')),
        TextButton(
          onPressed: () => Navigator.of(context).pop(), 
          child: const Text('Cancel'),
          ),
      ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Películas calificadas'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Movie'),
          ),
          TextField(
            controller: _yearController,
            decoration: const InputDecoration(labelText: 'Years'),
          ),
          TextField(
            controller: _starsController,
            decoration: const InputDecoration(labelText: 'Stars'),
          ),
          ElevatedButton(
            onPressed: _addMovie, 
            child: const Text('Add Movie'),
            ),
            const SizedBox(
            height: 20,
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: StreamBuilder(
              stream: _fireStoreService.getData('movies'), 
              builder: (context, AsyncSnapshot<List<Movie>> snapshot) {
                  if(snapshot.hasError){
                    return Text('Error: ${snapshot.error}');
                  }
                  if( snapshot.connectionState == ConnectionState.waiting){
                    return const CircularProgressIndicator();
                  }
                  return ListView(
                    children: snapshot.data!.map((Movie movie) {
                      return ListTile(
                        title: Text(movie.name),
                        subtitle: Text('Year: ${movie.year}, Stars: ${movie.stars}'),
                        onTap: () {
                          _nameController.text = movie.name;
                          _yearController.text = movie.year;
                          _starsController.text = movie.stars;

                          _showDialogEdit(movie);
                        },
                        trailing: IconButton(icon: const Icon(Icons.delete),
                        onPressed: (){
                          _deleteMovie(movie.id);
                        },
                        ),
                      );
                    }).toList(),
                  );
                }
              )
            )
        ],
      ),
    );
  }
}