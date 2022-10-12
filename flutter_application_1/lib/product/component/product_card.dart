import 'package:flutter/material.dart';
import 'package:flutter_application_1/common/const/colors.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        // Row 안에서의 Widget들은 각각 고유의 Height값을 갖고 있음.
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'asset/img/food/ddeok_bok_gi.jpg',
              width: 110,
              height: 110,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  '떡볶이',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                Text(
                  '전통떡볶이의 정석!\n맛있습니다.',
                  style: TextStyle(
                    fontSize: 14,
                    color: BODY_TEXT_COLOR,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '₩10,000',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 12,
                    color: PRIMARY_COLOR,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
