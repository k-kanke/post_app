import 'package:flutter/material.dart';
import '../models/post.dart';

class PostDetailScreen extends StatelessWidget {
  final Post post;

  const PostDetailScreen({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('投稿詳細')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            post.imageUrl.isNotEmpty
                ? Image.network(
                  post.imageUrl,
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                )
                : const SizedBox(
                  height: 200,
                  child: Center(child: Icon(Icons.image)),
                ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(post.text, style: const TextStyle(fontSize: 18)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'ユーザーID: ${post.userId}\n投稿日: ${post.createdAt}',
                style: const TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
