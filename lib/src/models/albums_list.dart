import 'package:example_app/src/models/album.dart';

class AlbumsList {
  final int resultCount;
  final List<Album> results;

  AlbumsList({required this.resultCount, required this.results});

  factory AlbumsList.fromJson(response) {
    var _results = response['results'] as List;
    List<Album> _albumsList = [];

    if (_results.isNotEmpty) {
      _results.removeAt(0);
      for (var album in _results) {
        _albumsList.add(Album.fromJson(album));
      }
    }

    return AlbumsList(
      resultCount: response['resultCount'],
      results: _albumsList,
    );
  }
}
