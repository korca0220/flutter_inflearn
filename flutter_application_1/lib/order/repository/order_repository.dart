import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_application_1/common/const/data.dart';
import 'package:flutter_application_1/common/dio/dio.dart';
import 'package:flutter_application_1/common/model/cursor_pagination_model.dart';
import 'package:flutter_application_1/common/model/pagination_params.dart';
import 'package:flutter_application_1/common/repository/base_pagination_repository.dart';
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
abstract class OrderRepository
    implements IBasePaginationRepository<OrderModel> {
  factory OrderRepository(Dio dio, {String baseUrl}) = _OrderRepository;

  @override
  @GET('/')
  @Headers({'accessToekn': 'true'})
  Future<CursorPaginationModel<OrderModel>> paginate({
    @Queries() PaginationParams? paginationParams = const PaginationParams(),
  });

  @POST('/')
  @Headers({'accessToekn': 'true'})
  Future<OrderModel> postOrder({
    @Body() required PostOrderBody body,
  });
}
