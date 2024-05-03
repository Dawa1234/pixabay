import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pixabay/src/bloc/favorite_cubit/favorite_cubit.dart';
import 'package:pixabay/src/data/models/image_model.dart';

void main() {
  final FavoriteCubit favoriteCubit = FavoriteCubit();

  test("Test Favorite Bloc", () {
    expect(favoriteCubit.state, FavoriteImageLoading([]));
  });

  blocTest<FavoriteCubit, FavoriteState>(
    'emits [const FavoriteImageUpdated([])] when addToFav() is called.',
    build: () => favoriteCubit,
    act: (searchBloc) {
      ImageDatum dummyImageDatum =
          const ImageDatum(id: 1, image: "", ownerName: "", imageSize: 1);
      favoriteCubit.addToFav(dummyImageDatum);
    },
    wait: const Duration(milliseconds: 500),
    expect: () => <FavoriteState>[FavoriteImageUpdated([])],
  );
}
