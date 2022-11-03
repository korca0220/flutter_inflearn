import 'package:flutter/material.dart';
import 'package:flutter_application_1/common/const/colors.dart';
import 'package:flutter_application_1/common/model/model_with_product.dart';
import 'package:flutter_application_1/product/model/product_model.dart';
import 'package:flutter_application_1/restaurant/model/restaurant_detail_model.dart';

class ProductCard extends StatelessWidget {
  final Image image;
  final String name;
  final String detail;
  final int price;
  const ProductCard({
    super.key,
    required this.image,
    required this.name,
    required this.detail,
    required this.price,
  });

  factory ProductCard.fromModel({required IModelWithProduct model}) {
    return ProductCard(
      image: Image.network(
        model.imgUrl,
        width: 110,
        height: 110,
        fit: BoxFit.cover,
      ),
      name: model.name,
      detail: model.detail,
      price: model.price,
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        // Row 안에서의 Widget들은 각각 고유의 Height값을 갖고 있음.
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: image,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                Text(
                  detail,
                  style: TextStyle(
                    fontSize: 14,
                    color: BODY_TEXT_COLOR,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '₩$price',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 12,
                    color: PRIMARY_COLOR,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
