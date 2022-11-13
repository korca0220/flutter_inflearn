import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/common/const/colors.dart';
import 'package:flutter_application_1/common/layout/default_layout.dart';
import 'package:flutter_application_1/common/model/cursor_pagination_model.dart';
import 'package:flutter_application_1/common/utils/pagination_utils.dart';
import 'package:flutter_application_1/product/component/product_card.dart';
import 'package:flutter_application_1/product/model/product_model.dart';
import 'package:flutter_application_1/rating/component/rating_card.dart';
import 'package:flutter_application_1/rating/model/rating_model.dart';
import 'package:flutter_application_1/restaurant/component/restaurant_card.dart';
import 'package:flutter_application_1/restaurant/model/restaurant_detail_model.dart';
import 'package:flutter_application_1/restaurant/model/restaurant_model.dart';
import 'package:flutter_application_1/restaurant/provider/restaurant_provider.dart';
import 'package:flutter_application_1/restaurant/provider/restaurant_rating_provider.dart';
import 'package:flutter_application_1/restaurant/view/basket_screen.dart';
import 'package:flutter_application_1/user/provider/basket_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletons/skeletons.dart';

class RestaurantDetailScreen extends ConsumerStatefulWidget {
  static String get routeName => 'restaurantDetail';
  final String id;
  const RestaurantDetailScreen({
    super.key,
    required this.id,
  });

  @override
  ConsumerState<RestaurantDetailScreen> createState() =>
      _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState
    extends ConsumerState<RestaurantDetailScreen> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    ref.read(restaurantProvider.notifier).getDetail(id: widget.id);
    scrollController.addListener(scrollListener);
  }

  scrollListener() {
    PaginationUtils.paginate(
      scrollController: scrollController,
      provider: ref.read(restaurantRatingProvider(widget.id).notifier),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(restaurantDetailProvider(widget.id));
    final ratingsState = ref.watch(restaurantRatingProvider(widget.id));
    final basket = ref.watch(basketProvider);

    if (state == null) {
      return const DefaultLayout(
          child: Center(
        child: CircularProgressIndicator(),
      ));
    }
    return DefaultLayout(
      title: state.name,
      floattingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed(BasketScreen.routeName);
        },
        backgroundColor: PRIMARY_COLOR,
        child: Badge(
          showBadge: basket.isNotEmpty,
          badgeContent: Text(
            basket
                .fold<int>(0, (previous, next) => previous + next.count)
                .toString(),
            style: const TextStyle(
              color: PRIMARY_COLOR,
            ),
          ),
          badgeColor: Colors.white,
          child: const Icon(
            Icons.shopping_basket_outlined,
            size: 25,
          ),
        ),
      ),
      child: CustomScrollView(
        controller: scrollController,
        slivers: [
          renderTop(state),
          if (state is! RestaurantDetailModel) renderLoading(),
          if (state is RestaurantDetailModel) renderLabel(),
          if (state is RestaurantDetailModel)
            renderProduct(state.products, state),
          const SliverToBoxAdapter(child: SizedBox(height: 10)),
          if (ratingsState is CursorPaginationModel<RatingModel>)
            renderRatings(
              models: ratingsState.data,
            )
        ],
      ),
    );
  }

  SliverPadding renderRatings({
    required List<RatingModel> models,
  }) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          ((context, index) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: RatingCard.fromModel(model: models[index]),
              )),
          childCount: models.length,
        ),
      ),
    );
  }

  SliverPadding renderLoading() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          List.generate(
            3,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: SkeletonParagraph(
                style: const SkeletonParagraphStyle(
                  lines: 5,
                  padding: EdgeInsets.zero,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  renderTop(RestaurantModel model) {
    return SliverToBoxAdapter(
      child: RestaurantCard.fromModel(model, isDetail: true),
    );
  }

  renderLabel() {
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

  renderProduct(
      List<RestaurantProductModel> product, RestaurantModel restaurant) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final model = product[index];
            return InkWell(
              onTap: () {
                ref.read(basketProvider.notifier).addToBasket(
                      product: ProductModel(
                        id: model.id,
                        name: model.name,
                        detail: model.detail,
                        imgUrl: model.imgUrl,
                        price: model.price,
                        restaurant: restaurant,
                      ),
                    );
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: ProductCard.fromModel(model: model),
              ),
            );
          },
          childCount: product.length,
        ),
      ),
    );
  }
}
