import 'package:flutter/material.dart';
import 'package:flutter_application_1/common/utils/pagination_utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PaginationListView extends ConsumerStatefulWidget {
  const PaginationListView({super.key});

  @override
  ConsumerState<PaginationListView> createState() => _PaginationListViewState();
}

class _PaginationListViewState extends ConsumerState<PaginationListView> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {    
    super.initState();
    scrollController.addListener(listener);
  }

  void listener() {
    PaginationUtils.paginate(
      scrollController: scrollController,
      provider: provider,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
