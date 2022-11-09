import 'package:flutter/material.dart';
import 'package:flutter_application_1/common/component/pagination_list_view.dart';
import 'package:flutter_application_1/restaurant/component/restaurant_card.dart';
import 'package:flutter_application_1/restaurant/provider/restaurant_provider.dart';
import 'package:flutter_application_1/restaurant/view/restaurant_detail_screen.dart';
import 'package:go_router/go_router.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PaginationListView(
      provider: restaurantProvider,
      itemBuilder: <RestaurantModel>(_, index, model) {
        return GestureDetector(
          onTap: () {
            context.goNamed(RestaurantDetailScreen.routeName, params: {
              'rid': model.id,
            });
          },
          child: RestaurantCard.fromModel(model, isDetail: false),
        );
      },
    );
  }
}
