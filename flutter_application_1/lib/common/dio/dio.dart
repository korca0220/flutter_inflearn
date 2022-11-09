import 'package:dio/dio.dart';
import 'package:flutter_application_1/common/const/data.dart';
import 'package:flutter_application_1/secure_storage/secure_storage.dart';
import 'package:flutter_application_1/user/provider/auth_provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioProvider = Provider<Dio>(
  (ref) {
    final dio = Dio();
    final storage = ref.watch(secureStorageProvider);
    dio.interceptors.add(
      CustomInterceptor(storage: storage, ref: ref),
    );
    return dio;
  },
);

class CustomInterceptor extends Interceptor {
  final FlutterSecureStorage storage;
  final Ref ref;
  CustomInterceptor({
    required this.storage,
    required this.ref,
  });
  // 1) 요청을 보낼떄
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    print('[REQ] [${options.method}] ${options.uri}');

    if (options.headers['accessToken'] == 'true') {
      options.headers.remove('accessToken');
      final token = await storage.read(key: ACCESS_TOKEN_KEY);
      options.headers.addAll({
        'authorization': 'Bearer $token',
      });
    }

    if (options.headers['refreshToken'] == 'true') {
      options.headers.remove('refreshToken');
      final token = await storage.read(key: REFRESH_TOKEN_KEY);
      options.headers.addAll({
        'authorization': 'Bearer $token',
      });
    }

    return super.onRequest(options, handler);
  }

  // 2) 응답을 받을때
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
        '[RES] [${response.requestOptions.method}] ${response.requestOptions.uri}');

    return super.onResponse(response, handler);
  }

  // 3) 에러가 났을때
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    // 401 error (status code)
    // 토큰을 재발급 받는 시도를하고 토큰이 재발급 되면 다시 새로운 토큰을 요청

    print('[ERR] [${err.requestOptions.method}] ${err.requestOptions.uri}');
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
    // RefreshToken이 없는 경우(로그인 정보가 없음)
    if (refreshToken == null) {
      return handler.reject(err);
    }

    final isStatus401 = err.response?.statusCode == 401;
    final isPathRefresh = err.requestOptions.path == '/auth/token';
    // 401 Error 인데 AccessToken 재발급 하는 경우 아님
    // AccessToken 재발급 API 를 제외한 모두
    if (isStatus401 && !isPathRefresh) {
      final dio = Dio();

      try {
        final resp = await dio.post(
          'http://$ip/auth/token',
          options: Options(
            headers: {
              'authorization': 'Bearer $refreshToken',
            },
          ),
        );
        final accessToken = resp.data['accessToken'];
        final options = err.requestOptions;

        // 기존 토큰 변경
        options.headers.addAll(
          {
            'authorization': 'Bearer $accessToken',
          },
        );
        await storage.write(key: ACCESS_TOKEN_KEY, value: accessToken);

        // 재요청
        final response = await dio.fetch(options);
        return handler.resolve(response);
      } on DioError catch (e) {
        ref.read(authProvider.notifier).logout();
        return handler.reject(e);
      }
    }

    return super.onError(err, handler);
  }
}
