import 'package:app1/messanger/ChatListPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _passwordVisibility = true;
  String? _emailError;
  String? _passwordError;
  bool _isLoading = false;

  final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9.a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z]{2,})+$',
  );
  final RegExp _passwordRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z]).{8,}$');

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _validateInputs() {
    setState(() {
      if (_emailController.text.isEmpty) {
        _emailError = 'Email cannot be empty';
      } else if (!_emailRegex.hasMatch(_emailController.text)) {
        _emailError = 'Please enter a valid email address';
      } else {
        _emailError = null;
      }

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

  Future<void> _register() async {
    _validateInputs();
    if (_emailError != null || _passwordError != null) return;

    setState(() {
      _isLoading = true;
    });

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: _emailController.text,
            password: _passwordController.text,
          );
      // Navigate to MessengerScreen on success
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const ChatListPage()),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        if (e.code == 'email-already-in-use') {
          _emailError = 'This email is already registered';
        } else if (e.code == 'weak-password') {
          _passwordError = 'Password is too weak';
        } else {
          _emailError = 'An error occurred: ${e.message}';
        }
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Register'),
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
                'Create Account',
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
                  errorText: _emailError,
                ),
                keyboardType: TextInputType.emailAddress,
                onChanged: (_) => _validateInputs(),
              ),
              const SizedBox(height: 10),
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
                  errorText: _passwordError,
                ),
                onChanged: (_) => _validateInputs(),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: _isLoading ? null : _register,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                ),
                child:
                    _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                          'Register',
                          style: TextStyle(fontSize: 18),
                        ),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Back to LoginScreen
                },
                child: Text(
                  'Already have an account? Login',
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
