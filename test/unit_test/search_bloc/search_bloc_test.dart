import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pixabay/service/http_execute_api.dart';
import 'package:pixabay/service/server_config.dart';
import 'package:pixabay/src/bloc/search_bloc/search_bloc.dart';

void main() {
  final SearchBloc searchBloc = SearchBloc();

  test("Test Search Bloc", () {
    expect(searchBloc.state, SearchInitial());
  });

  blocTest<SearchBloc, SearchState>(
    'emits [SearchLoading() , SearchLoaded()] when SearchItems is added.',
    build: () => searchBloc,
    act: (searchBloc) {
      HttpExecuter.init(LiveServerConfig());
      searchBloc.add(const SearchItems(query: "", page: "1"));
    },
    wait: const Duration(seconds: 5),
    expect: () =>
        <SearchState>[SearchLoading(), const SearchLoaded(imageData: [])],
  );
}
