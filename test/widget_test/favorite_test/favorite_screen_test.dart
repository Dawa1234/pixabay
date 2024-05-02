import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pixabay/service/http_execute_api.dart';
import 'package:pixabay/service/server_config.dart';
import 'package:pixabay/src/bloc/favorite_cubit/favorite_cubit.dart';
import 'package:pixabay/src/pages/favorite_screen/favorite_screen.dart';

class MockFavoriteCubit extends MockCubit<FavoriteState>
    implements FavoriteCubit {}

void main() {
  late MockFavoriteCubit mockFavoriteCubit;

  setUp(() {
    mockFavoriteCubit = MockFavoriteCubit();
    HttpExecuter.init(LiveServerConfig());
  });

  Widget testableWidget(Widget body) {
    return BlocProvider<FavoriteCubit>(
      create: (context) => mockFavoriteCubit,
      child: MaterialApp(home: body),
    );
  }

  testWidgets(
      "textfield should trigger state to change from empty to loading state",
      (widgetTester) async {
    await widgetTester.pumpWidget(testableWidget(const FavoriteScreen()));

    Finder text = find.byType(Text);
    expect(text, findsOneWidget);
  });
}
