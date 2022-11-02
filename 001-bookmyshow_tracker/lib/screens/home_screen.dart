import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../repository/movies_repository.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final movies = context.watch<MoviesRepository>().movies;
    return Scaffold(
      appBar: AppBar(title: const Text('BookMyShow Tracker')),
      body: movies.isEmpty
          ? const Center(child: Text('Track a movie'))
          : ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, i) => MovieTile(
                key: Key(movies[i].id),
                movie: movies[i],
              ),
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
