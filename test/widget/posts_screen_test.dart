import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_api_assessment/presentation/screens/posts_screen.dart';
import 'package:flutter_api_assessment/data/repositories/post_repository_impl.dart';
import 'package:flutter_api_assessment/data/datasources/remote_data_source.dart';
import 'package:flutter_api_assessment/domain/models/post.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_api_assessment/presentation/blocs/post_bloc.dart';

// A fake remote datasource that returns a known list
class FakeRemote extends RemoteDataSource {
  FakeRemote() : super(dio: null);

  @override
  Future<List<Post>> fetchPosts() async {
    return [
      Post(id: 1, userId: 1, title: 'Test 1', body: 'Body 1'),
      Post(id: 2, userId: 1, title: 'Test 2', body: 'Body 2'),
    ];
  }
}

void main() {
  testWidgets('PostsScreen renders list items after fetching', (tester) async {
    final repo = PostRepositoryImpl(FakeRemote());

    await tester.pumpWidget(
      RepositoryProvider.value(
        value: repo,
        child: BlocProvider(
          create: (_) => PostBloc(repository: repo)..add(FetchPostsEvent()),
          child: const MaterialApp(home: PostsScreen()),
        ),
      ),
    );

    // initial frame with CircularProgressIndicator
    await tester.pump(); // start
    // bloc loading
    await tester.pump(const Duration(seconds: 1)); // allow future to resolve

    expect(find.byType(ListView), findsOneWidget);
    expect(find.text('Test 1'), findsOneWidget);
    expect(find.text('Test 2'), findsOneWidget);

  //   expect showing data in listview
  });
}
