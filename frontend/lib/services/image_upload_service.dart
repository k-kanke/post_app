import 'dart:convert';
//import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class ImageUploadService {
  static Future<String?> uploadImage(XFile image) async {
    final url = Uri.parse(
      'http://192.168.3.33:8080/upload-image',
    ); // ← MacのIPにする
    final request = http.MultipartRequest('POST', url);

    request.files.add(await http.MultipartFile.fromPath('image', image.path));

    try {
      final response = await request.send();

      if (response.statusCode == 200) {
        final resBody = await response.stream.bytesToString();
        final data = json.decode(resBody);
        return data['url'];
      } else {
        print('画像アップロード失敗: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('アップロードエラー: $e');
      return null;
    }
  }
}
