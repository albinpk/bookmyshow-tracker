import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../repository/movies_repository.dart';

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
      subtitle: Text(
        _formatDate(movie.lastChecked),
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Colors.grey,
            ),
      ),
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
              onPressed: () {
                context.read<MoviesRepository>().deleteMovie(movie);
              },
              tooltip: 'Delete',
              icon: const Icon(Icons.delete, color: Colors.redAccent),
            ),
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

  String _formatDate(DateTime? date) {
    if (date == null) return 'Not checked yet.';
    return 'Last check: ${DateFormat().add_jm().addPattern('-').add_MMMd().format(date)}';
  }
}
