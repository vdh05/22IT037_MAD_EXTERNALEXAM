import 'package:flutter/material.dart';
import '../models/user_model.dart';
import 'admin/admin_dashboard.dart';
import 'operator/operator_dashboard.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String _errorMessage = '';

  void _login() {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

  
    if (username.isEmpty || password.isEmpty) {
      setState(() {
        _errorMessage = 'Username and password are required';
      });
      return;
    }

    // For demo purposes, we'll use a hardcoded check
    // In a real app, this would validate against a database or API
    if (username == 'admin' && password == 'admin123') {
      // Admin login
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const AdminDashboard(),
      ));
    } else if (username == 'operator' && password == 'operator123') {
      // Operator login
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const OperatorDashboard(),
      ));
    } else {
      setState(() {
        _errorMessage = 'Invalid username or password';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Material Tracking Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Login to Access Material Tracking',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            if (_errorMessage.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                _errorMessage,
                style: TextStyle(color: Colors.red[700]),
              ),
            ],
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _login,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              child: const Text('Login'),
            ),
            const SizedBox(height: 16),
            const Text(
              'Admin login: admin/admin123\nOperator login: operator/operator123',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
