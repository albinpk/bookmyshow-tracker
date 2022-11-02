import 'package:flutter/material.dart';

import '../models/models.dart';

class MovieTile extends StatelessWidget {
  const MovieTile({
    super.key,
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(movie.title),
      subtitle: const Text('Last checked at 10:30 AM'),
      trailing: ClipOval(
        child: ColoredBox(
          color: movie.isBookingAvailable
              ? Colors.green
              : movie.trackingEnabled
                  ? Colors.orange
                  : Colors.grey,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Icon(
              movie.isBookingAvailable
                  ? Icons.done
                  : movie.trackingEnabled
                      ? Icons.access_time
                      : Icons.not_interested,
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
              tooltip: movie.url,
              icon: const Icon(Icons.open_in_new),
            ),
            const Spacer(),
            const Text('Tracking'),
            Switch(
              value: movie.trackingEnabled,
              onChanged: (v) {},
            ),
          ],
        ),
      ],
    );
  }
}
