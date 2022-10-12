import 'package:flutter_application_1/common/const/data.dart';
import 'package:flutter_application_1/restaurant/model/restaurant_model.dart';

class RestaurantDetailModel extends RestaurantModel {
  final String detail;
  final List<RestaurantProductModel> products;
  RestaurantDetailModel({
    required super.id,
    required super.name,
    required super.thumbUrl,
    required super.tags,
    required super.priceRange,
    required super.ratings,
    required super.ratingsCount,
    required super.deliveryTime,
    required super.deliveryFee,
    required this.detail,
    required this.products,
  });

  factory RestaurantDetailModel.fromMap(Map<String, dynamic> map) {
    return RestaurantDetailModel(
      id: map['id'],
      name: map['name'],
      thumbUrl: 'http://$ip${map['thumbUrl']}',
      tags: List<String>.from(map['tags']),
      priceRange: RestaurantPriceRange.values
          .firstWhere((element) => element.name == map['priceRange']),
      ratings: map['ratings'],
      ratingsCount: map['ratingsCount'],
      deliveryTime: map['deliveryTime'],
      deliveryFee: map['deliveryFee'],
      detail: map['detail'],
      products: map['products']
          .map<RestaurantProductModel>(
            (x) => RestaurantProductModel.fromMap(map: x),
          )
          .toList(),
    );
  }
}

class RestaurantProductModel {
  final String id;
  final String name;
  final String imgUrl;
  final String detail;
  final int price;
  RestaurantProductModel({
    required this.id,
    required this.name,
    required this.imgUrl,
    required this.detail,
    required this.price,
  });

  factory RestaurantProductModel.fromMap({required Map<String, dynamic> map}) {
    return RestaurantProductModel(
      id: map['id'],
      name: map['name'],
      imgUrl: 'http://$ip${map['imgUrl']}',
      detail: map['detail'],
      price: map['price'],
    );
  }
}
