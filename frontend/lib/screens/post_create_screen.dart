import 'package:flutter/material.dart';
import 'package:frontend/services/image_upload_service.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PostCreateScreen extends StatefulWidget {
  const PostCreateScreen({super.key});

  @override
  State<PostCreateScreen> createState() => _PostCreateScreenState();
}

class _PostCreateScreenState extends State<PostCreateScreen> {
  final TextEditingController _textController = TextEditingController();
  XFile? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  // 画像を選択
  Future<void> _pickImage() async {
    final image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _selectedImage = image;
    });
  }

  // 投稿する
  Future<void> _submitPost() async {
    final text = _textController.text;

    if (text.isEmpty || _selectedImage == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('テキストと画像を両方選んでください')));
      return;
    }

    // 画像をアップロードしてURLを取得
    final imageUrl = await ImageUploadService.uploadImage(_selectedImage!);
    if (imageUrl == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('画像のアップロードに失敗しました')));
    }

    // 投稿を送信
    final url = Uri.parse('http://192.168.3.33:8080/posts');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'user_id': 1, // テスト用ユーザーID
        'text': text,
        'image_url': imageUrl,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      Navigator.pop(context); // 投稿成功するとタイムラインに戻る
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('投稿に失敗しました (${response.statusCode})')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('投稿作成')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _textController,
              decoration: const InputDecoration(labelText: 'テキストを入力'),
              maxLines: null,
            ),
            const SizedBox(height: 10),
            _selectedImage != null
                ? Image.file(File(_selectedImage!.path), height: 150)
                : const Text("画像が選択されていません"),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: _pickImage, child: const Text("画像を選択")),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _submitPost, child: const Text("投稿する")),
          ],
        ),
      ),
    );
  }
}
