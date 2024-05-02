part of 'search_bloc.dart';

class SearchEvent {
  const SearchEvent();
}

class SearchItems extends SearchEvent {
  final bool? isRefresh;
  final String query;
  final String page;
  const SearchItems(
      {this.isRefresh = false, required this.query, required this.page});
}
