import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../background_fetch/background_fetch.dart';
import '../movies_list.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('BookMyShow Tracker'),
      actions: const [_ToggleSwitch()],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _ToggleSwitch extends StatefulWidget {
  const _ToggleSwitch({Key? key}) : super(key: key);

  @override
  State<_ToggleSwitch> createState() => _ToggleSwitchState();
}

class _ToggleSwitchState extends State<_ToggleSwitch> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MoviesListCubit, MoviesListState>(
      listener: (context, state) {
        if (state.movies.where((m) => m.trackingEnabled).isEmpty) {
          context.read<BackgroundFetchCubit>().stop();
        }
      },
      buildWhen: (previous, current) =>
          previous.movies.where((m) => m.trackingEnabled).isEmpty !=
          current.movies.where((m) => m.trackingEnabled).isEmpty,
      builder: (context, state) {
        return Switch(
          value: context.select((BackgroundFetchCubit p) => p.state.isActive),
          onChanged: state.movies.where((m) => m.trackingEnabled).isNotEmpty
              ? (v) => v
                  ? context.read<BackgroundFetchCubit>().start()
                  : context.read<BackgroundFetchCubit>().stop()
              : null,
        );
      },
    );
  }
}
