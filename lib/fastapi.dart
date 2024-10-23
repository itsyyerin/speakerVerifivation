
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';

class ApiService {
  final String baseUrl = "http://172.20.8.219:8000";

  Future<dynamic> compareSpeakers(File file1, File file2) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/compare-speakers/'),
    );
    request.files.add(await http.MultipartFile.fromPath('mfcc_file1', file1.path));
    request.files.add(await http.MultipartFile.fromPath('mfcc_file2', file2.path));

    var response = await request.send();
    if (response.statusCode == 200) {
      var responseData = await http.Response.fromStream(response);
      var jsonData = json.decode(responseData.body);
      return jsonData['result']; // true 또는 false
    } else {
      print('비교 화자 에러: ${response.statusCode}');
      return null;
    }
  }
}
