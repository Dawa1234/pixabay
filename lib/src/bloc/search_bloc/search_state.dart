part of 'search_bloc.dart';

class SearchState {
  const SearchState();
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<ImageDatum> imageData;
  const SearchLoaded({required this.imageData});
}

class SearchLoadError extends SearchState {
  final String errorMessage;
  const SearchLoadError(this.errorMessage);
}
