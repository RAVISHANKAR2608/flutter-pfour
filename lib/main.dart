import 'package:flutter/material.dart';
import 'forgot-password.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(15.0),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Image(image: AssetImage('assets/images/pfour_logo.png')),
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    'Welcome Back !',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.w800),
                  ),
                  Text(
                    "It's a pleasure to reconnect with you !",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "You have been missed !",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Email', // Label for the email input
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          hintText: 'Enter Your Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!value.contains('@')) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  PasswordField(passwordController: passwordController),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Form is valid, process login
                        String email = emailController.text;
                        String password = passwordController.text;

                        // Perform your login logic here...
                        print("Email: $email");
                        print("Password: $password");
                      }
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Color(0xff0E024C)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextButton(
                    onPressed: () {
                      print("Forgot Password !!!");
                      // Navigate to the ForgotPasswordPage
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ForgotPasswordPage(),
                        ),
                      );
                    },
                    child: Text("Forgot Password"),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PasswordField extends StatefulWidget {
  final TextEditingController passwordController;

  const PasswordField({Key? key, required this.passwordController})
      : super(key: key);

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Password',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: widget.passwordController,
          obscureText: _obscureText,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock),
            hintText: 'Enter Your Password',
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: IconButton(
                icon:
                    Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your password';
            }
            if (value.length < 6) {
              return 'Password must be at least 6 characters';
            }
            return null;
          },
        ),
      ],
    );
  }
}
