import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/post_bloc.dart';
import '../../domain/models/post.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  late PostBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<PostBloc>();
    _bloc.add(FetchPostsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Posts')),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state is PostLoading || state is PostInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PostError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Error: ${state.message}'),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: () => _bloc.add(FetchPostsEvent()),
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry'),
                  ),
                ],
              ),
            );
          } else if (state is PostLoaded) {
            final posts = state.posts;
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final Post post = posts[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    title: Text(post.title, maxLines: 1, overflow: TextOverflow.ellipsis),
                    subtitle: Text(post.body, maxLines: 2, overflow: TextOverflow.ellipsis),
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => PostDetailScreen(post: post),
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}

class PostDetailScreen extends StatelessWidget {
  final Post post;
  const PostDetailScreen({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Post ${post.id}')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(post.title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            Text(post.body, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
