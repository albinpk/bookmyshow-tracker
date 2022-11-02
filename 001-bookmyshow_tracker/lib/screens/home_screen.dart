import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

import '../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final _localStorage = LocalStorage('bookmyshow-tracking.json');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BookMyShow Tracker')),
      body: FutureBuilder<bool>(
        future: _localStorage.ready,
        builder: (context, snapshot) {
          if (snapshot.hasError) return const Center(child: Text('An Error'));

          if (snapshot.hasData) {
            if (!snapshot.data!) return const Center(child: Text('Some error'));

            return ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) => MovieTile(index: index),
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
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
