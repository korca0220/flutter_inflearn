import 'package:flutter/material.dart';
import 'package:flutter_application_1/common/component/pagination_list_view.dart';
import 'package:flutter_application_1/order/component/order_card.dart';
import 'package:flutter_application_1/order/provider/order_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderScreen extends ConsumerWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PaginationListView(
      provider: orderProvider,
      itemBuilder: <OrderMOdel>(context, index, model) {
        return OrderCard.fromModel(model: model);
      },
    );
  }
}
