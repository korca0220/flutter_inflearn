import 'package:flutter/material.dart';
import 'package:flutter_application_1/common/model/cursor_pagination_model.dart';
import 'package:flutter_application_1/common/model/model_with_id.dart';
import 'package:flutter_application_1/common/provider/pagination_provider.dart';
import 'package:flutter_application_1/common/utils/pagination_utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef PaginationWidgetBuilder<T extends IModelWithId> = Widget Function(
  BuildContext context,
  int index,
  T model,
);

class PaginationListView<T extends IModelWithId>
    extends ConsumerStatefulWidget {
  final StateNotifierProvider<PaginationProvider, CursorPaginationBase>
      provider;
  final PaginationWidgetBuilder<T> itemBuilder;
  const PaginationListView({
    required this.provider,
    required this.itemBuilder,
    super.key,
  });

  @override
  ConsumerState<PaginationListView> createState() =>
      _PaginationListViewState<T>();
}

class _PaginationListViewState<T extends IModelWithId>
    extends ConsumerState<PaginationListView> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(listener);
  }

  void listener() {
    PaginationUtils.paginate(
      scrollController: scrollController,
      provider: ref.read(widget.provider.notifier),
    );
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.removeListener(listener);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(widget.provider);

    if (state is CursorPaginationLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    // 에러
    if (state is CursorPaginationError) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            state.message,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 16.0,
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(widget.provider.notifier).paginate(forceRefetch: true);
            },
            child: const Text('다시 시도'),
          ),
        ],
      );
    }

    // CursorPaginationModel
    // CursorPaginationFetchingMore
    // CursorPaginationRefetching
    final cp = state as CursorPaginationModel<T>;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: RefreshIndicator(
        onRefresh: () async {
          ref.read(widget.provider.notifier).paginate(
                forceRefetch: true,
              );
        },
        child: ListView.separated(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          controller: scrollController,
          itemCount: cp.data.length + 1,
          itemBuilder: (_, index) {
            if (index == cp.data.length) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Center(
                  child: cp is CursorPaginationFetchingMore
                      ? const CircularProgressIndicator()
                      : const Text('마지막 데이터 입니다'),
                ),
              );
            }
            final pItem = cp.data[index];
            return widget.itemBuilder(context, index, pItem);
          },
          separatorBuilder: (_, index) => const SizedBox(height: 16),
        ),
      ),
    );
  }
}
