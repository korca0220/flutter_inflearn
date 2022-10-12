import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/common/const/data.dart';
import 'package:flutter_application_1/common/layout/default_layout.dart';
import 'package:flutter_application_1/product/component/product_card.dart';
import 'package:flutter_application_1/restaurant/component/restaurant_card.dart';
import 'package:flutter_application_1/restaurant/model/restaurant_detail_model.dart';

class RestaurantDetailScreen extends StatelessWidget {
  final String id;
  const RestaurantDetailScreen({
    super.key,
    required this.id,
  });

  Future getRestaurantDetail() async {
    final dio = Dio();
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    final resp = await dio.get(
      'http://$ip/restaurant/$id',
      options: Options(
        headers: {'authorization': 'Bearer $accessToken'},
      ),
    );
    return resp.data;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '불타는 떡볶이',
      child: FutureBuilder(
          future: getRestaurantDetail(),
          builder: (context, snapshot) {
            print(snapshot.data);
            if (!snapshot.hasData) {
              return Container();
            }
            final item = RestaurantDetailModel.fromMap(snapshot.data!);
            print(item);
            return CustomScrollView(
              slivers: [
                renderTop(item),
                renderLable(),
                renderProduct(),
              ],
            );
          }),
    );
  }

  renderTop(RestaurantDetailModel model) {
    return SliverToBoxAdapter(
      child: RestaurantCard.fromMOdel(model, isDetail: true),
    );
  }

  renderProduct() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Padding(
              padding: const EdgeInsets.only(top: 16),
              child: ProductCard(),
            );
          },
          childCount: 10,
        ),
      ),
    );
  }

  renderLable() {
    return const SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverToBoxAdapter(
        child: Text(
          '메뉴',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
