class Reporte {
  final String id;
  final String seccion;
  final String nombres;
  final String apellidos;
  final String fecha;
  final String comuna;
  final String barrio;
  final String direccion;
  final String zona;
  final String categoria;
  final String subcategoria;
  final String subsubcategoria;
  final String descripcion;
  final String estado;
  final List<String>? comentRef;
  final bool tieneComentario; // Nuevo campo
  final String observaciones;

  Reporte({
    required this.id,
    required this.seccion,
    required this.nombres,
    required this.apellidos,
    required this.fecha,
    required this.comuna,
    required this.barrio,
    required this.direccion,
    required this.zona,
    required this.categoria,
    required this.subcategoria,
    required this.subsubcategoria,
    required this.descripcion,
    required this.estado,
    this.comentRef,
    required this.tieneComentario, // Aseguramos que el campo esté presente al crear el reporte
    required this.observaciones,
  });

  // Método de fábrica para crear un objeto Reporte desde un documento de Firestore
  factory Reporte.desdeDoc(String id, Map<String, dynamic> data) {
    return Reporte(
      id: id,
      seccion: data['seccion'] ?? '',
      nombres: data['nombres'] ?? '',
      apellidos: data['apellidos'] ?? '',
      fecha: data['fecha'] ?? '',
      comuna: data['comuna'] ?? '',
      barrio: data['barrio'] ?? '',
      direccion: data['direccion'] ?? '',
      zona: data['zona'] ?? '',
      categoria: data['categoria'] ?? '',
      subcategoria: data['subcategoria'] ?? '',
      subsubcategoria: data['subsubcategoria'] ?? '',
      descripcion: data['descripcion'] ?? '',
      estado: data['estado'] ?? '',
      observaciones: data['observaciones'] ?? '',
      comentRef: data['ComentRef'] != null
          ? List<String>.from(data['ComentRef'])
          : null, // Convierte a List<String> si no es nulo
      // Si ComentRef tiene algún valor, entonces tieneComentario será true
      tieneComentario: data['ComentRef'] != null &&
          (data['ComentRef'] as List)
              .isNotEmpty, // Verifica si tiene comentario
    );
  }
}
