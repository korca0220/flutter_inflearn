import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/layout/default_;layout.dart';
import 'package:flutter_application_2/riverpod/future_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FutureProviderScreen extends ConsumerWidget {
  const FutureProviderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue state = ref.watch(multipleFutureProvider);

    return DefaultLayout(
      title: 'FutureProviderScreen',
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            state.when(data: (data) {
              return Text(
                data.toString(),
                textAlign: TextAlign.center,
              );
            }, error: (error, stackTrace) {
              return Text(error.toString());
            }, loading: () {
              return Center(child: CircularProgressIndicator());
            })
          ],
        ),
      ),
    );
  }
}
