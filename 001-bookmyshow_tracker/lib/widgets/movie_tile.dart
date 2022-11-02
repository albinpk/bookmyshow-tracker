import 'package:flutter/material.dart';

class MovieTile extends StatelessWidget {
  const MovieTile({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
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
  }
}
