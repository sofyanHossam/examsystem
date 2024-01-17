// login_page.dart

import 'package:flutter/material.dart';
import 'auth_service.dart';

class LoginPage extends StatefulWidget {
  final String passedString;
  LoginPage({required this.passedString});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _loading = false;

  AuthService _authService = AuthService(); // Create an instance of AuthService

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page for ${widget.passedString}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                labelText: 'Password',
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 32),
            _loading
                ? CircularProgressIndicator()
                : ElevatedButton(
              onPressed: () {
                _authService.signInWithEmailAndPassword(
                  context,
                  _emailController,
                  _passwordController,
                      (loading) {
                    setState(() {
                      _loading = loading;
                    });
                  },
                );
              },
              child: Text('Login'),
            ),
            SizedBox(height: 16),
            _loading
                ? CircularProgressIndicator()
                : ElevatedButton(
              onPressed: () {
                _authService.createAccount(
                  widget.passedString,
                  context,
                  _emailController,
                  _passwordController,
                      (loading) {
                    setState(() {
                      _loading = loading;
                    });
                  },
                );
              },
              child: Text('Create Account'),
            ),
          ],
        ),
      ),
    );
  }
}
