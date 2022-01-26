import 'package:example_app/src/commons/date_time_extension.dart';
import 'package:example_app/src/commons/service_locator.dart';
import 'package:example_app/src/models/album.dart';
import 'package:example_app/src/view_models/albums_list_view_model.dart';
import 'package:flutter/material.dart';

class ListTileComponent extends StatefulWidget {
  const ListTileComponent({Key? key, required this.album}) : super(key: key);

  final Album album;

  @override
  State<ListTileComponent> createState() => _ListTileComponentState();
}

class _ListTileComponentState extends State<ListTileComponent> {
  var favoritesBox = sl<AlbumsListViewModel>().favoritesBox;

  Widget getFavoriteIcon(Album album) {
    if (favoritesBox.containsKey(album.collectionId)) {
      return const Icon(Icons.favorite, color: Colors.red);
    }
    return const Icon(Icons.favorite_border);
  }

  void onFavoriteIconPress(Album album) {
    if (favoritesBox.containsKey(album.collectionId)) {
      favoritesBox.delete(album.collectionId);
      sl<AlbumsListViewModel>().notifyChanges();
      return;
    }
    favoritesBox.put(album.collectionId, album);
    sl<AlbumsListViewModel>().notifyChanges();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 20,
        backgroundImage: NetworkImage(widget.album.image),
      ),
      title: Text(widget.album.name),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.album.releaseDate.format()),
          Text('Price: \$ ${widget.album.price}'),
        ],
      ),
      trailing: IconButton(
        icon: getFavoriteIcon(widget.album),
        onPressed: () => onFavoriteIconPress(widget.album),
      ),
    );
  }
}
