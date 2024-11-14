class Reporte {
  final String id;
  final String nombres;
  final String apellidos;
  final String seccion;
  final String categoria;
  final String subcategoria;
  final String subsubcategoria;
  final String evento;
  final String fecha;
  final String persona;
  final String zona;
  final String comuna;
  final String barrio;
  final String direccion;
  final String descripcion;
  final String observaciones;
  final String comentarioReferente;
  final String estado;

  Reporte({
    required this.id,
    required this.nombres,
    required this.apellidos,
    required this.seccion, // Asegúrate de que este campo esté definido
    required this.categoria,
    required this.subcategoria,
    required this.subsubcategoria,
    required this.evento,
    required this.fecha,
    required this.persona,
    required this.zona,
    required this.comuna,
    required this.barrio,
    required this.direccion,
    required this.descripcion,
    required this.observaciones,
    required this.comentarioReferente,
    required this.estado,
  });

  factory Reporte.desdeDoc(String id, Map<String, dynamic> json) {
    return Reporte(
      id: id,
      nombres: json['nombres'] ?? '',
      apellidos: json['apellidos'] ?? '',
      seccion: json['seccion'] ?? '',
      categoria: json['categoria'] ?? '',
      subcategoria: json['subcategoria'] ?? '',
      subsubcategoria: json['subsubcategoria'] ?? '',
      evento: json['evento'] ?? '',
      fecha: json['fecha_incidente'] ?? '',
      persona: json['persona'] ?? '',
      zona: json['zona'] ?? '',
      comuna: json['comuna'] ?? '',
      barrio: json['barrio'] ?? '',
      direccion: json['direccion'] ?? '',
      descripcion: json['descripcion'] ?? '',
      observaciones: json['observaciones'] ?? '',
      comentarioReferente: json['comentario'] ?? '',
      estado: json['estado'] ?? '',
    );
  }
}
