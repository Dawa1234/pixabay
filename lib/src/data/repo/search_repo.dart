import 'dart:convert';

import 'package:pixabay/infrastructure/endpoints.dart';
import 'package:pixabay/infrastructure/repo/http_repo_impl.dart';
import 'package:pixabay/src/data/models/image_model.dart';

class SearchApiRepository {
  final HttpRepoImpl _httpExecuter = HttpRepoImpl();

  Future<ImageData> searchItem(
      {required String query, required String page}) async {
    try {
      final response = await _httpExecuter.fetchApiData(
          path: UrlConst.searchImage,
          query: {"q": query, "per_page": "20", "page": page});
      final responseBody = jsonDecode(response);
      final ImageData imageData = ImageData.fromJson(responseBody);
      return imageData;
    } catch (e) {
      throw e.toString();
    }
  }
}
