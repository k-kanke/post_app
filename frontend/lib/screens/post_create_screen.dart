import 'package:flutter/material.dart';

class PostCreateScreen extends StatelessWidget {
  const PostCreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('投稿を作成')),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'テキストを入力'),
              maxLines: 4,
            ),
            SizedBox(height: 20),
            Text('※画像選択ボタンは後で実装'),
          ],
        ),
      ),
    );
  }
}
