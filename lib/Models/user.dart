class User {
  String id;
  String correo;
  String cedula;
  String nombre;
  String rol;

  User(
      {required this.id,
      required this.correo,
      required this.cedula,
      required this.nombre,
      required this.rol});

  User.fromMap(String id, Map<String, dynamic> map)
      : id = id,
        correo = map['correo'],
        cedula = map['cedula'],
        nombre = map['nombre'],
        rol = map['rol'];

  Map<String, dynamic> toMap() {
    return {'correo': correo, 'nombre': nombre, 'cedula': cedula, 'rol': rol};
  }
}
