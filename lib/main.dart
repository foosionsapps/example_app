import 'package:example_app/src/commons/service_locator.dart';
import 'package:example_app/src/models/album.dart';
import 'package:example_app/src/ui/home_screen.dart';
import 'package:example_app/src/ui/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(AlbumAdapter());
  await Hive.openBox<Album>('favoritesBox');
  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Example App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: (RouteSettings routeSettings) {
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context) {
            switch (routeSettings.name) {
              case '/home':
                return const HomeScreen();
              default:
                return const SplashScreen();
            }
          },
        );
      },
    );
  }
}
