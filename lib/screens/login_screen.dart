import 'package:flutter/material.dart';
import 'register_screen.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String email = '', password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("🚗 CarZone", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
              const SizedBox(height: 40),
              Card(
                elevation: 8,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Text("Login to Continue", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                        const SizedBox(height: 20),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Email', prefixIcon: Icon(Icons.email)),
                          validator: (v) => v!.isEmpty ? 'Enter your email' : null,
                          onSaved: (v) => email = v!,
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Password', prefixIcon: Icon(Icons.lock)),
                          obscureText: true,
                          validator: (v) => v!.length < 6 ? 'Password must be 6+ chars' : null,
                          onSaved: (v) => password = v!,
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 14),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
                            }
                          },
                          child: const Text("Login"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterScreen()));
                          },
                          child: const Text("Don't have an account? Register"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
