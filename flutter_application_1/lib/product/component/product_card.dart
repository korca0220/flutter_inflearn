import 'package:flutter/material.dart';
import 'package:flutter_application_1/common/const/colors.dart';
import 'package:flutter_application_1/common/model/model_with_product.dart';
import 'package:flutter_application_1/user/provider/basket_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductCard extends ConsumerWidget {
  final Image image;
  final String name;
  final String detail;
  final int price;
  final String id;
  final VoidCallback? onSubstract;
  final VoidCallback? onAdd;
  const ProductCard({
    super.key,
    required this.id,
    required this.image,
    required this.name,
    required this.detail,
    required this.price,
    this.onSubstract,
    this.onAdd,
  });

  factory ProductCard.fromModel({
    required IModelWithProduct model,
    VoidCallback? onSubstract,
    VoidCallback? onAdd,
  }) {
    return ProductCard(
      image: Image.network(
        model.imgUrl,
        width: 110,
        height: 110,
        fit: BoxFit.cover,
      ),
      name: model.name,
      id: model.id,
      detail: model.detail,
      price: model.price,
      onSubstract: onSubstract,
      onAdd: onAdd,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final basket = ref.watch(basketProvider);
    return Column(
      children: [
        IntrinsicHeight(
          child: Row(
            // Row 안에서의 Widget들은 각각 고유의 Height값을 갖고 있음.
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: image,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      detail,
                      style: const TextStyle(
                        fontSize: 14,
                        color: BODY_TEXT_COLOR,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '₩$price',
                      textAlign: TextAlign.right,
                      style: const TextStyle(
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
        ),
        if (onSubstract != null && onAdd != null)
          _Footer(
            total: (basket.firstWhere((e) => e.product.id == id).count *
                    basket.firstWhere((e) => e.product.id == id).product.price)
                .toString(),
            count: basket.firstWhere((e) => e.product.id == id).count,
            onSubstract: onSubstract!,
            onAdd: onAdd!,
          ),
      ],
    );
  }
}

class _Footer extends StatelessWidget {
  final String total;
  final int count;
  final VoidCallback onSubstract;
  final VoidCallback onAdd;
  const _Footer({
    required this.total,
    required this.count,
    required this.onSubstract,
    required this.onAdd,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            '총액 ￦$total',
            style: const TextStyle(
              color: PRIMARY_COLOR,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Row(
          children: [
            renderButton(icon: Icons.remove, onTap: onSubstract),
            Text(
              count.toString(),
              style: const TextStyle(
                color: PRIMARY_COLOR,
                fontWeight: FontWeight.w500,
              ),
            ),
            renderButton(icon: Icons.add, onTap: onAdd),
          ],
        )
      ],
    );
  }

  Widget renderButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: PRIMARY_COLOR,
            width: 1.0,
          )),
      child: InkWell(
        onTap: onTap,
        child: Icon(
          icon,
          color: PRIMARY_COLOR,
        ),
      ),
    );
  }
}
