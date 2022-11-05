import 'package:flutter/material.dart';
import 'package:flutter_application_3/provider/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: _App()));
}

class _App extends ConsumerWidget {
  const _App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      // URI String을 상태 및 go_router에서 사용할 수 있는 형태로
      // 변환 해주는 함수
      // routeInformationParser: _router.routeInformationParser,

      // 위에서 변경된 값으로 실제 어떤 라우트를 보여줄지
      // 정하는 함수
      // routerDelegate: _router.routerDelegate,
      routerConfig: router,
    );
  }
}
