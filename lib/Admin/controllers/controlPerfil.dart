import 'package:get/get.dart';
import 'package:sivigila/Admin/data/services/peticionesPerfil.dart';

class Controlperfil extends GetxController {
  Future<void> crearCatalogo(Map<String, dynamic> catalogo) async {
    await Peticionesperfil.crearCatalogo(catalogo);
  }
}
