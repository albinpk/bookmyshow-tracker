import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BookMyShow Tracker')),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) => MovieTile(index: index),
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
