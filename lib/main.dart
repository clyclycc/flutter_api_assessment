import 'package:flutter/material.dart';
import 'core/theme.dart';
import 'presentation/screens/home_screen.dart';
import 'data/datasources/remote_data_source.dart';
import 'data/repositories/post_repository_impl.dart';
import 'presentation/blocs/post_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  final remoteDataSource = RemoteDataSource();
  // fetching data
  final repository = PostRepositoryImpl(remoteDataSource);
  // Encapsulate the data source into a Repository
  runApp(MyApp(repository: repository));
}

class MyApp extends StatelessWidget {
  // UI does not require statefulWidget
  final PostRepositoryImpl repository;
  const MyApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: repository,
      child: BlocProvider(
        create: (_) => PostBloc(repository: repository),
        child: MaterialApp(
          title: 'Flutter API Assessment',
          theme: buildTheme(),
          debugShowCheckedModeBanner: false,
          home: const HomeScreen(),
        ),
      ),
    );
  //   provide Repository to the whole widget
  }
}