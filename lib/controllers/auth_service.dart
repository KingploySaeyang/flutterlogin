import 'dart:convert'; // นำเข้าฟังก์ชัน jsonEncode
//import 'package:flutterr/models/user_model.dart';
import 'package:flutterlogin/page/varaible.dart';
import 'package:http/http.dart' as http;

class AuthService {
  //final String apiURL; // เพิ่มตัวแปรเพื่อเก็บ URL ของ API

  //AuthService(this.apiURL); // สร้างคอนสตรัคเตอร์เพื่อรับ apiURL

  Future<void> login(String username, String password) async {
    print(apiURL);
    print(username);
    print(password);

    final response = await http.post(
      Uri.parse("$apiURL/api/auth/login"),
      headers: {"Content-Type": "application/json"}, // ใช้ headers แทน header
      body: jsonEncode(
        // ใช้ body แทนการพิมพ์ผิด
        {
          "username": username,
          "password": password,
        },
      ),
    );
    print(response.statusCode);
    print(response.body);
  }
}