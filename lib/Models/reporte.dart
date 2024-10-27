import 'package:cloud_firestore/cloud_firestore.dart';

class Reporte {
  final String id;
  final String seccion;
  final String categoria;
  final String evento;
  final String fecha;
  final String persona;
  final String zona;
  final String comuna;
  final String barrio;
  final String direccion;
  final String descripcion;
  final String estado;

  Reporte(
      {required this.id,
      required this.seccion,
      required this.categoria,
      required this.evento,
      required this.fecha,
      required this.persona,
      required this.zona,
      required this.comuna,
      required this.barrio,
      required this.direccion,
      required this.descripcion,
      required this.estado});

  // Convertir el objeto Reporte a un mapa para Firestore
  Map<String, dynamic> toMap() {
    return {
      'seccion': seccion,
      'categoria': categoria,
      'evento': evento,
      'fecha': fecha,
      'persona': persona,
      'zona': zona,
      'comuna': comuna,
      'barrio': barrio,
      'direccion': direccion,
      'descripcion': descripcion,
      'estado': estado,
    };
  }

  factory Reporte.desdeDoc(String id, Map<String, dynamic> json) {
    return Reporte(
        id: id,
        seccion: json['seccion'] ?? '',
        categoria: json['categoria'] ?? '',
        evento: json['evento'] ?? '',
        fecha: json['fecha'] ?? '',
        persona: json['persona'] ?? '',
        zona: json['zona'] ?? '',
        comuna: json['comuna'] ?? '',
        barrio: json['barrio'] ?? '',
        direccion: json['direccion'] ?? '',
        descripcion: json['descripcion'] ?? '',
        estado: json['estado'] ?? '');
  }

  toJson() {
    throw UnimplementedError();
  }
}

// Una lista global donde se guardarán los reportes
List<Reporte> reportesEnviados = [];

// Función para guardar el reporte en Firestore
Future<void> guardarReporte(Reporte reporte) async {
  try {
    // Agregar el reporte a la colección 'reportes'
    await FirebaseFirestore.instance
        .collection('reportes')
        .add(reporte.toMap());
    // Agregar a la lista de reportes enviados
    reportesEnviados.add(reporte);
    print('Reporte guardado con éxito');
  } catch (e) {
    print('Error al guardar el reporte: $e');
  }
}
