import 'package:flutter/material.dart';
import 'package:flutter_application_2/layout/default_;layout.dart';
import 'package:flutter_application_2/riverpod/auto_dispose_modifier_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AutoDisposeModifierScreen extends ConsumerWidget {
  const AutoDisposeModifierScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(autoDisposeModifierProvider);
    return DefaultLayout(
      title: 'AutoDisposeModifierScreen',
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: state.when(
              data: (data) => Text(data.toString()),
              error: (error, stackTrace) => Text(error.toString()),
              loading: () => CircularProgressIndicator()),
        ),
      ),
    );
  }
}
