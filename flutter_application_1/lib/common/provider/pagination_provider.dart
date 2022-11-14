import 'package:flutter_application_1/common/model/cursor_pagination_model.dart';
import 'package:flutter_application_1/common/model/model_with_id.dart';
import 'package:flutter_application_1/common/model/pagination_params.dart';
import 'package:flutter_application_1/common/repository/base_pagination_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PaginationProvider<T extends IModelWithId,
        U extends IBasePaginationRepository<T>>
    extends StateNotifier<CursorPaginationBase> {
  final U repository;

  PaginationProvider({
    required this.repository,
  }) : super(CursorPaginationLoading()) {
    paginate();
  }

  Future<void> paginate({
    int fetchCount = 20,
    // 추가로 데이터 더 가져오기
    // true - 추가로 데이터 더 가져옴
    // false - 새로고침 (현재 상태를 덮어씌움)
    bool fetchMore = false,
    // 강제로 다시 로딩하기
    // true - CursorPaginationLoading()
    bool forceRefetch = false,
  }) async {
    try {
      // 5가지 가능성
      // State의 상태
      // State
      // 1) CursorPagination - 정상적으로 데이터가 있는 상태
      // 2) CursorPaginationLoading - 데이터가 로딩중인 상태 (현재 캐시 없음)
      // 3) CursorPaginationError - 에러
      // 4) CursorPaginationRefetching - 첫번째 페이지부터 다시 데이터를 가져오기
      // 5) CursorPaginationFetchMore - 추가 데이터를 해오라는 요청(paginate)

      // 바로 반환하는 상황
      // 1) haseMore == false 일떄 (기존 상태에서 이미 다음 데이터가 없다는 값)
      // 2) 로딩중 - fetchMore == true 일떄
      //             fetchMore == false 새로고침의 의도가 있을 수 있다.

      /// 1) [CursorPaginationModel] 일경우 반드시 [meta], [data]를 갖고있음.
      if (state is CursorPaginationModel && !forceRefetch) {
        final pState = state as CursorPaginationModel;
        if (!pState.meta.hasMore) {
          return;
        }
      }

      final isLoading = state is CursorPaginationLoading;
      final isRefetching = state is CursorPaginationRefetching;
      final isFetchingMore = state is CursorPaginationFetchingMore;

      // 2)번 상황
      if (fetchMore && (isLoading || isRefetching || isFetchingMore)) {
        return;
      }

      // PaginationParams 생성 (2번째 요청 부터)
      PaginationParams paginationParams = PaginationParams(
        count: fetchCount,
      );

      // fetchMore
      // 데이터를 추가로 더 가져오는 상황 (1개 이상 데이터를 들고 있는 상황)
      if (fetchMore) {
        final pState = state as CursorPaginationModel<T>;

        state = CursorPaginationFetchingMore(
          meta: pState.meta,
          data: pState.data,
        );

        paginationParams = const PaginationParams().copyWith(
          after: pState.data.last.id,
        );
      }
      // 데이터를 처음부터 가져오는 상황
      else {
        // 만약 데이터가 있는 상황이면
        // 기존 데이터를 보존한채로 Fetch (API 요청)를 진행
        if (state is CursorPaginationModel && !forceRefetch) {
          final pState = state as CursorPaginationModel<T>;
          state = CursorPaginationRefetching<T>(
            data: pState.data,
            meta: pState.meta,
          );
        }
        // 나머지 상황(데이터 유지가 필요 없는 상황)
        else {
          state = CursorPaginationLoading();
        }
      }

      // 공통적으로 사용하게 됨
      final resp = await repository.paginate(
        paginationParams: paginationParams,
      );

      if (state is CursorPaginationFetchingMore) {
        final pState = state as CursorPaginationFetchingMore<T>;

        // 기존 데이터에 새로운 데이터 추가
        state = resp.copyWith(
          data: [
            ...pState.data,
            ...resp.data,
          ],
        );
      } else {
        state = resp;
      }
    } catch (e, trace) {
      print(trace);
      state = CursorPaginationError(message: '데이터를 가져오지 못했습니다.');
    }
  }
}
