import 'package:flutter/material.dart';
import 'posts_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Assessment Home')),
      body: Center(
        child: ElevatedButton.icon(
          icon: const Icon(Icons.list),
          label: const Text('Open Posts'),
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const PostsScreen()),
          ),
        ),
      ),
    );
  }
}
