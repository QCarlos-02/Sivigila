import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String uid;
  final String email;

  UserModel({
    required this.uid,
    required this.email,
  });

  // Crear un UserModel a partir de un usuario de Firebase
  factory UserModel.fromFirebase(String id, User user) {
    return UserModel(
      uid: user.uid,
      email: user.email ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
    };
  }
}
