import 'package:flutter_application_1/common/model/cursor_pagination_model.dart';
import 'package:flutter_application_1/common/model/pagination_params.dart';

abstract class IBasePaginationRepository<T> {
  Future<CursorPaginationModel<T>> paginate({
    PaginationParams? paginationParams = const PaginationParams(),
  });
}
