import 'package:flutter/material.dart';
import 'package:flutter_application_1/common/provider/pagination_provider.dart';

class PaginationUtils {
  static void paginate({
    required ScrollController scrollController,
    required PaginationProvider provider,
  }) {
    if (scrollController.offset >
        scrollController.position.maxScrollExtent - 300) {
      provider.paginate(
        fetchMore: true,
      );
    }
  }
}
