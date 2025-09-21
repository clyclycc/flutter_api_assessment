import '../../domain/models/post.dart';
import '../../domain/repositories/post_repository.dart';
import '../datasources/remote_data_source.dart';

class PostRepositoryImpl implements PostRepository {
  final RemoteDataSource remoteDataSource;

  PostRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Post>> getPosts() async {
    return remoteDataSource.fetchPosts();
  }
}


 // Connecting domain and data