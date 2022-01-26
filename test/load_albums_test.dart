import 'package:dio/dio.dart';
import 'package:example_app/src/commons/service_locator.dart';
import 'package:example_app/src/models/albums_list.dart';
import 'package:example_app/src/view_models/albums_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

class MockBuildContext extends Mock implements BuildContext {}

//Tests in progress
@GenerateMocks([Dio])
void main() {
  late MockBuildContext _mockContext;

  setUp(() {
    _mockContext = MockBuildContext();
  });

  group('loadAlbums', () {
    test('returns all albums if dio call completes successfully', () async {
      final client = Dio();

      when(client
              .get('https://mocki.io/v1/d2a590a8-4053-48de-a78a-0fd7654bdef8'))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(
                    path:
                        'https://mocki.io/v1/d2a590a8-4053-48de-a78a-0fd7654bdef8'),
                data: AlbumsList(resultCount: 40, results: []),
              ));

      expect(await sl<AlbumsListViewModel>().getAllAlbums(_mockContext),
          isA<AlbumsList>());
    });
  });
}
