import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../repository/movies_repository.dart';
import '../widgets/widgets.dart';

class MoviesListView extends StatelessWidget {
  const MoviesListView({super.key});

  @override
  Widget build(BuildContext context) {
    final movies = context.watch<MoviesRepository>().movies;
    return RefreshIndicator(
      onRefresh: () => context.read<MoviesRepository>().refresh(),
      child: ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, i) => MovieTile(
          key: Key(movies[i].id),
          movie: movies[i],
        ),
      ),
    );
  }
}
