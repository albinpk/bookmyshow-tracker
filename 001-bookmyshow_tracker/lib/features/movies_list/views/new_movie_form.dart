import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants.dart';
import '../../../core/models/models.dart';
import '../movies_list.dart';

/// A form to add new movie to tracking list.
class NewMovieForm extends StatefulWidget {
  const NewMovieForm({super.key, this.url});

  /// Initial Url to show in form.
  final String? url;

  @override
  State<NewMovieForm> createState() => _NewMovieFormState();
}

class _NewMovieFormState extends State<NewMovieForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();

  // To store Form value
  late String _title;
  late String _url;

  /// Whether the form is saving or not.
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.url != null) {
      _titleController.text = _getMovieNameFromLink(widget.url!);
    }
  }

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
                if (context.read<MoviesListCubit>().contains(title: title)) {
                  return 'Title already exist!';
                }
                return null;
              },
              onSaved: (title) => _title = title!.trim(),
            ),
            const SizedBox(height: 20),

            // Url form field
            TextFormField(
              initialValue: widget.url,
              autofocus: true,
              keyboardType: TextInputType.url,
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
                  _titleController.text = _getMovieNameFromLink(url);
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
                if (context.read<MoviesListCubit>().contains(url: url)) {
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
                  onPressed: _isLoading ? null : _onSave,
                  child: _isLoading
                      ? const SizedBox.square(
                          dimension: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        )
                      : const Text('ADD'),
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
      setState(() => _isLoading = true);
      context
          .read<MoviesListCubit>()
          .addMovie(Movie(title: _title, url: _url))
          .then((value) => Navigator.pop(context));
    }
  }

  /// Extract and return movie name from Url.
  String _getMovieNameFromLink(String url) {
    final start = url.indexOf('/movies/', 26) + 8;
    final end = url.indexOf('/ET', start);
    return url
        .substring(start, end)
        .split('-')
        .where((e) => e.isNotEmpty)
        .map((e) => e[0].toUpperCase() + (e.length > 1 ? e.substring(1) : ''))
        .join(' ');
  }
}
