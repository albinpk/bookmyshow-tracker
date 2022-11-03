import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(title: const Text('BookMyShow Tracker'));
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
