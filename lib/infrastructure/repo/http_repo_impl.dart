import 'package:pixabay/infrastructure/data/api_execution_params.dart';
import 'package:pixabay/infrastructure/repo/http_repo.dart';
import 'package:pixabay/service/http_execute_api.dart';

class HttpRepoImpl implements HttpRepository {
  HttpExecuter httpExecuter = HttpExecuter();

  @override
  Future<dynamic> fetchApiData(
      {required String path,
      String? method = "GET",
      String? data,
      Map<String, String>? query}) {
    HttpApiParams httpApiParams =
        HttpApiParams(path: path, method: method, data: data, query: query);
    try {
      final response = httpExecuter.finalApiExecution(httpApiParams);
      return response;
    } catch (e) {
      throw "Something went wrong.";
    }
  }
}
