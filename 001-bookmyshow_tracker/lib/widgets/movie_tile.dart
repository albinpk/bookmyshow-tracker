import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

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
              onPressed: () => _launchUrl(context),
              tooltip: movie.url,
              icon: const Icon(Icons.open_in_new),
            ),
            const Spacer(),
            if (!movie.isBookingAvailable) ...[
              const Text('Tracking'),
              Switch(
                value: movie.trackingEnabled,
                onChanged: (_) {
                  context.read<MoviesRepository>().toggleTracking(movie);
                },
              ),
            ]
          ],
        ),
      ],
    );
  }

  /// Launch movie url on external (bookmyshow) application.
  /// Show SnackBar if it fails.
  Future<void> _launchUrl(BuildContext context) async {
    try {
      if (!await launchUrl(
        Uri.parse(movie.url),
        mode: LaunchMode.externalNonBrowserApplication,
      )) throw 'error';
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Can't open this url"),
        ),
      );
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'Not checked yet.';
    return 'Last check: ${DateFormat().add_jm().addPattern('-').add_MMMd().format(date)}';
  }
}
