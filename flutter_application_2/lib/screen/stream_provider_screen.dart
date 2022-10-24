import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/layout/default_;layout.dart';
import 'package:flutter_application_2/riverpod/stream_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StreamProviderScreen extends ConsumerWidget {
  const StreamProviderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(multipleStreamProvider);
    return DefaultLayout(
      title: 'StreamProviderScreen',
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
