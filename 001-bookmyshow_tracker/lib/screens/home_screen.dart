import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../repository/movies_repository.dart';
import '../views/views.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(),
      body: context.select((MoviesRepository repo) => repo.movies.isEmpty)
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
        child: AddTrackerForm(),
      ),
    );
  }
}
