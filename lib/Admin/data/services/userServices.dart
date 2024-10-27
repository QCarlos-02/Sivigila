import 'package:firebase_auth/firebase_auth.dart';

class Userservices {
  static final FirebaseAuth auth = FirebaseAuth.instance;

  //REGISTRO DE USUARIOS
  static Future<dynamic> crearRegistroUsuario(
      dynamic email, dynamic pass) async {
    try {
      UserCredential user = await auth.createUserWithEmailAndPassword(
          email: email, password: pass);
      print("funcion$user");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print("contraseña debil");
        return '1';
      } else if (e.code == 'email-already-in-use') {
        print('Correo ya existe');
        return '2';
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<dynamic> ingresarEmail(dynamic email, dynamic pass) async {
    try {
      UserCredential user =
          await auth.signInWithEmailAndPassword(email: email, password: pass);
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print("Correo no encontrado");
        return '1';
      } else if (e.code == 'wrong-password') {
        print('Contraseña incorrecta');
        return '2';
      }
    } catch (e) {
      print(e);
    }
  }
}
