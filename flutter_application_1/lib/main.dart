import 'package:flutter/material.dart';
import 'package:flutter_application_1/common/component/custom_text_form_field.dart';
import 'package:flutter_application_1/common/view/splash_screen.dart';
import 'package:flutter_application_1/user/view/login_screen.dart';

void main() {
  runApp(const _App());
}

class _App extends StatelessWidget {
  const _App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'NotoSans'),
      home: const SplashScreen(),
    );
  }
}
