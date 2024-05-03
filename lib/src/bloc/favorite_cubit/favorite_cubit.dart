import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:pixabay/helper/shared_pref.dart';
import 'package:pixabay/src/data/models/image_model.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteImageLoading([]));

  init() {
    final String presistedFavImage = SharedPref.getFavImages();
    if (presistedFavImage.isNotEmpty) {
      final ImageData images =
          ImageData.fromJson(jsonDecode(presistedFavImage));
      emit(FavoriteImageUpdated(images.imageData));
    }
  }

  addToFav(ImageDatum imageDatum) {
    List<ImageDatum> images = state.favoriteImages;
    images.add(imageDatum);
    emit(FavoriteImageUpdated(images));
    _presistFavImages(images);
  }

  removeFromFav(ImageDatum imageDatum) {
    final List<ImageDatum> images = state.favoriteImages;
    images.remove(imageDatum);
    emit(FavoriteImageUpdated(images));
    _presistFavImages(images);
  }

  _presistFavImages(List<ImageDatum> images) =>
      SharedPref.setFavImages(jsonEncode(
          {'hits': images.map((imageDatum) => imageDatum.toJson()).toList()}));
}
