class ImageData {
  final List<ImageDatum> imageData;
  const ImageData({required this.imageData});

  factory ImageData.fromJson(Map<String, dynamic> json) => ImageData(
      imageData: (json['hits'] as List)
          .map((json) => ImageDatum.fromJson(json))
          .toList());
}

class ImageDatum {
  final int id;
  final String image;
  final int imageHeight;
  final int imageWidth;
  final String ownerName;
  final int imageSize;
  final bool? isFavorite;

  const ImageDatum(
      {required this.id,
      required this.image,
      required this.ownerName,
      required this.imageSize,
      required this.imageHeight,
      required this.imageWidth,
      this.isFavorite = false});

  factory ImageDatum.fromJson(Map<String, dynamic> json) => ImageDatum(
      id: json['id'],
      image: json['largeImageURL'], // webformatURL / largeImageURL
      ownerName: json['user'],
      imageSize: json['imageSize'],
      imageHeight: json['previewHeight'],
      imageWidth: json['previewWidth']);
}
