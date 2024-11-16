import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:sivigila/Admin/controllers/userController.dart';
import 'package:sivigila/Models/reporte.dart'; // Importa la clase Reporte

class Reportesservices {
  // Instancia de FirebaseFirestore para acceder a la base de datos
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  ControlUserAuth controlUserAuth = Get.find();

  // Método para guardar un nuevo reporte en Firestore
  Future<String> guardarReporte(
    String seccion,
    String categoria,
    String subcategoria,
    String subsubcategoria,
    String evento,
    String fecha,
    String persona,
    String zona,
    String comuna,
    String barrio,
    String direccion,
    String descripcion,
    String estado,
  ) async {
    try {
      var reference = _db.collection("reportes");
      var result = await reference.add({
        'seccion': seccion,
        'categoria': categoria,
        'subcategoria': subcategoria,
        'subsubcategoria': subsubcategoria,
        'evento': evento,
        'fecha': fecha,
        'persona': persona,
        'zona': zona,
        'comuna': comuna,
        'barrio': barrio,
        'direccion': direccion,
        'descripcion': descripcion,
        'estado': estado,
      });

      return result.id;
    } catch (e) {
      print('Error al guardar el reporte: $e');
      rethrow; // Lanza el error para que pueda ser manejado externamente
    }
  }

  // Método para obtener la lista de reportes desde Firestore
  Future<List<Reporte>> listaReportes() async {
    try {
      var snapshot = await _db.collection("reportes").get();
      return snapshot.docs.map((doc) {
        final data = doc.data(); // Conversión explícita
        return Reporte.desdeDoc(doc.id, data);
      }).toList();
    } catch (e) {
      print('Error al obtener la lista de reportes: $e');
      return []; // Devuelve una lista vacía si hay un error
    }
  }

  // Método para obtener reportes filtrados por estado
  Future<List<Reporte>> listaReportesPorRol(String estado) async {
    try {
      QuerySnapshot snapshot = await _db
          .collection('reportes')
          .where("estado", isEqualTo: estado)
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>; // Conversión explícita
        return Reporte.desdeDoc(doc.id, data);
      }).toList();
    } catch (e) {
      print('Error al obtener reportes por estado: $e');
      return []; // Devuelve una lista vacía si hay un error
    }
  }

  // Método para actualizar un reporte en Firestore
  Future<void> actualizarReporte(String id, Map<String, dynamic> datos) async {
    try {
      await _db.collection('reportes').doc(id).update(datos);
    } catch (e) {
      print('Error al actualizar el reporte: $e');
    }
  }
}
