part of 'favorite_cubit.dart';

class FavoriteState {
  final List<ImageDatum> favoriteImages;
  const FavoriteState(this.favoriteImages);
}

class FavoriteImageLoading extends FavoriteState {
  FavoriteImageLoading(super.favoriteImages);
}

class FavoriteImageUpdated extends FavoriteState {
  final List<ImageDatum> favImages;
  FavoriteImageUpdated(this.favImages) : super(favImages);
}