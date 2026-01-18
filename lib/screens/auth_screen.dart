import 'package:flutter/material.dart';
import 'main_screen.dart'; // Import the main screen

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

enum AuthMode { Login, Signup }

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  AuthMode _authMode = AuthMode.Login;
  final _passwordController = TextEditingController();

  void _switchAuthMode() {
    setState(() {
      _authMode = _authMode == AuthMode.Login ? AuthMode.Signup : AuthMode.Login;
    });
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return; // Invalid!
    }
    _formKey.currentState!.save();

    if (_authMode == AuthMode.Login) {
      // In a real app, you would perform login logic here.
      // For now, we'll just navigate to the main screen.
       Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    } else {
      // In a real app, you would perform registration logic here.
      // After successful registration, navigate to the main screen.
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_authMode == AuthMode.Login ? 'Login' : 'Sign Up'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Welcome to TechShop',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 32),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder()),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => (value == null || !value.contains('@')) ? 'Invalid email' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController, // Add controller
                  decoration: const InputDecoration(labelText: 'Password', border: OutlineInputBorder()),
                  obscureText: true,
                   validator: (value) => (value == null || value.length < 6) ? 'Password is too short' : null,
                ),
                 if (_authMode == AuthMode.Signup)
                  const SizedBox(height: 16),
                if (_authMode == AuthMode.Signup)
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Confirm Password', border: OutlineInputBorder()),
                    obscureText: true,
                    validator: _authMode == AuthMode.Signup 
                        ? (value) {
                            if (value != _passwordController.text) {
                              return 'Passwords do not match!';
                            }
                            return null;
                          } 
                        : null,
                  ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(_authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP'),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: _switchAuthMode,
                  child: Text(
                    '${_authMode == AuthMode.Login ? 'No account yet?' : 'Already have an account?'} ${_authMode == AuthMode.Login ? 'Create one' : 'Login'}',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
