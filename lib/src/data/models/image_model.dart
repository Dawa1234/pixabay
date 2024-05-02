import 'package:equatable/equatable.dart';

class ImageData {
  final List<ImageDatum> imageData;
  const ImageData({required this.imageData});

  factory ImageData.fromJson(Map<String, dynamic> json) => ImageData(
      imageData: (json['hits'] as List)
          .map((json) => ImageDatum.fromJson(json))
          .toList());
}

class ImageDatum extends Equatable {
  final int id;
  final String image;
  final String ownerName;
  final int imageSize;

  const ImageDatum(
      {required this.id,
      required this.image,
      required this.ownerName,
      required this.imageSize});

  factory ImageDatum.fromJson(Map<String, dynamic> json) => ImageDatum(
      id: json['id'],
      image: json['largeImageURL'],
      ownerName: json['user'],
      imageSize: json['imageSize']);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'largeImageURL': image,
      'user': ownerName,
      'imageSize': imageSize
    };
  }

  @override
  List<Object?> get props => [id];
}
