import 'package:flutter/material.dart';
import 'screens/auth/login_screen.dart';
import 'services/auth_service.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    // Check if user is already logged in
    await _authService.checkLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    return const LoginScreen();
  }
}