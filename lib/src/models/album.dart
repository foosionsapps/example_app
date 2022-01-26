import 'package:hive/hive.dart';

part 'album.g.dart';

@HiveType(typeId: 0)
class Album {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String image;
  @HiveField(2)
  final double price;
  @HiveField(3)
  final DateTime releaseDate;
  @HiveField(4)
  final int collectionId;

  Album({
    required this.name,
    required this.image,
    required this.price,
    required this.releaseDate,
    required this.collectionId,
  });

  factory Album.fromJson(album) {
    return Album(
        name: album['collectionName'],
        image: album['artworkUrl60'],
        price: album['collectionPrice'] ?? 0.00,
        releaseDate: DateTime.parse(album['releaseDate']),
        collectionId: album['collectionId']);
  }
}
