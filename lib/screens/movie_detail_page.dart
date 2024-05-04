import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MovieDetailPage extends StatelessWidget {
  final int movieId;

  const MovieDetailPage({Key? key, required this.movieId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dettaglio Film'),
      ),
      body: FutureBuilder(
        future: fetchMovieDetails(movieId),
        builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Errore durante il caricamento dei dettagli del film'));
          } else {
            final movieDetails = snapshot.data!;
            final backdropUrl = movieDetails['backdrop_path'];
            return SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    backdropUrl,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Titolo: ${movieDetails['title']}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  if (movieDetails['original_title'] != movieDetails['title'])
                    Text('Titolo Originale: ${movieDetails['original_title']}'),
                  Text('Descrizione: ${movieDetails['overview']}'),
                  Text('Data di Uscita: ${movieDetails['release_date']}'),
                  Text('Voto Medio: ${movieDetails['vote_average'].toString()}'),
                  Text('Numero di Voti: ${movieDetails['vote_count'].toString()}'),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Future<Map<String, dynamic>> fetchMovieDetails(int movieId) async {
    final response = await http.get(
        Uri.parse('https://raw.githubusercontent.com/andrea689/flutter_course/main/exams/videoteca/movie_details/$movieId'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load movie details');
    }
  }
}
