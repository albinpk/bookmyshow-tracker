import 'package:flutter/material.dart';

import '../constants.dart';
import '../models/models.dart';

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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Add a movie to track',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: const InputDecoration(
                label: Text('Title'),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value?.trim().isEmpty ?? true) {
                  return 'Please enter a title!';
                }
                return null;
              },
              onSaved: (value) => _title = value!.trim(),
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: const InputDecoration(
                label: Text('BookMyShow url'),
                helperText: 'Url starts with:\n'
                    '"https://in.bookmyshow.com/<place>/movies/"',
                helperMaxLines: 5,
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value?.trim().isEmpty ?? true) {
                  return 'Please enter the movie Url!';
                }
                value = value!.trim();
                if (!RegExp(bookmyshowUrlRegexp).hasMatch(value)) {
                  return 'Please enter a valid Url!';
                }
                return null;
              },
              onSaved: (value) => _url = value!.trim(),
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
      final movie = Movie(title: _title, url: _url);
      print(movie);
    }
  }
}
