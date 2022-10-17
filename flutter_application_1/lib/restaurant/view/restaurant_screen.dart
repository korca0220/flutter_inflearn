import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/common/const/data.dart';
import 'package:flutter_application_1/common/dio/dio.dart';
import 'package:flutter_application_1/common/model/cursor_pagination_model.dart';
import 'package:flutter_application_1/restaurant/component/restaurant_card.dart';
import 'package:flutter_application_1/restaurant/model/restaurant_model.dart';
import 'package:flutter_application_1/restaurant/repository/restaurant_repository.dart';
import 'package:flutter_application_1/restaurant/view/restaurant_detail_screen.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});

  Future<List<RestaurantModel>> paginateRestaurant() async {
    final dio = Dio();

    dio.interceptors.add(CustomInterceptor(storage: storage));

    final resp =
        await RestaurantRepository(dio, baseUrl: 'http://$ip/restaurant')
            .paginate();
    return resp.data;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Center(
        child: FutureBuilder<List<RestaurantModel>>(
          future: paginateRestaurant(),
          builder: (context, AsyncSnapshot<List<RestaurantModel>> snapshot) {
            if (!snapshot.hasData) {
              return Container();
            }
            return ListView.separated(
              itemCount: snapshot.data!.length,
              itemBuilder: (_, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => RestaurantDetailScreen(
                            id: snapshot.data![index].id),
                      ),
                    );
                  },
                  child: RestaurantCard.fromMOdel(snapshot.data![index],
                      isDetail: false),
                );
              },
              separatorBuilder: (_, index) => const SizedBox(height: 16),
            );
          },
        ),
      ),
    );
  }
}
