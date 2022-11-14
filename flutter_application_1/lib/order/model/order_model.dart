import 'package:flutter_application_1/common/model/model_with_id.dart';
import 'package:flutter_application_1/common/model/model_with_product.dart';
import 'package:flutter_application_1/common/utils/data_utils.dart';
import 'package:flutter_application_1/restaurant/model/restaurant_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_model.g.dart';

@JsonSerializable()
class OrderProductModel implements IModelWithProduct {
  @override
  final String id;
  @override
  final String name;
  @override
  final String detail;
  @JsonKey(
    fromJson: DataUtils.pathToUrl,
  )
  @override
  final String imgUrl;
  @override
  final int price;

  OrderProductModel({
    required this.id,
    required this.name,
    required this.detail,
    required this.imgUrl,
    required this.price,
  });

  factory OrderProductModel.fromJson(Map<String, dynamic> json) =>
      _$OrderProductModelFromJson(json);
}

@JsonSerializable()
class OrderProductAndCountModel {
  final OrderProductModel product;
  final int count;

  OrderProductAndCountModel({
    required this.product,
    required this.count,
  });

  factory OrderProductAndCountModel.fromJson(Map<String, dynamic> json) =>
      _$OrderProductAndCountModelFromJson(json);
}

@JsonSerializable()
class OrderModel implements IModelWithId {
  @override
  final String id;
  final List<OrderProductAndCountModel> products;
  final int totalPrice;
  final RestaurantModel restaurant;
  @JsonKey(
    fromJson: DataUtils.stringToDateTime,
  )
  final DateTime createdAt;

  OrderModel({
    required this.id,
    required this.products,
    required this.totalPrice,
    required this.restaurant,
    required this.createdAt,
  });
  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);
}
