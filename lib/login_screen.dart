import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _passwordVisibility = true;
  String? _emailError;
  String? _passwordError;

  // Regular Expression for email validation
  final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9.a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z]{2,})+$',
  );

  // Regular Expression for password validation (at least 8 chars, 1 uppercase, 1 lowercase)
  final RegExp _passwordRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z]).{8,}$');

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _validateInputs() {
    setState(() {
      // Validate Email
      if (_emailController.text.isEmpty) {
        _emailError = 'Email cannot be empty';
      } else if (!_emailRegex.hasMatch(_emailController.text)) {
        _emailError = 'Please enter a valid email address';
      } else {
        _emailError = null;
      }

      // Validate Password
      if (_passwordController.text.isEmpty) {
        _passwordError = 'Password cannot be empty';
      } else if (!_passwordRegex.hasMatch(_passwordController.text)) {
        _passwordError =
            'Password must be at least 8 characters with 1 uppercase and 1 lowercase';
      } else {
        _passwordError = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Colors.purple[700],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'User Login',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: const Icon(Icons.email),
                  border: const OutlineInputBorder(),
                  errorText: _emailError, // Display error message
                ),
                keyboardType: TextInputType.emailAddress,
                onChanged: (_) => _validateInputs(), // Validate on change
              ),
              const SizedBox(height: 10), // Space for error message
              TextField(
                controller: _passwordController,
                obscureText: _passwordVisibility,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisibility
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisibility = !_passwordVisibility;
                      });
                    },
                  ),
                  border: const OutlineInputBorder(),
                  errorText: _passwordError, // Display error message
                ),
                onChanged: (_) => _validateInputs(), // Validate on change
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed:
                    _emailError == null && _passwordError == null
                        ? () {
                          print('Email: ${_emailController.text}');
                          print('Password: ${_passwordController.text}');
                        }
                        : null, // Disable button if validation fails
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                ),
                child: const Text('LOGIN', style: TextStyle(fontSize: 18)),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  print('Navigate to Register');
                },
                child: Text(
                  "Don't have an account? Register Now",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.purple[700]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
