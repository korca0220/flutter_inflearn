import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_application_1/restaurant/model/restaurant_detail_model.dart';
import 'package:retrofit/retrofit.dart';
part 'restaurant_repository.g.dart';

@RestApi()
abstract class RestaurantRepository {
  // base : http://$ip/restaurant
  factory RestaurantRepository(Dio dio, {String baseUrl}) =
      _RestaurantRepository;

  // http://$ip/restaurant
  // @GET('/')
  // paginate();

  // http://$ip/restaurant/:id
  @GET('/{id}')
  @Headers({
    'authorization':
        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InRlc3RAY29kZWZhY3RvcnkuYWkiLCJzdWIiOiJmNTViMzJkMi00ZDY4LTRjMWUtYTNjYS1kYTlkN2QwZDkyZTUiLCJ0eXBlIjoiYWNjZXNzIiwiaWF0IjoxNjY1OTM2MjY4LCJleHAiOjE2NjU5MzY1Njh9.QoPLw5HX73VlhkFpd_hq0MmTE-3HLOMVAAUm3MHxsq8',
  })
  Future<RestaurantDetailModel> getRestaurantDetail({
    @Path() required String id,
  });
}
