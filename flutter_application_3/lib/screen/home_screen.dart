import 'package:flutter/material.dart';
import 'package:flutter_application_3/layout/default_layout.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
            onPressed: () {
              context.go('/one');
            },
            child: const Text('Screen One (GO)'),
          )
        ],
      ),
    );
  }
}
