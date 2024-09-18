import 'package:flutter/material.dart';
import 'package:flutterlogin/page/home.dart'; // นำเข้าหน้า MyHomePage
import 'package:flutterlogin/page/register.dart';
import 'package:flutterlogin/controllers/auth_service.dart';
import 'package:flutterlogin/provider/user_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() async {
    if (_formKey.currentState!.validate()) {
      print('Username : ${_usernameController.text}');
      print('Password : ${_passwordController.text}');
      try {
        // ignore: unused_local_variable
        final user = await AuthService()
            .login(_usernameController.text, _passwordController.text);
      
         if (!mounted) return; 
        Provider.of<UserProvider>(context, listen : false).onLogin(user);
      } catch (e) {
        print(e);
      }
    }
  }

  void saveData() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  await prefs.setString("userName", _usernameController.text);
  await prefs.setString("password", _passwordController.text);
}

String? userName;
String? password;

void getData() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  setState(() {
  userName = prefs.getString("userName");
  password = prefs.getString("password");
  });


}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'LOGIN',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.pinkAccent,
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.black45,
                        offset: Offset(2.0, 2.0),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Icon(
                  Icons.lock_open,
                  color: Colors.pinkAccent,
                  size: 120,
                ),
                const SizedBox(height: 40),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      const BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10.0,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      TextField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          labelText: 'Username',
                          prefixIcon: const Icon(
                            Icons.person,
                            color: Colors.pinkAccent,
                          ),
                          filled: true,
                          fillColor: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          labelText: 'Password',
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Colors.pinkAccent,
                          ),
                          filled: true,
                          fillColor: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
  onPressed: () {
    // ตรวจสอบค่าของทั้งชื่อผู้ใช้และรหัสผ่าน
    if (_usernameController.text.trim().isNotEmpty && 
        _passwordController.text.trim().isNotEmpty) {
      // บันทึกข้อมูลใน shared preferences
      saveData();
      // นำทางไปยังหน้า Home
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage(title: 'Home Page')),
      );
    } else {
      // แสดง SnackBar หากชื่อผู้ใช้หรือรหัสผ่านว่าง
      if (_usernameController.text.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("กรุณาพิมพ์ชื่อของคุณ")),
        );
      } 
      if (_passwordController.text.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("กรุณาพิมพ์รหัสผ่านของคุณ")),
        );
      }
    }
  },
  style: ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    backgroundColor: Colors.pink, // สีพื้นหลังของปุ่ม
  ),
  child: const Padding(
    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
    child: Text(
      'Login',
      style: TextStyle(fontSize: 18, color: Colors.white),
    ),
  ),
),

                /*ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    backgroundColor: Colors.pinkAccent, // สีของปุ่ม
                    shadowColor: Colors.pinkAccent.withOpacity(0.5),
                    elevation: 10.0,
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),*/
                // if (_errorMessage.isNotEmpty)
                //   Padding(
                //     padding: const EdgeInsets.only(top: 16),
                //     child: Text(
                //       _errorMessage,
                //       style: const TextStyle(color: Colors.red, fontSize: 16),
                //     ),
                //   ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegisterPage()),
                    );
                  },
                  child: const Text(
                    'Create an account',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.pinkAccent,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}