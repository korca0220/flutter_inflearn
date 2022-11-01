import 'package:flutter_application_1/common/model/cursor_pagination_model.dart';
import 'package:flutter_application_1/common/provider/pagination_provider.dart';
import 'package:flutter_application_1/rating/model/rating_model.dart';
import 'package:flutter_application_1/restaurant/repository/restaurant_rating_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final restaurantRatingProvider = StateNotifierProvider.family<
    RestaurantRatingProviderStateNotifier,
    CursorPaginationBase,
    String>((ref, id) {
  final repository = ref.watch(restaurantRatingRepositoryProvider(id));
  return RestaurantRatingProviderStateNotifier(repository: repository);
});

class RestaurantRatingProviderStateNotifier
    extends PaginationProvider<RatingModel, RestaurantRatingRepository> {
  RestaurantRatingProviderStateNotifier({
    required super.repository,
  });
}
