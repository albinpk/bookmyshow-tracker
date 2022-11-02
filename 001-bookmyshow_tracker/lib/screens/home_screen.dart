import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

import '../models/models.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final _localStorage = LocalStorage(
    'bookmyshow-tracking.json',
    null,
    {
      'movies': [
        const Movie(
          title: 'Black panther',
          url: 'black/panther/url/',
        ).toMap(),
      ],
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BookMyShow Tracker')),
      body: FutureBuilder<bool>(
        future: _localStorage.ready,
        builder: (context, snapshot) {
          if (snapshot.hasError) return const Center(child: Text('An Error'));

          if (snapshot.hasData) {
            if (!snapshot.data!) return const Center(child: Text('Some error'));

            final List<Movie> movies =
                (_localStorage.getItem('movies') as List? ?? [])
                    .map((e) => Movie.fromMap(e))
                    .toList();

            if (movies.isEmpty) {
              return const Center(child: Text('Track a movie'));
            }

            return ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, i) => MovieTile(movie: movies[i]),
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onFabTap(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _onFabTap(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Dialog(
        child: AddTrackerForm(),
      ),
    );
  }
}
