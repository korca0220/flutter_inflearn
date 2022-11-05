import 'package:flutter/material.dart';
import 'package:flutter_application_3/layout/default_layout.dart';
import 'package:flutter_application_3/screen/3_screen.dart';
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
          ),
          ElevatedButton(
            onPressed: () {
              // one, two 는 push 하지 않았지만 밑에 깔리게 됨
              context.goNamed(ThreeScreen.routeName);
            },
            child: const Text('Screen Three (GO)'),
          ),
        ],
      ),
    );
  }
}
