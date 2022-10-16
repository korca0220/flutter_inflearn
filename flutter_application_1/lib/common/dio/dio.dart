import 'package:dio/dio.dart';
import 'package:flutter_application_1/common/const/data.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CustomINterceptor extends Interceptor {
  final FlutterSecureStorage storage;
  CustomINterceptor({
    required this.storage,
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
  // 3) 에러가 났을때

}
