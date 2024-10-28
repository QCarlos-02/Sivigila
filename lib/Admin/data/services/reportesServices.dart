import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sivigila/Models/reporte.dart'; // Importa la clase Reporte

class Reportesservices {
  // Instancia de FirebaseFirestore para acceder a la base de datos
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

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
      'estado': estado
    });

    return result.id;
  }

  // Método para obtener la lista de reportes desde Firestore
  Future<List<Reporte>> listaReportes() async {
    var snapshot = await _db.collection("reportes").get();
    return snapshot.docs
        .map((doc) => Reporte.desdeDoc(doc.id, doc.data()))
        .toList();
  }
}
