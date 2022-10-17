import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/common/const/data.dart';
import 'package:flutter_application_1/common/dio/dio.dart';
import 'package:flutter_application_1/common/layout/default_layout.dart';
import 'package:flutter_application_1/product/component/product_card.dart';
import 'package:flutter_application_1/restaurant/component/restaurant_card.dart';
import 'package:flutter_application_1/restaurant/model/restaurant_detail_model.dart';
import 'package:flutter_application_1/restaurant/repository/restaurant_repository.dart';

class RestaurantDetailScreen extends StatelessWidget {
  final String id;
  const RestaurantDetailScreen({
    super.key,
    required this.id,
  });

  Future<RestaurantDetailModel> getRestaurantDetail() async {
    final dio = Dio();

    dio.interceptors.add(
      CustomInterceptor(storage: storage),
    );
    final resp =
        await RestaurantRepository(dio, baseUrl: 'http://$ip/restaurant')
            .getRestaurantDetail(id: id);

    return resp;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '불타는 떡볶이',
      child: FutureBuilder<RestaurantDetailModel>(
          future: getRestaurantDetail(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            return CustomScrollView(
              slivers: [
                renderTop(snapshot.data!),
                renderLable(),
                renderProduct(
                  snapshot.data!.products,
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 10))
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

  renderProduct(List<RestaurantProductModel> product) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final model = product[index];
            return Padding(
              padding: const EdgeInsets.only(top: 16),
              child: ProductCard.fromModel(model: model),
            );
          },
          childCount: product.length,
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
