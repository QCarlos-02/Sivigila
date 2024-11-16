// Modelo base para User
class Usuarios {
  String id;
  String correo;
  String nombre;
  String rol;
  String password;

  Usuarios({
    required this.id,
    required this.correo,
    required this.nombre,
    required this.rol,
    required this.password,
  });

  factory Usuarios.desdeDoc(String id, Map<String, dynamic> data) {
    return Usuarios(
      id: id,
      correo: data['correo'] ?? '',
      nombre: data['nombres'] ?? '',
      rol: data['rol'] ?? '',
      password: data['password'] ?? '',
    );
  }
}

// Subclase para el líder con atributos adicionales
class Leader extends Usuarios {
  String apellidos;
  String tipoDocumento;
  String numeroDocumento;
  String nacionalidad;
  String edad;
  String telefono;
  String departamento;
  String municipio;
  String comuna;
  String barrio;
  String direccion;
  String areaDeInfluencia;
  String nivelDePoder;
  String nivelDeParticipacion;
  String rol2;
  String categoria;

  Leader(
      {required String id,
      required String correo,
      required String nombre,
      required String rol,
      required String password,
      required this.apellidos,
      required this.tipoDocumento,
      required this.numeroDocumento,
      required this.nacionalidad,
      required this.edad,
      required this.telefono,
      required this.departamento,
      required this.municipio,
      required this.comuna,
      required this.barrio,
      required this.direccion,
      required this.areaDeInfluencia,
      required this.nivelDePoder,
      required this.nivelDeParticipacion,
      required this.rol2,
      required this.categoria})
      : super(
            id: id,
            correo: correo,
            nombre: nombre,
            rol: rol,
            password: password);

  factory Leader.desdeDoc(String id, Map<String, dynamic> data) {
    return Leader(
      id: id,
      correo: data['correo'] ?? '',
      nombre: data['nombres'] ?? '',
      rol: data['rol'] ?? '',
      rol2: data['rol2'] ?? '',
      password: data['password'] ?? '',
      apellidos: data['apellidos'] ?? '',
      tipoDocumento: data['tipo documento'] ?? '',
      numeroDocumento: data['numero documento'] ?? '',
      nacionalidad: data['nacionalidad'] ?? '',
      edad: data['edad'] ?? '',
      telefono: data['telefono'] ?? '',
      departamento: data['departamento'] ?? '',
      municipio: data['municipio'] ?? '',
      comuna: data['comuna'] ?? '',
      barrio: data['barrio'] ?? '',
      direccion: data['direccion'] ?? '',
      areaDeInfluencia: data['area de influencia'] ?? '',
      nivelDePoder: data['nivel de poder'] ?? '',
      nivelDeParticipacion: data['nivel de participacion'] ?? '',
      categoria: data['categoria'] ?? '',
    );
  }
}




// class User {
//   String id;
//   String correo;
//   String nombre;
//   String rol;
//   String password;

//   User(
//       {required this.id,
//       required this.correo,
//       required this.nombre,
//       required this.rol,
//       required this.password});

//   factory User.desdeDoc(String id, Map<String, dynamic> data) {
//     return User(
//         id: id,
//         correo: data['correo'] ?? '',
//         nombre: data['nombres'] ?? '',
//         rol: data['rol'] ?? '',
//         password: data['password'] ?? '');
//   }

  // User.fromMap(String id, Map<String, dynamic> map)
  //     : id = id,
  //       correo = map['correo'],
  //       cedula = map['cedula'],
  //       nombre = map['nombre'],
  //       rol = map['rol'],
  //       password = map['password'];

  // Map<String, dynamic> toMap() {
  //   return {'correo': correo, 'nombre': nombre, 'cedula': cedula, 'rol': rol};
  // }
//}
