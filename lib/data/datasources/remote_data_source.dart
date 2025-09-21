import 'package:dio/dio.dart';
import '../../domain/models/post.dart';
import '../../utils/network_exception.dart';

class RemoteDataSource {
  final Dio dio;

  RemoteDataSource({Dio? dio}) : dio = dio ?? Dio() {
    // defaults.headers
    this.dio.options.headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'User-Agent': 'Flutter-App/DioBrandon (Mobile Application)',
    };

    // setting timeout
    this.dio.options.connectTimeout = const Duration(seconds: 10);
    this.dio.options.receiveTimeout = const Duration(seconds: 10);
    this.dio.options.sendTimeout = const Duration(seconds: 10);
  }

  Future<List<Post>> fetchPosts() async {
    try {
      final response = await dio.get(
        'https://jsonplaceholder.typicode.com/posts',
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'User-Agent': 'Mozilla/5.0 (compatible; FlutterApp/1.0)',
          },
        ),
      );

      if (response.statusCode == 200) {
        final List data = response.data as List;
        return data.map((e) => Post.fromJson(e as Map<String, dynamic>)).toList();
      } else {
        throw NetworkException('HTTP Error: ${response.statusCode}');
      }
    } on DioException catch (e) {
      // error handling
      if (e.response?.statusCode == 403) {
        throw NetworkException('Access denied: The server refused the request. This might be due to rate limiting or blocked user agent.');
      }
      throw NetworkException(e.message ?? 'Network error occurred');
    } catch (e) {
      throw NetworkException('Unexpected error: $e');
    }
  }
}