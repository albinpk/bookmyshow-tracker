import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../movies_list.dart';

class MoviesListView extends StatefulWidget {
  const MoviesListView({super.key});

  @override
  State<MoviesListView> createState() => _MoviesListViewState();
}

class _MoviesListViewState extends State<MoviesListView>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        _refresh();
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        break;
    }
  }

  Future<void> _refresh() => context.read<MoviesListCubit>().refresh();

  @override
  Widget build(BuildContext context) {
    final movies =
        context.select((MoviesListCubit cubit) => cubit.state.movies);
    return RefreshIndicator(
      onRefresh: _refresh,
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
