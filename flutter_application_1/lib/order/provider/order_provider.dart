import 'package:flutter_application_1/order/model/order_model.dart';
import 'package:flutter_application_1/order/model/post_order_body.dart';
import 'package:flutter_application_1/order/repository/order_repository.dart';
import 'package:flutter_application_1/user/provider/basket_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

final orderProvider =
    StateNotifierProvider<OrderStateProvider, List<OrderModel>>((ref) {
  final repository = ref.watch(orderReposttoryProvider);
  return OrderStateProvider(ref: ref, repository: repository);
});

class OrderStateProvider extends StateNotifier<List<OrderModel>> {
  final Ref ref;
  final OrderRepository repository;
  OrderStateProvider({
    required this.ref,
    required this.repository,
  }) : super([]);

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
