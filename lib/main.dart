import 'package:flutter/material.dart';
import 'package:flutterlogin/page/login.dart';
import 'package:flutterlogin/provider/user_provider.dart';
import 'package:provider/provider.dart'; // นำเข้าหน้า LoginPage
//import 'register_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const LoginPage(), // เริ่มต้นที่หน้า LoginPage
        debugShowCheckedModeBanner: false, // ปิด Debug Banner
      ),
    );
  }
}