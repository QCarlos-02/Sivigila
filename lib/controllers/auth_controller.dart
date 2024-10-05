import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';

class AuthController extends ChangeNotifier {
  final AuthService _authService = AuthService();
  UserModel? _user;

  UserModel? get user => _user;

  AuthController() {
    // Actualizar el estado del usuario cuando Firebase cambie
    _user = _authService.getCurrentUser();
    notifyListeners();
  }

  Future<void> signIn(String email, String password) async {
    try {
      _user = await _authService.signInWithEmail(email, password);
      notifyListeners();
    } catch (e) {
      print("Error al iniciar sesión: $e");
    }
  }

  Future<void> signUp(String email, String password) async {
    try {
      _user = await _authService.signUpWithEmail(email, password);
      notifyListeners();
    } catch (e) {
      print("Error al registrarse: $e");
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
    _user = null;
    notifyListeners();
  }
}
