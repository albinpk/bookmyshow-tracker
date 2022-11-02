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
        itemBuilder: (context, index) {
          return ExpansionTile(
            title: const Text('Movie title'),
            subtitle: const Text('Last checked at 10:30 AM'),
            trailing: ClipOval(
              child: ColoredBox(
                color: index.isOdd ? Colors.green : Colors.grey,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Icon(
                    index.isOdd ? Icons.done : Icons.access_time,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            childrenPadding: const EdgeInsets.symmetric(horizontal: 15),
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    tooltip: 'https://movie/link',
                    icon: const Icon(Icons.open_in_new),
                  ),
                  const Spacer(),
                  const Text('Tracking'),
                  Switch(value: true, onChanged: (v) {}),
                ],
              ),
            ],
          );
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
