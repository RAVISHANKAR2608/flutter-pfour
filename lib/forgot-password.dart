import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot Password"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("This is the Forgot Password Page"),
            ElevatedButton(
              onPressed: () {
                // Navigate back to the previous page (login page)
                Navigator.pop(context);
              },
              child: Text("Back to Login"),
            ),
          ],
        ),
      ),
    );
  }
}
