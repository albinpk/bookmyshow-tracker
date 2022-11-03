import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../models/models.dart';
import '../repository/movies_repository.dart';

/// A form to add new movie to tracking list.
class AddTrackerForm extends StatefulWidget {
  const AddTrackerForm({super.key});

  @override
  State<AddTrackerForm> createState() => _AddTrackerFormState();
}

class _AddTrackerFormState extends State<AddTrackerForm> {
  final _formKey = GlobalKey<FormState>();

  // To store Form value
  late String _title;
  late String _url;

  final _titleController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Form title
            Text(
              'Add a movie to track',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),

            // Title form field
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                label: Text('Title'),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.next,
              validator: (title) {
                if (title?.trim().isEmpty ?? true) {
                  return 'Please enter a title!';
                }
                title = title!.trim();
                if (context.read<MoviesRepository>().contains(title: title)) {
                  return 'Title already exist!';
                }
                return null;
              },
              onSaved: (title) => _title = title!.trim(),
            ),
            const SizedBox(height: 20),

            // Url form field
            TextFormField(
              autofocus: true,
              decoration: const InputDecoration(
                label: Text('BookMyShow url'),
                helperText: 'Url starts with:\n'
                    '"https://in.bookmyshow.com/<place>/movies/"',
                helperMaxLines: 5,
                border: OutlineInputBorder(),
              ),
              onChanged: (url) {
                if (_titleController.text.trim().isNotEmpty) return;
                url = url.trim();
                if (RegExp(bookmyshowUrlRegexp).hasMatch(url)) {
                  final start = url.indexOf('/movies/', 26) + 8;
                  final end = url.indexOf('/ET', start);
                  final name = url.substring(start, end);
                  _titleController.text = name
                      .split('-')
                      .where((e) => e.isNotEmpty)
                      .map((e) =>
                          e[0].toUpperCase() +
                          (e.length > 1 ? e.substring(1) : ''))
                      .join(' ');
                }
              },
              onFieldSubmitted: (_) => _onSave(),
              validator: (url) {
                if (url?.trim().isEmpty ?? true) {
                  return 'Please enter the movie Url!';
                }
                url = url!.trim();
                if (!RegExp(bookmyshowUrlRegexp).hasMatch(url)) {
                  return 'Please enter a valid Url!';
                }
                if (context.read<MoviesRepository>().contains(url: url)) {
                  return 'Url already exist!';
                }
                return null;
              },
              onSaved: (url) => _url = url!.trim(),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('CANCEL'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _onSave,
                  child: const Text('ADD'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _onSave() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      context
          .read<MoviesRepository>()
          .addMovie(Movie(title: _title, url: _url));
      Navigator.pop(context);
    }
  }
}
