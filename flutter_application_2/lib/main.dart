import 'package:flutter/material.dart';
import 'package:flutter_application_2/riverpod/provider_observer.dart';
import 'package:flutter_application_2/screen/home_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    ProviderScope(
      observers: [
        Logger(),
      ],
      child: const MaterialApp(
        home: HomeScreen(),
      ),
    ),
  );
}
