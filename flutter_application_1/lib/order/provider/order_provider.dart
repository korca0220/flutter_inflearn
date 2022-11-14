import 'package:flutter_application_1/common/model/cursor_pagination_model.dart';
import 'package:flutter_application_1/common/provider/pagination_provider.dart';
import 'package:flutter_application_1/order/model/order_model.dart';
import 'package:flutter_application_1/order/model/post_order_body.dart';
import 'package:flutter_application_1/order/repository/order_repository.dart';
import 'package:flutter_application_1/user/provider/basket_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

final orderProvider =
    StateNotifierProvider<OrderStateProvider, CursorPaginationBase>((ref) {
  final repository = ref.watch(orderReposttoryProvider);
  return OrderStateProvider(ref: ref, repository: repository);
});

class OrderStateProvider
    extends PaginationProvider<OrderModel, OrderRepository> {
  final Ref ref;
  OrderStateProvider({
    required this.ref,
    required super.repository,
  });

  Future<bool> postOrder() async {
    const uuid = Uuid();
    final id = uuid.v4();
    final state = ref.read(basketProvider);

    try {
      await repository.postOrder(
        body: PostOrderBody(
          id: id,
          products: state
              .map(
                (e) => PostOrderBodyProduct(
                  productId: e.product.id,
                  count: e.count,
                ),
              )
              .toList(),
          totalPrice: state.fold(0, (p, n) => p + (n.product.price * n.count)),
          createdAt: DateTime.now().toString(),
        ),
      );
      return true;
    } catch (e, trace) {
      return false;
    }
  }
}
