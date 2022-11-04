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
    // WidgetsBinding.instance.addObserver(this);
    // WidgetsBinding.instance.addPostFrameCallback(_startRefreshTimer);
    // _timer = _getTimer;
  }

  // Timer get _getTimer => Timer.periodic(
  //       const Duration(seconds: 1),
  //       (timer) {
  //         log('Refresh ${_timer!.tick}');
  //         context.read<MoviesRepository>().refresh();
  //       },
  //     );

  @override
  void dispose() {
    // WidgetsBinding.instance.removeObserver(this);
    // _timer?.cancel();
    super.dispose();
  }

  // Timer? _timer;

  // void _startRefreshTimer(_) {
  //   final movies = context.read<MoviesRepository>().movies;
  //   if (movies.where((m) => m.trackingEnabled).isEmpty) return;
  // }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   super.didChangeAppLifecycleState(state);
  //   switch (state) {
  //     case AppLifecycleState.paused:
  //       _timer?.cancel();
  //       break;
  //     case AppLifecycleState.resumed:
  //       _timer = _getTimer;
  //       break;

  //     default:
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final movies =
        context.select((MoviesListCubit cubit) => cubit.state.movies);
    return RefreshIndicator(
      onRefresh: () => context.read<MoviesListCubit>().refresh(),
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
