import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pixabay/service/http_execute_api.dart';
import 'package:pixabay/service/server_config.dart';
import 'package:pixabay/src/bloc/favorite_cubit/favorite_cubit.dart';
import 'package:pixabay/src/bloc/search_bloc/search_bloc.dart';
import 'package:pixabay/src/pages/search_screen/search_screen.dart';

class MockSearchBloc extends MockBloc<SearchEvent, SearchState>
    implements SearchBloc {}

class MockFavoriteCubit extends MockCubit<FavoriteState>
    implements FavoriteCubit {}

void main() {
  late MockSearchBloc mockSearchBloc;
  late MockFavoriteCubit mockFavoriteCubit;

  setUp(() {
    mockSearchBloc = MockSearchBloc();
    mockFavoriteCubit = MockFavoriteCubit();
    HttpExecuter.init(LiveServerConfig());
  });

  Widget testableWidget(Widget body) {
    return MultiBlocProvider(providers: [
      BlocProvider<SearchBloc>(create: (context) => mockSearchBloc),
      BlocProvider<FavoriteCubit>(create: (context) => mockFavoriteCubit)
    ], child: MaterialApp(home: body));
  }

  testWidgets(
      "textfield should trigger state to change from empty to loading state",
      (widgetTester) async {
    await widgetTester.pumpWidget(testableWidget(const SearchScreen()));

    Finder textFormField = find.byType(TextFormField);
    expect(textFormField, findsOneWidget);
  });
}
