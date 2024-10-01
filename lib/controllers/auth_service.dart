import 'dart:convert'; // นำเข้าฟังก์ชัน jsonEncode
import 'package:flutterlogin/models/user_model.dart'; // นำเข้า UserModel
import 'package:flutterlogin/page/varaible.dart';
import 'package:http/http.dart' as http;

class AuthService {
  Future<UserModel> login(String username, String password) async {
    final response = await http.post(
      Uri.parse("$apiURL/api/auth/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "username": username,
        "password": password,
      }),
    );

    if (response.statusCode == 200) {
      // ถ้าสำเร็จให้คืนค่า UserModel
      return userModelFromJson(response.body);
    } else {
      // ถ้าไม่สำเร็จให้โยนข้อผิดพลาด
      throw Exception('Failed to login');
    }
  }
}
