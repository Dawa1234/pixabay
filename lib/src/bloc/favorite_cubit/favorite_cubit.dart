import 'package:bloc/bloc.dart';
import 'package:pixabay/src/data/models/image_model.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteImageLoading([]));

  addToFav(ImageDatum imageDatum) {
    final List<ImageDatum> images =
        (state as FavoriteImageUpdated).favoriteImages;
    images.add(imageDatum);
    emit(FavoriteImageUpdated(images));
  }

  removeFromFav(int id) {
    final List<ImageDatum> images =
        (state as FavoriteImageUpdated).favoriteImages;
    images.removeWhere((imageDatum) => imageDatum.id == id);
    emit(FavoriteImageUpdated(images));
  }
}
