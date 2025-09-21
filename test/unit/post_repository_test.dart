import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_api_assessment/data/datasources/remote_data_source.dart';
import 'package:flutter_api_assessment/data/repositories/post_repository_impl.dart';
import 'package:flutter_api_assessment/domain/models/post.dart';

class MockRemoteDataSource extends Mock implements RemoteDataSource {}

void main() {
  late MockRemoteDataSource mockRemote;
  late PostRepositoryImpl repository;

  setUp(() {
    mockRemote = MockRemoteDataSource();
    repository = PostRepositoryImpl(mockRemote);
  });

  test('returns list of posts when remote datasource succeeds', () async {
    final posts = [
      Post(id: 1, userId: 1, title: 't1', body: 'b1'),
    ];

    when(() => mockRemote.fetchPosts()).thenAnswer((_) async => posts);

    final result = await repository.getPosts();
    expect(result, isA<List<Post>>());
    expect(result.length, 1);
    expect(result.first.title, 't1');
  });

  test('throws when remote datasource throws', () async {
    when(() => mockRemote.fetchPosts()).thenThrow(Exception('fail'));
    expect(() => repository.getPosts(), throwsA(isA<Exception>()));
  });
}
