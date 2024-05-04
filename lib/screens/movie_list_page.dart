import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/movie.dart';
import 'movie_detail_page.dart';

class MovieListPage extends StatefulWidget {
  @override
  _MovieListPageState createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {
  List<Movie> movies = [];
  bool ascendingOrder = true;

  @override
  void initState() {
    super.initState();
    fetchMovies();
  }

  Future<void> fetchMovies() async {
    final response = await http.get(
        Uri.parse('https://raw.githubusercontent.com/andrea689/flutter_course/main/exams/videoteca/movies'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      setState(() {
        movies = List<Movie>.from(jsonData.map((data) => Movie.fromJson(data)));
      });
    } else {
      print('Error fetching movies: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista Film'),
        actions: [
          IconButton(
            icon: Icon(Icons.sort),
            onPressed: () {
              setState(() {
                ascendingOrder = !ascendingOrder;
                movies.sort((a, b) => ascendingOrder
                    ? a.voteAverage.compareTo(b.voteAverage)
                    : b.voteAverage.compareTo(a.voteAverage));
              });
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.network(
              'https://image.tmdb.org/t/p/w200${movies[index].posterPath}',
              width: 50,
            ),
            title: Text(movies[index].title),
            subtitle: Text('Release Date: ${movies[index].releaseDate}\n'
                'Vote Average: ${movies[index].voteAverage.toString()}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieDetailPage(movieId: movies[index].id),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
