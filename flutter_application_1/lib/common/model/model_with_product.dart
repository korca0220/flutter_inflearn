import 'package:flutter_application_1/common/model/model_with_id.dart';

abstract class IModelWithProduct implements IModelWithId {
  @override
  final String id;
  final String name;
  final String imgUrl;
  final String detail;
  final int price;

  IModelWithProduct({
    required this.id,
    required this.name,
    required this.imgUrl,
    required this.detail,
    required this.price,
  });
}
