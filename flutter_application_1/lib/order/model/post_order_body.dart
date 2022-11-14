import 'package:flutter_application_1/user/model/basket_item_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_order_body.g.dart';

@JsonSerializable()
class PostOrderBody {
  final String id;
  final List<BasketItemModel> products;
  final int totlaPrice;
  final String createdAt;

  PostOrderBody({
    required this.id,
    required this.products,
    required this.totlaPrice,
    required this.createdAt,
  });

  factory PostOrderBody.fromJson(Map<String, dynamic> json) =>
      _$PostOrderBodyFromJson(json);

  Map<String, dynamic> toJson() => _$PostOrderBodyToJson(this);
}
