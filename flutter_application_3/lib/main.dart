import 'package:flutter/material.dart';
import 'package:flutter_application_3/screen/1_screen.dart';
import 'package:flutter_application_3/screen/2_screen.dart';
import 'package:flutter_application_3/screen/3_screen.dart';
import 'package:flutter_application_3/screen/home_screen.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const _App());
}

class _App extends StatelessWidget {
  const _App({super.key});

  GoRouter get _router => GoRouter(
        initialLocation: '/',
        routes: [
          GoRoute(
            path: '/',
            builder: (_, state) => const HomeScreen(),
            routes: [
              GoRoute(
                path: 'one',
                builder: (_, state) => const OneScreen(),
                routes: [
                  GoRoute(
                    path: 'two',
                    builder: (_, state) => const TwoScreen(),
                    routes: [
                      GoRoute(
                        path: 'three',
                        name: ThreeScreen.routeName,
                        builder: (_, state) => const ThreeScreen(),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      // URI String을 상태 및 go_router에서 사용할 수 있는 형태로
      // 변환 해주는 함수
      // routeInformationParser: _router.routeInformationParser,
      // 위에서 변경된 값으로 실제 어떤 라우트를 보여줄지
      // 정하는 함수
      // routerDelegate: _router.routerDelegate,
      routerConfig: _router,
    );
  }
}
