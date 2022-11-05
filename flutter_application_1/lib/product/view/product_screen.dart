import 'package:flutter/material.dart';
import 'package:flutter_application_1/common/component/pagination_list_view.dart';
import 'package:flutter_application_1/product/component/product_card.dart';
import 'package:flutter_application_1/product/model/product_model.dart';
import 'package:flutter_application_1/product/provider/product_provider.dart';
import 'package:flutter_application_1/restaurant/view/restaurant_detail_screen.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PaginationListView<ProductModel>(
      provider: productProvider,
      itemBuilder: <ProductModel>(context, index, model) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => RestaurantDetailScreen(
                  id: model.restaurant.id,
                ),
              ),
            );
          },
          child: ProductCard.fromModel(model: model),
        );
      },
    );
  }
}
