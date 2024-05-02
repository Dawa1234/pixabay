abstract class HttpRepository {
  Future<dynamic> fetchApiData(
      {required String path,
      String? method = "GET",
      String? data,
      Map<String, String>? query});
}
