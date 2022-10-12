import 'package:flutter/material.dart';
import 'package:flutter_application_1/common/const/colors.dart';
import 'package:flutter_application_1/restaurant/model/restaurant_model.dart';

class RestaurantCard extends StatelessWidget {
  // 이미지
  final Widget image;
  // 레스토랑 이름
  final String name;
  // 레스토랑 태그
  final List<String> tags;
  // 평점 갯수
  final int ratingsCount;
  // 배송걸리는 시간
  final int deliveryTime;
  // 배송 비용
  final int deliveryFee;
  // 평균 평점
  final double ratings;
  const RestaurantCard({
    super.key,
    required this.image,
    required this.name,
    required this.tags,
    required this.ratingsCount,
    required this.deliveryTime,
    required this.deliveryFee,
    required this.ratings,
  });

  factory RestaurantCard.fromMOdel(RestaurantModel model) {
    return RestaurantCard(
      image: Image.network(
        model.thumbUrl,
        fit: BoxFit.cover,
      ),
      name: model.name,
      tags: model.tags,
      ratingsCount: model.ratingsCount,
      deliveryTime: model.deliverytime,
      deliveryFee: model.deliveryFee,
      ratings: model.ratings,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: image,
        ),
        const SizedBox(height: 10),
        Text(
          name,
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          tags.join('·'),
          style: const TextStyle(
            color: BODY_TEXT_COLOR,
            fontSize: 14,
          ),
        ),
        Row(
          children: [
            IconText(icon: Icons.star, label: ratings.toString()),
            renderDot(),
            IconText(icon: Icons.receipt, label: ratingsCount.toString()),
            renderDot(),
            IconText(
              icon: Icons.timelapse_outlined,
              label: '${deliveryTime.toString()}분',
            ),
            renderDot(),
            IconText(
              icon: Icons.monetization_on,
              label: deliveryFee == 0 ? '무료' : deliveryFee.toString(),
            ),
          ],
        )
      ],
    );
  }

  renderDot() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        '·',
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
      ),
    );
  }
}

class IconText extends StatelessWidget {
  final IconData icon;
  final String label;
  const IconText({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Icon(
        icon,
        color: PRIMARY_COLOR,
        size: 14,
      ),
      const SizedBox(width: 8),
      Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    ]);
  }
}
