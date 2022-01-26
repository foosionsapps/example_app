import 'package:example_app/src/commons/service_locator.dart';
import 'package:example_app/src/models/album.dart';
import 'package:example_app/src/ui/components/list_tile_component.dart';
import 'package:example_app/src/view_models/albums_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AlbumFavoritesListComponent extends StatefulWidget {
  const AlbumFavoritesListComponent({Key? key}) : super(key: key);

  @override
  _AlbumFavoritesListComponentState createState() =>
      _AlbumFavoritesListComponentState();
}

class _AlbumFavoritesListComponentState
    extends State<AlbumFavoritesListComponent> {
  var favoritesBox = sl<AlbumsListViewModel>().favoritesBox;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: favoritesBox.listenable(),
      builder: (BuildContext context, Box<Album> albumBox, _) {
        if (favoritesBox.isNotEmpty) {
          return ListView.builder(
            itemCount: favoritesBox.length,
            itemBuilder: (context, index) {
              Album _album = favoritesBox.getAt(index)!;
              return ListTileComponent(album: _album);
            },
          );
        }

        return Container();
      },
    );
  }
}
