import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../movies_list.dart';

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(),
      body:
          context.select((MoviesListCubit cubit) => cubit.state.movies.isEmpty)
              ? const Center(child: Text('Track a movie'))
              : const MoviesListView(),
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
        child: NewMovieForm(),
      ),
    );
  }
}
