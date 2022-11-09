import 'package:flutter_application_1/common/model/model_with_id.dart';
import 'package:flutter_application_1/common/model/model_with_product.dart';
import 'package:flutter_application_1/common/utils/data_utils.dart';
import 'package:flutter_application_1/restaurant/model/restaurant_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel implements IModelWithProduct {
  @override
  final String id;
  @override
  final String name;
  @override
  final String detail;
  @override
  @JsonKey(
    fromJson: DataUtils.pathToUrl,
  )
  final String imgUrl;
  @override
  final int price;
  final RestaurantModel restaurant;

  ProductModel({
    required this.id,
    required this.name,
    required this.detail,
    required this.imgUrl,
    required this.price,
    required this.restaurant,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);
}
