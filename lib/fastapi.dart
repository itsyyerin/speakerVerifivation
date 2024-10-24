import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';

class ApiService {
  final String baseUrl = "http://172.20.13.21:8000";  // FastAPI 서버 주소

  Future<Map<String, dynamic>?> compareSpeakers(File file1, File file2) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/upload/'),  // 엔드포인트 수정
    );
    request.files.add(await http.MultipartFile.fromPath('file1', file1.path));  // 필드 이름 수정
    request.files.add(await http.MultipartFile.fromPath('file2', file2.path));  // 필드 이름 수정

    var response = await request.send();
    if (response.statusCode == 200) {
      var responseData = await http.Response.fromStream(response);
      var jsonData = json.decode(responseData.body);

      // 유사도와 결과를 포함하여 반환
      return {
        'result': jsonData['result'],  // 'same' 또는 'different'
        'similarity_score': jsonData['similarity_score'],  // 유사도 점수
      };
    } else {
      print('비교 화자 에러: ${response.statusCode}');
      return null;
    }
  }
}
