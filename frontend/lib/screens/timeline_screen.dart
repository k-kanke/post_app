import 'package:flutter/material.dart';
import 'post_create_screen.dart';

class TimelineScreen extends StatelessWidget {
  const TimelineScreen({super.key});

  void _goToCreatePost(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const PostCreateScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('タイムライン')),
      body: const Center(child: Text('投稿はまだありません')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _goToCreatePost(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
