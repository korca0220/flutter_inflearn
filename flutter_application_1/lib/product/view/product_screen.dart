import 'package:flutter/material.dart';
import 'package:flutter_application_1/common/component/pagination_list_view.dart';
import 'package:flutter_application_1/product/component/product_card.dart';
import 'package:flutter_application_1/product/model/product_model.dart';
import 'package:flutter_application_1/product/provider/product_provider.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PaginationListView<ProductModel>(
      provider: productProvider,
      itemBuilder: <ProductModel>(context, index, model) {
        return ProductCard.fromModel(model: model);
      },
    );
  }
}
