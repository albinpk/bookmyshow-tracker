import 'dart:developer';

import 'package:bookmyshow_tracker/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

import '../movies_list.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key});

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  @override
  void initState() {
    super.initState();
    _handleReceiveShareIntent();
  }

  void _handleReceiveShareIntent() async {
    try {
      final text = await ReceiveSharingIntent.getInitialText();
      if (text == null) return;
      if (!text.contains('https://in.bookmyshow.com/')) {
        return _showInvalidUrlSnackbar();
      }
      final start = text.indexOf('https://in.bookmyshow.com/');
      final end = text.indexOf(RegExp(r'\s|$'), start);
      assert(end != -1);
      final url = text.substring(start, end);
      if (!RegExp(bookmyshowUrlRegexp).hasMatch(url)) {
        return _showInvalidUrlSnackbar();
      }
      _showForm(url: url);
    } catch (e) {
      log('Error on receiveShareIntent:', error: e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(),
      body:
          context.select((MoviesListCubit cubit) => cubit.state.movies.isEmpty)
              ? const Center(child: Text('Track a movie'))
              : const MoviesListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: _showForm,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showForm({String? url}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        child: NewMovieForm(url: url),
      ),
    );
  }

  void _showInvalidUrlSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('That is not a valid Url!'),
      ),
    );
  }
}
