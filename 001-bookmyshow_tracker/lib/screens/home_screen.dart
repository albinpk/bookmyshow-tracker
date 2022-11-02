import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BookMyShow Tracker')),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return ListTile(
            title: const Text('Movie title'),
            subtitle: const Text('Last checked at 10:30 AM'),
            trailing: ClipOval(
              child: ColoredBox(
                color: index.isOdd ? Colors.green : Colors.redAccent,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Icon(index.isOdd ? Icons.done : Icons.close),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
