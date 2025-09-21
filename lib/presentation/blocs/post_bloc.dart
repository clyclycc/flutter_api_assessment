import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/models/post.dart';
import '../../domain/repositories/post_repository.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository repository;

  PostBloc({required this.repository}) : super(PostInitial()) {
    on<FetchPostsEvent>((event, emit) async {
      emit(PostLoading());
      // loading data, updating state
      try {
        final posts = await repository.getPosts();
        emit(PostLoaded(posts: posts));
      } catch (e) {
        emit(PostError(message: e.toString()));
      }
    });
  }

//   constructor, handling event
}
