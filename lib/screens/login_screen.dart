import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  bool isLoading = false;
  String? error;

  void _login() async {
    setState(() { isLoading = true; error = null; });
    final success = await AuthService().login(email, password);
    setState(() { isLoading = false; });
    if (success) {
      Navigator.pushReplacementNamed(context, '/profile');
    } else {
      setState(() { error = 'Invalid credentials'; });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Color(0xFF22223B);
    final Color accentColor = Color(0xFF4A4E69);
    final Color backgroundColor = Color(0xFFF2E9E4);
    final Color buttonColor = Color(0xFF9A8C98);
    final Color errorColor = Color(0xFFC9ADA7);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Welcome Back',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 32),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: Icon(Icons.email, color: accentColor),
                    ),
                    onChanged: (val) => email = val,
                    validator: (val) => val!.isEmpty ? 'Enter email' : null,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: Icon(Icons.lock, color: accentColor),
                    ),
                    obscureText: true,
                    onChanged: (val) => password = val,
                    validator: (val) => val!.isEmpty ? 'Enter password' : null,
                  ),
                  SizedBox(height: 24),
                  if (error != null)
                    Text(
                      error!,
                      style: TextStyle(color: errorColor, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  SizedBox(height: 10),
                  isLoading
                      ? Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: buttonColor,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) _login();
                          },
                          child: Text('Login', style: TextStyle(fontSize: 18)),
                        ),
                  SizedBox(height: 16),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/signup'),
                    child: Text(
                      'Don\'t have an account? Sign up',
                      style: TextStyle(color: accentColor, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
