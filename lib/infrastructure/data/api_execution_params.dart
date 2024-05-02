class HttpApiParams {
  final String path;
  final String? method;
  final String? data;
  final Map<String, String>? query;

  HttpApiParams({String? method, required this.path, this.data, this.query})
      : method = method ?? "GET";
}
