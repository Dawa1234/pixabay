abstract class ServerConfig {
  String server = "";

  String scheme = "https";
}

class LiveServerConfig implements ServerConfig {
  @override
  String server = "pixabay.com";

  @override
  String scheme = "https";
}
