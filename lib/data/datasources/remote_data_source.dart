import 'package:dio/dio.dart';
import '../../domain/models/post.dart';
import '../../utils/network_exception.dart';

class RemoteDataSource {
  final Dio dio;

  RemoteDataSource({Dio? dio}) : dio = dio ?? Dio();

  Future<List<Post>> fetchPosts() async {
    try {
      final response = await dio.get('https://jsonplaceholder.typicode.com/posts');
      if (response.statusCode == 200) {
        final List data = response.data as List;
        return data.map((e) => Post.fromJson(e as Map<String, dynamic>)).toList();
      } else {
        throw NetworkException('Status code: ${response.statusCode}');
      }
    } on DioException catch (e) {  //  DioException
      //
      throw NetworkException(e.message ?? 'Unknown Dio error');
    } catch (e) {
      throw NetworkException('Unexpected error: $e');
    }
  }
}
