import 'package:flutter_application_1/common/const/data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'restaurant_model.g.dart';

enum RestaurantPriceRange {
  expensive,
  medium,
  cheap,
}

@JsonSerializable()
class RestaurantModel {
  final String id;
  final String name;
  @JsonKey(fromJson: pathToUrl)
  final String thumbUrl;
  final List<String> tags;
  final RestaurantPriceRange priceRange;
  final double ratings;
  final int ratingsCount;
  final int deliveryTime;
  final int deliveryFee;

  RestaurantModel({
    required this.id,
    required this.name,
    required this.thumbUrl,
    required this.tags,
    required this.priceRange,
    required this.ratings,
    required this.ratingsCount,
    required this.deliveryTime,
    required this.deliveryFee,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantModelFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantModelToJson(this);

  static pathToUrl(String value) {
    return 'http://$ip$value';
  }

  // factory RestaurantModel.fromMap(Map<String, dynamic> item) {
  //   return RestaurantModel(
  //     id: item['id'],
  //     name: item['name'],
  //     thumbUrl: 'http://$ip${item['thumbUrl']}',
  //     tags: List<String>.from(item['tags']),
  //     priceRange: RestaurantPriceRange.values
  //         .firstWhere((element) => element.name == item['priceRange']),
  //     ratings: item['ratings'],
  //     ratingsCount: item['ratingsCount'],
  //     deliveryTime: item['deliveryTime'],
  //     deliveryFee: item['deliveryFee'],
  //   );
  // }
}
