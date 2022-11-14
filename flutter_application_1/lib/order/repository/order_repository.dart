import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_application_1/common/const/data.dart';
import 'package:flutter_application_1/common/dio/dio.dart';
import 'package:flutter_application_1/order/model/order_model.dart';
import 'package:flutter_application_1/order/model/post_order_body.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

part 'order_repository.g.dart';

final orderReposttoryProvider = Provider<OrderRepository>((ref) {
  final dio = ref.watch(dioProvider);

  return OrderRepository(dio, baseUrl: 'http://$ip/order');
});

// http://$ip/order
@RestApi()
abstract class OrderRepository {
  factory OrderRepository(Dio dio, {String baseUrl}) = _OrderRepository;

  @POST('/')
  @Headers({'accessToekn': 'true'})
  Future<OrderModel> postOrder({
    @Body() required PostOrderBody body,
  });
}
