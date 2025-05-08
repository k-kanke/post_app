import 'package:flutter/material.dart';
import 'package:frontend/screens/post_create_screen.dart';
import '../models/post.dart';
import '../services/post_service.dart';

class TimelineScreen extends StatefulWidget {
  const TimelineScreen({super.key});

  @override
  State<TimelineScreen> createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> {
  late Future<List<Post>> _postsFuture;

  @override
  void initState() {
    super.initState();
    _postsFuture = PostService.fetchPosts();
  }

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
      body: FutureBuilder<List<Post>>(
        future: _postsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('エラー: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('投稿がありません'));
          } else {
            final posts = snapshot.data!;
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return ListTile(
                  title: Text(post.text),
                  subtitle: Text('ユーザーID: ${post.userId}'),
                  leading:
                      post.imageUrl.isNotEmpty
                          ? Image.network(
                            post.imageUrl,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          )
                          : const Icon(Icons.image),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _goToCreatePost(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
