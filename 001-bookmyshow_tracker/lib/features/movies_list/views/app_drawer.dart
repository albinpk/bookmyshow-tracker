import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/models/models.dart';
import '../../background_fetch/background_fetch.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Center(
        child: ListTile(
          style: ListTileStyle.drawer,
          title: const Text('Frequency'),
          trailing: Builder(
            builder: (context) {
              final selectedFrequency = context.select(
                (BackgroundFetchCubit cubit) => cubit.state.frequency,
              );
              return PopupMenuButton<BackgroundTaskFrequency>(
                initialValue: selectedFrequency,
                onSelected: (frequency) {
                  context
                      .read<BackgroundFetchCubit>()
                      .changeFrequency(frequency);
                },
                itemBuilder: (context) {
                  return BackgroundTaskFrequency.values
                      .map((e) => PopupMenuItem<BackgroundTaskFrequency>(
                            value: e,
                            child: Text(e.name),
                          ))
                      .toList();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(selectedFrequency.name),
                      const Icon(Icons.arrow_drop_down),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
