import 'package:example_app/src/view_models/albums_list_view_model.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void setup() {
  sl.registerSingleton<AlbumsListViewModel>(AlbumsListViewModel());
}
