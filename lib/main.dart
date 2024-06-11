import 'package:flutter/material.dart';
import 'package:pfour/dashboard/dashboard.dart';
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
      initialRoute: '/dashboard',
      routes: {
        '/login': (context) => LoginPage(),
        '/forgot_password': (context) => ForgotPasswordPage(),
        '/dashboard': (context) => DashboardPage(),
        // Add other routes for different pages (e.g., home page, etc.)
      },
    );
  }
}
