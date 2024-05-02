import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pixabay/src/data/models/image_model.dart';
import 'package:pixabay/src/data/repo/search_repo.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchApiRepository _searchRepository = SearchApiRepository();
  SearchBloc() : super(SearchInitial()) {
    on<SearchItems>(_searchItems);
  }
  _searchItems(SearchItems event, emit) async {
    if ((state is! SearchLoaded) || event.isRefresh!) emit(SearchLoading());
    try {
      final data = await _searchRepository.searchItem(
          query: event.query, page: event.page);

      if (state is SearchLoaded) {
        final newImageData = (state as SearchLoaded).imageData
          ..addAll(data.imageData);
        emit(SearchLoaded(imageData: newImageData));
        return;
      }
      emit(SearchLoaded(imageData: data.imageData));
    } on String catch (e) {
      emit(SearchLoadError(e.toString()));
    } catch (e) {
      emit(const SearchLoadError("Something went wrong"));
    }
  }
}
