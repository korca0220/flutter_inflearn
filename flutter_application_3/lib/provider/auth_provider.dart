import 'package:flutter/material.dart';
import 'package:flutter_application_3/model/user_model.dart';
import 'package:flutter_application_3/screen/1_screen.dart';
import 'package:flutter_application_3/screen/2_screen.dart';
import 'package:flutter_application_3/screen/3_screen.dart';
import 'package:flutter_application_3/screen/error_screen.dart';
import 'package:flutter_application_3/screen/home_screen.dart';
import 'package:flutter_application_3/screen/login_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>(
  (ref) {
    final authStateProvider = AuthNotifier(ref: ref);

    return GoRouter(
      initialLocation: '/',

      // Only navigation error
      errorBuilder: (context, state) {
        return ErrorScreen(error: state.error.toString());
      },
      routes: authStateProvider._routes,

      // navigation 을 하는 경우에만 redirect
      redirect: authStateProvider._redirectLogic,

      // 상태가 변경될 때마다 redirect 를 실행할 수 있게 해줌
      // 현재는 [authStateProvider] 에서 listen 하고 있는 상태에 해당됨
      // 상태 => 로그인/로그아웃 상태
      refreshListenable: authStateProvider,
    );
  },
);

class AuthNotifier extends ChangeNotifier {
  final Ref ref;
  AuthNotifier({
    required this.ref,
  }) {
    ref.listen<UserModel?>(
      userProvider,
      (previous, next) {
        if (previous != next) {
          notifyListeners();
        }
      },
    );
  }
  String? _redirectLogic(BuildContext context, GoRouterState state) {
    final UserModel? user = ref.read(userProvider);

    // 로그인을 하려는 상태인지
    final loggingIn = state.location == '/login';

    // 1) 유저 정보가 없다 - 로그인한 상태가 아니다
    //
    // 유저 정보가 없고 && 로그인하려는 중이 아니라면
    // 로그인 페이지로 이동한다
    if (user == null) {
      return loggingIn ? null : '/login';
    }

    // 2) 유저 정보가 있는데 로그인 페이지라면
    // 홈으로 이동
    if (loggingIn) {
      return '/';
    }

    return null;
  }

  List<GoRoute> get _routes => [
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
        GoRoute(
          path: '/login',
          name: 'login',
          builder: (_, state) => const LoginScreen(),
        ),
      ];
}

final userProvider = StateNotifierProvider<UserStateNotifier, UserModel?>(
    (ref) => UserStateNotifier());

// 로그인한 상태면 UserMOdel 인스턴스 상태로 넣어주기
// 로그아웃 상태면 null 상태로 넣어주기
class UserStateNotifier extends StateNotifier<UserModel?> {
  UserStateNotifier() : super(null);

  login({required String name}) {
    state = UserModel(name: name);
  }

  logout() {
    state = null;
  }
}
