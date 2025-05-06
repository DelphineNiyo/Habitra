import 'package:flutter/material.dart';
import '../../../app/routes.dart';
import '../../../services/auth_service.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final _auth = AuthService();
  String _firstName = '', _lastName = '', _username = '', _email = '', _password = '';
  bool _loading = false;

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    // Log the data being sent
    print('Submitting registration...');
    print('First Name: $_firstName');
    print('Last Name: $_lastName');
    print('Username: $_username');
    print('Email: $_email');
    print('Password: $_password');  // Avoid logging real passwords in production!

    setState(() => _loading = true);

    try {
      // Call the register method
      await _auth.register(_firstName, _lastName, _username, _email, _password);

      // Log success
      print('Registration successful! User created.');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Account created successfully! Please log in.'),
          backgroundColor: Colors.green,
        ),
      );

      // Navigate to the login page
      Navigator.pushReplacementNamed(context, Routes.login);
    } catch (e) {
      // Log the error
      print('Registration failed: ${e.toString()}');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Registration failed: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'First Name'),
                onSaved: (v) => _firstName = v!.trim(),
                validator: (v) => v == null || v.isEmpty ? 'Enter first name' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Last Name'),
                onSaved: (v) => _lastName = v!.trim(),
                validator: (v) => v == null || v.isEmpty ? 'Enter last name' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Username'),
                onSaved: (v) => _username = v!.trim(),
                validator: (v) => v == null || v.isEmpty ? 'Enter username' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                onSaved: (v) => _email = v!.trim(),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Enter email';
                  if (!v.contains('@')) return 'Enter valid email';
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                onSaved: (v) => _password = v!.trim(),
                validator: (v) => v == null || v.isEmpty ? 'Enter password' : null,
              ),
              const SizedBox(height: 20),
              _loading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _submit,
                      child: const Text('Register'),
                    ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account?'),
                  TextButton(
                    onPressed: () => Navigator.pushReplacementNamed(context, Routes.login),
                    child: const Text('Sign In'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
