part of 'favorite_cubit.dart';

class FavoriteState {
  List<ImageDatum> favoriteImages;
  FavoriteState(this.favoriteImages);
}

class FavoriteImageLoading extends FavoriteState {
  FavoriteImageLoading(super.favoriteImages);
}

class FavoriteImageUpdated extends FavoriteState {
  List<ImageDatum> favImages;
  FavoriteImageUpdated(this.favImages) : super(favImages);
}
