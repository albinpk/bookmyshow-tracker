import 'package:flutter/material.dart';

/// A form to add new movie to tracking list.
class AddTrackerForm extends StatelessWidget {
  const AddTrackerForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
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
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: const InputDecoration(
                label: Text('BookMyShow link'),
                helperText: 'Link starts with:\n'
                    '"https://in.bookmyshow.com/<place>/movies/"',
                helperMaxLines: 5,
                border: OutlineInputBorder(),
              ),
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
                ElevatedButton(onPressed: () {}, child: const Text('ADD')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
