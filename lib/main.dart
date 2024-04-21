import 'package:flutter/material.dart';
import 'login/forgot_password_page.dart';
import 'login/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login Demo',
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/forgot_password': (context) => ForgotPasswordPage(),
        // Add other routes for different pages (e.g., home page, etc.)
      },
    );
  }
}
