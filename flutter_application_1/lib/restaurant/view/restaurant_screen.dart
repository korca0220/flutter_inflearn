import 'package:flutter/material.dart';
import 'package:flutter_application_1/restaurant/component/restaurant_card.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            RestaurantCard(
              image: Image.asset(
                'asset/img/food/ddeok_bok_gi.jpg',
                fit: BoxFit.cover,
              ),
              name: '불타는 떡볶이',
              tags: const ['떡복이', '치즈', '매운맛'],
              ratingCount: 100,
              deliveryTime: 15,
              deliveryFee: 2000,
              rating: 4.52,
            )
          ],
        ));
  }
}
