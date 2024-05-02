import 'dart:convert';
import 'dart:io';

import 'package:pixabay/infrastructure/data/api_execution_params.dart';
import 'package:pixabay/service/server_config.dart';

class HttpExecuter {
  final HttpClient client;
  static late final ServerConfig defaultServerConfig;
  static void init(ServerConfig serverConfig) {
    defaultServerConfig = serverConfig;
  }

  HttpExecuter() : client = HttpClient();

  Future<String> finalApiExecution(HttpApiParams httpApiParams) async {
    Uri finalUrl;
    try {
      _setApiKey(httpApiParams);
      finalUrl = Uri.https(
          defaultServerConfig.server, httpApiParams.path, httpApiParams.query);

      HttpClientRequest httpClientRequest =
          await client.openUrl(httpApiParams.method!, finalUrl);

      if (httpApiParams.data != null) {
        httpClientRequest.write(httpApiParams.data);
      }

      HttpClientResponse httpClientResponse = await httpClientRequest.close();
      if (httpClientResponse.statusCode == 400 ||
          httpClientResponse.statusCode == 401) {
        throw "Something went wrong.";
      }

      final String responseString =
          await httpClientResponse.transform(utf8.decoder).join();

      return responseString;
    } catch (e) {
      throw e.toString();
    }
  }

  _setApiKey(HttpApiParams httpApiParams) {
    httpApiParams.query?.addAll({'key': "43661498-ffa56af4d2575e5d3f0232aec"});
  }
}
