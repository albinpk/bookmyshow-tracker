import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../background_task.dart';
import '../repository/movies_repository.dart';

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
  bool _isOn = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (context
        .read<MoviesRepository>()
        .movies
        .where((m) => m.trackingEnabled)
        .isEmpty) setState(() => _isOn = false);
  }

  @override
  Widget build(BuildContext context) {
    final haveMoviesToTrack = context.select((MoviesRepository repo) {
      return repo.movies.where((m) => m.trackingEnabled).isNotEmpty;
    });
    return Switch(
      value: haveMoviesToTrack ? _isOn : false,
      onChanged: haveMoviesToTrack ? (v) => _onSwitch(v, context) : null,
      inactiveThumbColor: Colors.grey,
    );
  }

  void _onSwitch(bool value, BuildContext context) {
    if (value) {
      BackgroundTask.startBackgroundTask().then((value) {
        setState(() => _isOn = true);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Background service started'),
          ),
        );
      });
    } else {
      BackgroundTask.stopBackgroundTask().then((value) {
        setState(() => _isOn = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Background service stopped'),
          ),
        );
      });
    }
  }
}
