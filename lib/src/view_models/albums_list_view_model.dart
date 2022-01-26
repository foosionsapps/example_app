import 'package:example_app/src/models/album.dart';
import 'package:example_app/src/models/albums_list.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:dio/dio.dart';

class AlbumsListViewModel extends ChangeNotifier {
  late AlbumsList _albumsResponse;
  Box<Album> favoritesBox = Hive.box('favoritesBox');

  Future<AlbumsList> getAllAlbums(BuildContext context) async {
    try {
      var dioOptions = BaseOptions(
        baseUrl: 'https://mocki.io/v1/',
        connectTimeout: 5000,
        receiveTimeout: 3000,
      );

      Dio dio = Dio(dioOptions);

      var response = await dio
          .get('${dioOptions.baseUrl}d2a590a8-4053-48de-a78a-0fd7654bdef8');

      _albumsResponse = AlbumsList.fromJson(response.data);

      return _albumsResponse;
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Error loading albums.')));
    }
    return _albumsResponse;
  }

  void notifyChanges() {
    notifyListeners();
  }
}
