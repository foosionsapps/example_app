import 'package:example_app/src/commons/service_locator.dart';
import 'package:example_app/src/models/album.dart';
import 'package:example_app/src/models/albums_list.dart';
import 'package:example_app/src/ui/components/list_tile_component.dart';
import 'package:example_app/src/view_models/albums_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AlbumsListComponent extends StatefulWidget {
  const AlbumsListComponent({Key? key}) : super(key: key);

  @override
  _AlbumsListComponentState createState() => _AlbumsListComponentState();
}

class _AlbumsListComponentState extends State<AlbumsListComponent> {
  var favoritesBox = sl<AlbumsListViewModel>().favoritesBox;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: sl<AlbumsListViewModel>().getAllAlbums(context),
      builder: (BuildContext context, AsyncSnapshot<AlbumsList> snapshot) {
        if (snapshot.data == null) {
          return Container();
        }

        List<Album>? results = snapshot.data?.results;

        if (results != null) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  'Number of results: ${snapshot.data?.resultCount}',
                  style: const TextStyle(fontSize: 30, color: Colors.orange),
                ),
              ),
              Expanded(
                child: ValueListenableBuilder(
                    valueListenable: favoritesBox.listenable(),
                    builder: (BuildContext context, Box<Album> albumBox, _) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: results.length,
                        itemBuilder: (BuildContext context, int index) {
                          Album _album = results[index];
                          return ListTileComponent(album: _album);
                        },
                      );
                    }),
              ),
            ],
          );
        }

        return Container();
      },
    );
  }
}
