import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:sivigila/Admin/controllers/controlPerfil.dart';
import 'package:sivigila/Admin/controllers/storage_pass.dart';
import 'package:sivigila/Admin/controllers/userController.dart';
import 'package:sivigila/Admin/data/services/userServices.dart';
import 'package:sivigila/Models/user.dart';

class Registro extends StatefulWidget {
  const Registro({super.key});

  @override
  State<Registro> createState() => _RegistroState();
}

class _RegistroState extends State<Registro> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  //lo que sea
  @override
  Widget build(BuildContext context) {
    return const UsuarioListScreen();
  }
}

class UsuarioListScreen extends StatefulWidget {
  const UsuarioListScreen({super.key});
  @override
  State<UsuarioListScreen> createState() => _UsuarioListScreenState();
}

class _UsuarioListScreenState extends State<UsuarioListScreen> {
  List<Usuarios> administradores = [];
  List<Leader> lideres = [];
  List<Usuarios> referentes = [];
  ControlUserAuth cp = Get.find();

  @override
  void initState() {
    super.initState();
    cp.consultarUsuarios();
    _fetchUsuarios();
    print(cp.listaUsuarios);
  }

  Future<void> _fetchUsuarios() async {
    try {
      // Usa la lista de usuarios desde ControlUserAuth
      cp.consultarUsuarios();
      List<dynamic> usuarios = cp.listaUsuarios!;

      List<Usuarios> adminList = [];
      List<Leader> leaderList = [];
      List<Usuarios> referentList = [];

      for (var usuario in usuarios) {
        if (usuario.rol == 'Admin') {
          adminList.add(usuario);
        } else if (usuario.rol == 'Lider' && usuario is Leader) {
          // Asegúrate de que el usuario es del tipo Leader
          leaderList.add(usuario);
        } else {
          referentList.add(usuario);
        }
      }

      setState(() {
        administradores = adminList;
        lideres = leaderList;
        referentes = referentList;
      });
    } catch (e) {
      print("Error al obtener usuarios: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Registro de Usuarios",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Text(
              "Administradores",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent),
            ),
          ),
          ...administradores.map((usuario) => ListTile(
                leading: const Icon(Icons.person, color: Colors.blueAccent),
                title: Text(
                  FirebaseAuth.instance.currentUser!.email == usuario.correo
                      ? "${usuario.nombre} (YO)"
                      : usuario.nombre,
                  style: const TextStyle(fontSize: 16),
                ),
                tileColor: Colors.blue[50],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                onTap: () => _showUserOptions(context, usuario, 'Admin'),
              )),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Text(
              "Líderes",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
            ),
          ),
          ...lideres.map((usuario) => ListTile(
                leading: const Icon(Icons.group, color: Colors.green),
                title: Text(
                  usuario.nombre,
                  style: const TextStyle(fontSize: 16),
                ),
                tileColor: Colors.green[50],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                onTap: () => _showUserOptions(context, usuario, 'Lider'),
              )),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Text(
              "Referentes",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange),
            ),
          ),
          ...referentes.map((usuario) => ListTile(
                leading: const Icon(Icons.person, color: Colors.orange),
                title: Text(
                  usuario.nombre,
                  style: const TextStyle(fontSize: 16),
                ),
                tileColor: Colors.blue[50],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                onTap: () => _showUserOptions(context, usuario, 'Referente'),
              )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const RegistroUsuarios(),
            ),
          );
        },
        child: const Icon(Icons.add, size: 30),
      ),
    );
  }

  void _navigateToRegistroUsuarios(dynamic usuario, String rol) async {
    // Espera el resultado de la navegación
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RegistroUsuarios(usuario: usuario, rol: rol),
      ),
    );

    // Si se realizó un cambio, refresca la lista de usuarios
    if (result == true) {
      _fetchUsuarios();
      cp.consultarUsuarios();
    }
  }

  void _xd2(Usuarios usuario, String rol) async {
    Navigator.pop(context);
    FirebaseAuth auth = FirebaseAuth.instance;
    const _storage = FlutterSecureStorage();
    String emailAdmin = auth.currentUser!.email!;
    String? passAdmin = await _storage.read(key: 'adminPassword');
    try {
      auth.signOut();
      await auth.signInWithEmailAndPassword(
          email: usuario.correo, password: usuario.password);

      User? currentUser = auth.currentUser;
      if (currentUser != null) {
        await currentUser.delete();
      }
      await Userservices.eliminarPerfil(usuario.id);
      await auth.signInWithEmailAndPassword(
          email: emailAdmin, password: passAdmin!);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("${usuario.nombre} eliminado"),
          backgroundColor: Colors.redAccent,
        ),
      );
      setState(() {
        if (rol == 'Admin') {
          administradores.remove(usuario);
        } else if (rol == 'Lider') {
          lideres.remove(usuario);
        } else {
          referentes.remove(usuario);
        }
      });

      print("EMAIL ADMIN : ${emailAdmin} CONTRA ADMIN: ${passAdmin}");
    } catch (e) {
      print("Error al eliminar usuario: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Error al eliminar usuario"),
          backgroundColor: Colors.redAccent,
        ),
      );

      try {
        await auth.signInWithEmailAndPassword(
            email: emailAdmin, password: passAdmin!);
      } catch (e) {
        print("Error al volver a iniciar sesión como administrador: $e");
      }
    }
  }

  Future<bool> mostrarMensajeAdvertencia(
      BuildContext context, String nombreUsuario) async {
    return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              title: const Text(
                "Confirmación de Eliminación",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                ),
              ),
              content: Text(
                "¿Estás seguro de que deseas eliminar a $nombreUsuario? Esta acción no se puede deshacer.",
                style: const TextStyle(fontSize: 16),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false); // Retorna "No"
                  },
                  child: const Text(
                    "Cancelar",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context, true); // Retorna "Sí"
                  },
                  child: const Text(
                    "Eliminar",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            );
          },
        ) ??
        false; // Devuelve "false" si el cuadro de diálogo se cierra de alguna otra manera
  }

  void _showUserOptions(BuildContext context, Usuarios usuario, String rol) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Colors.grey[100],
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Opciones para ${usuario.nombre} ($rol)",
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
              ListTile(
                leading: const Icon(Icons.edit, color: Colors.blue),
                title: const Text("Editar Usuario"),
                onTap: () {
                  Navigator.pop(context);
                  if (usuario is Leader) {
                    _navigateToRegistroUsuarios(usuario, rol);
                  } else {
                    _navigateToRegistroUsuarios(usuario, rol);
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.redAccent),
                title: const Text("Eliminar Usuario"),
                onTap: () async {
                  bool confirmacion =
                      await mostrarMensajeAdvertencia(context, usuario.nombre);
                  // ignore: unrelated_type_equality_checks
                  if (confirmacion) {
                    if (usuario is Leader) {
                      _xd2(usuario, rol);
                    } else {
                      _xd2(usuario, rol);
                    }
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class RegistroUsuarios extends StatefulWidget {
  final Usuarios? usuario;
  final String? rol;
  const RegistroUsuarios({super.key, this.usuario, this.rol});

  @override
  _RegistroUsuariosState createState() => _RegistroUsuariosState();
}

class _RegistroUsuariosState extends State<RegistroUsuarios> {
  // Lista de roles disponibles

  bool _nameError = false;
  bool _surnameError = false;
  bool _documentTypeError = false;
  bool _documentNumberError = false;
  bool _nationalityError = false;
  bool _ageError = false;
  bool _phoneError = false;
  bool _departmentError = false;
  bool _municipalityError = false;
  bool _comunaError = false;
  bool _barrioError = false;
  bool _addressError = false;
  bool _categoryError = false;
  bool _roleError = false;
  bool _influenceAreaError = false;
  bool _powerLevelError = false;
  bool _participationLevelError = false;
  bool _emailError = false;
  bool _passwordError = false;
  bool _confirmPasswordError = false;

  final List<String> roles = ['Lider', 'Admin', 'Referente'];
  String _selectedRole = 'Lider';
  ControlUserAuth cp = Get.find();

  final _adminNameController = TextEditingController();
  final _adminEmailController = TextEditingController();
  final _adminPasswordController = TextEditingController();
  final _adminConfirmPasswordController = TextEditingController();

  final _referenteNameController = TextEditingController();
  final _referenteEmailController = TextEditingController();
  final _referentePasswordController = TextEditingController();
  final _referenteConfirmPasswordController = TextEditingController();

  final _leaderNameController = TextEditingController();
  final _leaderSurnameController = TextEditingController();
  final _leaderDocumentTypeController = TextEditingController();
  final _leaderDocumentNumberController = TextEditingController();
  final _leaderNationalityController = TextEditingController();
  final _leaderAgeController = TextEditingController();
  final _leaderPhoneController = TextEditingController();
  final _leaderDepartmentController = TextEditingController();
  final _leaderMunicipalityController = TextEditingController();
  final _leaderComunaController = TextEditingController();
  final _leaderBarrioController = TextEditingController();
  final _leaderAddressController = TextEditingController();
  final _leaderEmailController = TextEditingController();
  final _leaderPasswordController = TextEditingController();
  final _leaderConfirmPasswordController = TextEditingController();

  String _selectedAreaOfInfluence = 'Cabecera municipal';
  String _selectedPowerLevel = 'Bajo';
  String _selectedParticipationLevel = 'Bajo';
  String _selectedDocumentType = 'CC';

  Map<String, List<String>> _comunasYBarrios = {};
  String? _selectedComuna;
  String? _selectedBarrio;
  List<String> _barriosFiltrados = [];

  Map<String, List<String>> _departmentsAndMunicipalities = {};
  String? _selectedDepartment;
  List<String> _filteredMunicipalities = [];
  String? _selectedMunicipality;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final bool _obscureText = true;

  final List<String> _areasOfInfluence = [
    'Cabecera municipal',
    'Centro de poblado',
    'Rural disperso'
  ];
  final List<String> _powerLevels = ['Bajo', 'Medio', 'Alto'];
  final List<String> _participationLevels = ['Bajo', 'Medio', 'Alto'];
  final List<String> _documentTypes = [
    'CC',
    'TI',
    'CE',
    'RC',
    'PA',
    'MS',
    'AS',
    'CN',
    'PS'
  ];

  final Map<String, List<String>> _rolesOptions = {
    'Vigía Comunitario': [
      'Miembros de colectivos sociales (juveniles, mujeres, adulto mayor, deporte, cultura, LGBTIQ+, entre otros).',
      'Miembros Juntas de Acción Comunal.',
      'Líderes ambientales o animalistas.',
      'Tenderos.',
      'Transportadores.',
      'Guardas de Seguridad.',
      'Comerciantes.',
      'Parteras',
      'Miembros de la comunidad',
      'Personas vinculadas a servicios de hotelería y turismo.'
    ],
    'Gestor Comunitario': [
      'Docentes.',
      'Regentes de farmacias.',
      'Líderes religiosos.',
      'Líderes de redes de organizaciones cooperantes.',
      'Gestores de entidades gubernamentales que NO realizan acciones de salud.',
      'Personal vinculado a funciones que realizan acciones en comunidad.',
      'Personal vinculado a instituciones de protección integral de la primera infancia.',
      'Personal que ejerce acciones comunitarias mediante proyectos de extensión vinculados a centros educativos.',
      'Personal vinculado a fundaciones que realizan acciones en comunidad.'
    ],
  };

  String? _selectRole;
  String? _selectedOption;
  List<String> _rolesFiltrados = [];
  List<String> obtenerRol() {
    return _rolesOptions[_selectRole] ?? [];
  }

  @override
  void initState() {
    super.initState();
    if (widget.rol != null && roles.contains(widget.rol)) {
      _selectedRole = widget.rol!;
    }
    _loadComunasYBarrios();
    _loadDepartmentsAndMunicipalities();

    if (widget.usuario != null) {
      _initializeUserData();
    }
  }

  void _initializeUserData() async {
    final user = widget.usuario!;
    _selectedRole = widget.rol ?? 'Líder';

    if (user.rol == 'Admin') {
      _adminNameController.text = user.nombre;
      _adminEmailController.text = user.correo;
      _adminPasswordController.text = user.password;
      _adminConfirmPasswordController.text = user.password;
    }

    if (user.rol == 'Referente') {
      _referenteNameController.text = user.nombre;
      _referenteEmailController.text = user.correo;
      _referentePasswordController.text = user.password;
      _referenteConfirmPasswordController.text = user.password;
    }

    if (user is Leader) {
      _leaderNameController.text = user.nombre;
      _leaderSurnameController.text = user.apellidos;
      _leaderDocumentTypeController.text = user.tipoDocumento;
      _leaderDocumentNumberController.text = user.numeroDocumento;
      _leaderNationalityController.text = user.nacionalidad;
      _leaderAgeController.text = user.edad;
      _leaderPhoneController.text = user.telefono;
      _leaderEmailController.text = user.correo;
      _leaderPasswordController.text = user.password;
      _leaderAddressController.text = user.direccion;
      _leaderConfirmPasswordController.text = user.password;

      await _loadComunasYBarrios();
      await _loadDepartmentsAndMunicipalities();

      // Usa setState para actualizar las listas dependientes
      setState(() {
        // Departamento y Municipio
        _selectedDepartment = user.departamento;

        if (_departmentsAndMunicipalities.containsKey(_selectedDepartment)) {
          _filteredMunicipalities =
              _departmentsAndMunicipalities[_selectedDepartment]!;
        } else {
          _filteredMunicipalities = [];
          _selectedDepartment = null;
        }
        _selectedMunicipality = _filteredMunicipalities.contains(user.municipio)
            ? user.municipio
            : null;

        // Comuna y Barrio
        _selectedComuna = user.comuna;
        if (_comunasYBarrios.containsKey(_selectedComuna)) {
          _barriosFiltrados = _comunasYBarrios[_selectedComuna]!;
        } else {
          _barriosFiltrados = [];
          _selectedComuna = null;
        }
        _selectedBarrio =
            _barriosFiltrados.contains(user.barrio) ? user.barrio : null;

        // Categoría y Rol2
        _selectedOption = user.categoria;
        if (_rolesOptions.containsKey(_selectedOption)) {
          _rolesFiltrados = _rolesOptions[_selectedOption]!;
        } else {
          _rolesFiltrados = [];
          _selectedOption = null;
        }
        _selectRole = _rolesFiltrados.contains(user.rol2) ? user.rol2 : null;
      });
    }
  }

  Future<void> _guardarOactualizar() async {
  if (_selectedRole == 'Admin') {
    _registerAdmin();
  } else if (_selectedRole == 'Lider') {
    _registerLeader();
  } else {
    _registerReferen();
  }
}


  void loadCategoriasRoles() {
    setState(() {
      _rolesOptions
          .map((key, value) => MapEntry(key, List<String>.from(value)));
    });
  }

  Future<void> _loadComunasYBarrios() async {
    final String jsonString =
        await rootBundle.loadString('assets/Comunas_y_Barrios_Valledupar.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonString);

    setState(() {
      _comunasYBarrios =
          jsonMap.map((key, value) => MapEntry(key, List<String>.from(value)));
    });
  }

  Future<void> _loadDepartmentsAndMunicipalities() async {
    final String jsonString =
        await rootBundle.loadString('assets/departamentos_municipios.json');
    final List<dynamic> jsonList = json.decode(jsonString);

    Map<String, List<String>> departmentsAndMunicipalities = {};
    for (var item in jsonList) {
      String department = item['departamento'];
      String municipality = item['municipio'];

      // Filtrar solo el departamento del Cesar
      if (department == 'Cesar') {
        if (!departmentsAndMunicipalities.containsKey(department)) {
          departmentsAndMunicipalities[department] = [];
        }
        departmentsAndMunicipalities[department]!.add(municipality);
      }
    }
    departmentsAndMunicipalities.forEach((key, value) {
      value.sort();
    });

    setState(() {
      _departmentsAndMunicipalities = departmentsAndMunicipalities;
    });
  }
void _showErrorDialog(String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Error de Validación'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('Cerrar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
void _highlightField(TextEditingController controller) {
  setState(() {
    controller.text = controller.text; // Refresca el estado del campo
  });
}

//Registro de admin
  void _registerAdmin() async {
  String nombres = _adminNameController.text.trim();
  String email = _adminEmailController.text.trim();
  String password = _adminPasswordController.text;
  String confirmPassword = _adminConfirmPasswordController.text;

  setState(() {
    _nameError = false;
    _emailError = false;
    _passwordError = false;
    _confirmPasswordError = false;
  });

  String errorMessage = '';

  // Validación de nombres
  if (nombres.isEmpty || nombres.length < 1 || nombres.length > 50) {
    setState(() {
      _nameError = true;
    });
    errorMessage += 'El nombre debe tener entre 1 y 50 caracteres.\n';
  }

  // Validación de correo
  RegExp emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
  if (!emailRegex.hasMatch(email)) {
    setState(() {
      _emailError = true;
    });
    errorMessage += 'El correo debe tener un formato válido.\n';
  }

  // Validación de contraseña
  if (password.isEmpty || password.length < 4 || password.length > 8) {
    setState(() {
      _passwordError = true;
    });
    errorMessage += 'La contraseña debe tener entre 4 y 8 caracteres.\n';
  }

  // Validación de confirmación de contraseña
  if (password != confirmPassword) {
    setState(() {
      _confirmPasswordError = true;
    });
    errorMessage += 'Las contraseñas no coinciden.\n';
  }

  // Mostrar errores si existen
  if (errorMessage.isNotEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(errorMessage.trim())),
    );
    return;
  }

  // Si todo es válido, realiza el registro o actualización
  try {
    var datos = {
      "correo": email,
      "rol": "Admin",
      "nombres": nombres,
      "password": password,
    };

    if (widget.usuario == null) {
      createNewUser(email, password, datos);
      cp.consultarUsuarios();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Admin creado exitosamente')),
      );
    } else {
      Userservices.actualizarPerfil(widget.usuario!.id, datos);
      cp.consultarUsuarios();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Admin editado exitosamente')),
      );
      Navigator.pop(context, true);
    }
  } catch (e) {
    print(e);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Error al crear admin')),
    );
  }
}



//Registro de Referente
  void _registerReferen() async {
  String nombres = _referenteNameController.text.trim();
  String email = _referenteEmailController.text.trim();
  String password = _referentePasswordController.text;
  String confirmPassword = _referenteConfirmPasswordController.text;

  setState(() {
    // Reiniciar los errores
    _nameError = false;
    _emailError = false;
    _passwordError = false;
    _confirmPasswordError = false;
  });

  // Validación de nombres
  if (nombres.isEmpty || nombres.length < 1 || nombres.length > 50) {
    setState(() {
      _nameError = true;
    });
    _showErrorDialog('El nombre debe tener entre 1 y 50 caracteres');
    return;
  }

  // Validación de correo
  RegExp emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
  if (!emailRegex.hasMatch(email)) {
    setState(() {
      _emailError = true;
    });
    _showErrorDialog('El correo debe tener un formato válido');
    return;
  }

  // Validación de contraseña
  if (password.isEmpty || password.length < 4 || password.length > 8) {
    setState(() {
      _passwordError = true;
    });
    _showErrorDialog('La contraseña debe tener entre 4 y 8 caracteres');
    return;
  }

  // Validación de confirmación de contraseña
  if (password != confirmPassword) {
    setState(() {
      _confirmPasswordError = true;
    });
    _showErrorDialog('Las contraseñas no coinciden');
    return;
  }

  // Si todas las validaciones pasan, realizar el registro o actualización
  try {
    var datos = {
      "correo": email,
      "rol": "Referente",
      "nombres": nombres,
      "password": password,
    };

    if (widget.usuario == null) {
      createNewUser(email, password, datos);
      cp.consultarUsuarios();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Referente creado exitosamente')),
      );
    } else {
      Userservices.actualizarPerfil(widget.usuario!.id, datos);
      cp.consultarUsuarios();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Referente editado exitosamente')),
      );
      Navigator.pop(context, true);
    }
    print("correo final: ${_auth.currentUser!.email}");
  } catch (e) {
    print(e);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Error al crear referente')),
    );
  }
}


//Registro de lider
  void _registerLeader() async {
  String nombres = _leaderNameController.text.trim();
  String apellidos = _leaderSurnameController.text.trim();
  String tipoDocumento = _selectedDocumentType ?? '';
  String numeroDocumento = _leaderDocumentNumberController.text.trim();
  String nacionalidad = _leaderNationalityController.text.trim();
  String edad = _leaderAgeController.text.trim();
  String telefono = _leaderPhoneController.text.trim();
  String departamento = _selectedDepartment ?? '';
  String municipio = _selectedMunicipality ?? '';
  String comuna = _selectedComuna ?? '';
  String barrio = _selectedBarrio ?? '';
  String direccion = _leaderAddressController.text.trim();
  String area = _selectedAreaOfInfluence ?? '';
  String poder = _selectedPowerLevel ?? '';
  String participacion = _selectedParticipationLevel ?? '';
  String email = _leaderEmailController.text.trim();
  String password = _leaderPasswordController.text;
  String confirmPassword = _leaderConfirmPasswordController.text;

  // Reset de errores
  ScaffoldMessenger.of(context).clearSnackBars();

  // Validaciones específicas
  if (nombres.isEmpty || nombres.length < 1 || nombres.length > 50) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('El nombre debe tener entre 1 y 50 caracteres')),
    );
    return;
  }

  if (apellidos.isEmpty || apellidos.length < 1 || apellidos.length > 50) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('El apellido debe tener entre 1 y 50 caracteres')),
    );
    return;
  }

  if (tipoDocumento.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Debe seleccionar un tipo de documento')),
    );
    return;
  }

  if (numeroDocumento.isEmpty || numeroDocumento.length < 5 || numeroDocumento.length > 20) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('El número de documento debe tener entre 5 y 20 caracteres')),
    );
    return;
  }

  if (nacionalidad.isEmpty || nacionalidad.length < 3 || nacionalidad.length > 30) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('La nacionalidad debe tener entre 3 y 30 caracteres')),
    );
    return;
  }

  if (edad.isEmpty || int.tryParse(edad) == null || int.parse(edad) < 18 || int.parse(edad) > 100) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('La edad debe ser un número entre 18 y 100')),
    );
    return;
  }

  if (telefono.isEmpty || telefono.length < 7 || telefono.length > 15) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('El teléfono debe tener entre 7 y 15 caracteres')),
    );
    return;
  }

  if (departamento.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Debe seleccionar un departamento')),
    );
    return;
  }

  if (municipio.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Debe seleccionar un municipio')),
    );
    return;
  }

  if (direccion.isEmpty || direccion.length < 5 || direccion.length > 100) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('La dirección debe tener entre 5 y 100 caracteres')),
    );
    return;
  }

  if (area.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Debe seleccionar un área de influencia')),
    );
    return;
  }

  if (poder.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Debe seleccionar un nivel de poder')),
    );
    return;
  }

  if (participacion.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Debe seleccionar un nivel de participación')),
    );
    return;
  }

  RegExp emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
  if (email.isEmpty || !emailRegex.hasMatch(email)) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Debe proporcionar un correo válido')),
    );
    return;
  }

  if (password.isEmpty || password.length < 4 || password.length > 8) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('La contraseña debe tener entre 4 y 8 caracteres')),
    );
    return;
  }

  if (password != confirmPassword) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Las contraseñas no coinciden')),
    );
    return;
  }

  // Si todo es válido, realiza el registro o actualización
  try {
    var datos = {
      "nombres": nombres,
      "apellidos": apellidos,
      "tipo documento": tipoDocumento,
      "numero documento": numeroDocumento,
      "nacionalidad": nacionalidad,
      "edad": edad,
      "telefono": telefono,
      "departamento": departamento,
      "municipio": municipio,
      "comuna": comuna,
      "barrio": barrio,
      "direccion": direccion,
      "categoria": _selectedOption!,
      "rol2": _selectRole!,
      "area de influencia": area,
      "nivel de poder": poder,
      "nivel de participacion": participacion,
      "correo": email,
      "rol": "Lider",
      "password": password,
    };

    if (widget.usuario == null) {
      await createNewUser(email, password, datos);
      cp.consultarUsuarios();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Líder creado exitosamente')),
      );
    } else {
      await Userservices.actualizarPerfil(widget.usuario!.id, datos);
      cp.consultarUsuarios();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Líder editado exitosamente')),
      );
      Navigator.pop(context, true);
    }
  } catch (e) {
    print(e);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Error al crear líder')),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.usuario != null ? 'Editar Usuario' : 'Crear Usuario',
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.blueAccent),
        elevation: 0, // Quita la sombra para un diseño plano
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Selección de Rol
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blueAccent, width: 1),
              ),
              child: DropdownButton<String>(
                isExpanded: true,
                underline: const SizedBox(), // Quita la línea inferior
                borderRadius: BorderRadius.circular(15),
                value: _selectedRole,
                items: roles.map((String role) {
                  return DropdownMenuItem<String>(
                    value: role,
                    child: Text(
                      role,
                      style: const TextStyle(color: Colors.blueAccent),
                    ),
                  );
                }).toList(),
                onChanged: widget.usuario == null
                    ? (value) {
                        setState(() {
                          _selectedRole = value!;
                        });
                      }
                    : null,
              ),
            ),
            const SizedBox(height: 20),

            // Formulario según el rol seleccionado
            if (_selectedRole == 'Admin')
              _buildAdminForm()
            else if (_selectedRole == 'Lider')
              _buildLeaderForm()
            else
              _builReferenForm(),
            const SizedBox(height: 20),

            // Botón de Registro
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _guardarOactualizar,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  widget.usuario != null
                      ? 'Guardar cambios'
                      : 'Registrar $_selectedRole',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

// Formulario de Admin
Widget _buildAdminForm() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: Text(
          "Información del Administrador",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent),
        ),
      ),
      const SizedBox(height: 10),

      // Campo de Nombres
      _buildStyledTextField(
        _adminNameController, 
        'Nombres', 
        Icons.person, 
        _nameError, // Variable de error para nombres
      ),

      const SizedBox(height: 15),

      // Campo de Correo
      _buildStyledTextField(
        _adminEmailController, 
        'Correo', 
        Icons.email, 
        _emailError, // Variable de error para correo
      ),

      const SizedBox(height: 15),

      // Campo de Contraseña
      _buildStyledPasswordField(
        _adminPasswordController, 
        'Contraseña', 
        Icons.lock, 
        hasError: _passwordError, // Variable de error para contraseña
      ),

      const SizedBox(height: 15),

      // Campo de Confirmación de Contraseña
      _buildStyledPasswordField(
        _adminConfirmPasswordController, 
        'Confirmar Contraseña', 
        Icons.lock_outline, 
        hasError: _confirmPasswordError, // Variable de error para confirmación
      ),
    ],
  );
}


// Formulario de Referente
  Widget _builReferenForm() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: Text(
          "Información del Referente",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent),
        ),
      ),
      const SizedBox(height: 10),

      // Campo de Nombres
      _buildStyledTextField(
        _referenteNameController, 
        'Nombres', 
        Icons.person, 
        _nameError,
      ),

      const SizedBox(height: 15),

      // Campo de Correo
      _buildStyledTextField(
        _referenteEmailController, 
        'Correo', 
        Icons.email, 
        _emailError,
      ),

      const SizedBox(height: 15),

      // Campo de Contraseña
      _buildStyledPasswordField(
        _referentePasswordController, 
        'Contraseña', 
        Icons.lock, 
        hasError: _passwordError,
      ),

      const SizedBox(height: 15),

      // Campo de Confirmación de Contraseña
      _buildStyledPasswordField(
        _referenteConfirmPasswordController, 
        'Confirmar Contraseña', 
        Icons.lock_outline, 
        hasError: _confirmPasswordError,
      ),
    ],
  );
}


//Formulario lider
 Widget _buildLeaderForm() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionTitle('Información Personal'),
      _buildStyledTextField(
        _leaderNameController, 
        'Nombres', 
        Icons.person, 
        _nameError, // Maneja el error de nombre
      ),
      const SizedBox(height: 15),
      _buildStyledTextField(
        _leaderSurnameController, 
        'Apellidos', 
        Icons.person_outline, 
        _surnameError, // Maneja el error de apellido
      ),
      const SizedBox(height: 15),
      _buildStyledDropdownField(
        'Tipo de documento',
        _documentTypes,
        _selectedDocumentType,
        (String? value) {
          setState(() {
            _selectedDocumentType = value!;
          });
        },
        _documentTypeError, // Maneja el error de tipo de documento
        Icons.article,
      ),
      const SizedBox(height: 15),
      _buildStyledTextField(
        _leaderDocumentNumberController,
        'Número de documento',
        Icons.badge,
        _documentNumberError, // Maneja el error de número de documento
      ),
      const SizedBox(height: 15),
      _buildStyledTextField(
        _leaderNationalityController, 
        'Nacionalidad', 
        Icons.public, 
        _nationalityError, // Maneja el error de nacionalidad
      ),
      const SizedBox(height: 15),
      _buildStyledTextField(
        _leaderAgeController, 
        'Edad', 
        Icons.calendar_today, 
        _ageError, // Maneja el error de edad
        keyboardType: TextInputType.number,
      ),
      const SizedBox(height: 15),
      _buildStyledTextField(
        _leaderPhoneController, 
        'Teléfono', 
        Icons.phone, 
        _phoneError, // Maneja el error de teléfono
        keyboardType: TextInputType.phone,
      ),
      const SizedBox(height: 20),
      _buildSectionTitle('Información de Residencia'),
      const SizedBox(height: 10),
      _buildStyledDropdownField(
        'Departamento',
        _departmentsAndMunicipalities.keys.toList(),
        _selectedDepartment,
        (String? newValue) {
          setState(() {
            _selectedDepartment = newValue;
            _filteredMunicipalities =
                _departmentsAndMunicipalities[_selectedDepartment] ?? [];
            _selectedMunicipality = null;
          });
        },
        _departmentError, // Maneja el error de departamento
        Icons.location_city,
      ),
      const SizedBox(height: 15),
      _buildStyledDropdownField(
        'Municipio',
        _filteredMunicipalities,
        _selectedMunicipality,
        (String? newValue) {
          setState(() {
            _selectedMunicipality = newValue;
          });
        },
        _municipalityError, // Maneja el error de municipio
        Icons.location_on,
      ),
      const SizedBox(height: 15),
      _buildStyledDropdownField(
        'Comuna',
        _comunasYBarrios.keys.toList(),
        _selectedComuna,
        (String? newValue) {
          setState(() {
            _selectedComuna = newValue;
            _barriosFiltrados = _comunasYBarrios[_selectedComuna] ?? [];
            _selectedBarrio = null;
          });
        },
        _comunaError, // Maneja el error de comuna
        Icons.home,
      ),
      const SizedBox(height: 15),
      _buildStyledDropdownField(
        'Barrio',
        _barriosFiltrados,
        _selectedBarrio,
        (String? newValue) {
          setState(() {
            _selectedBarrio = newValue;
          });
        },
        _barrioError, // Maneja el error de barrio
        Icons.home_outlined,
      ),
      const SizedBox(height: 15),
      _buildStyledTextField(
        _leaderAddressController, 
        'Dirección de residencia', 
        Icons.map, 
        _addressError, // Maneja el error de dirección
      ),
      const SizedBox(height: 20),
      _buildSectionTitle('Áreas de Influencia y Participación'),
      //
      const SizedBox(height: 15),
      _buildStyledDropdownField(
        'Categoria',
        _rolesOptions.keys.toList(),
        _selectedOption,
        (String? value) {
          setState(() {
            _selectedOption = value;
            _rolesFiltrados = _rolesOptions[_selectedOption] ?? [];
            _selectRole = null;
          });
        },
        _categoryError, // Maneja el error de categoría
        Icons.category,
      ),
      const SizedBox(height: 15),
      _buildStyledDropdownField(
        'Rol',
        _rolesFiltrados,
        _selectRole,
        (String? value) {
          setState(() {
            _selectRole = value;
          });
        },
        _roleError, // Maneja el error de rol
        Icons.contact_emergency_rounded,
      ),
      const SizedBox(height: 15),
      _buildStyledDropdownField(
        'Área de influencia',
        _areasOfInfluence,
        _selectedAreaOfInfluence,
        (String? value) {
          setState(() {
            _selectedAreaOfInfluence = value!;
          });
        },
        _influenceAreaError, // Maneja el error de área de influencia
        Icons.info,
      ),
      const SizedBox(height: 15),
      _buildStyledDropdownField(
        'Nivel de poder',
        _powerLevels,
        _selectedPowerLevel,
        (String? value) {
          setState(() {
            _selectedPowerLevel = value!;
          });
        },
        _powerLevelError, // Maneja el error de nivel de poder
        Icons.leaderboard,
      ),
      const SizedBox(height: 15),
      _buildStyledDropdownField(
        'Nivel de participación',
        _participationLevels,
        _selectedParticipationLevel,
        (String? value) {
          setState(() {
            _selectedParticipationLevel = value!;
          });
        },
        _participationLevelError, // Maneja el error de nivel de participación
        Icons.group,
      ),
      _buildSectionTitle('Datos de Ingreso'),
      _buildStyledTextField(
        _leaderEmailController, 
        'Correo', 
        Icons.email, 
        _emailError, // Maneja el error de correo
      ),
      const SizedBox(height: 15),
      _buildStyledPasswordField(
        _leaderPasswordController, 
        'Contraseña', 
        Icons.lock, 
        hasError: _passwordError, // Maneja el error de contraseña
      ),
      const SizedBox(height: 15),
      _buildStyledPasswordField(
        _leaderConfirmPasswordController,
        'Confirmar contraseña',
        Icons.lock_outline,
        hasError: _confirmPasswordError, // Maneja el error de confirmación de contraseña
      ),
    ],
  );
}

//
  Widget _buildStyledTextField(
  TextEditingController controller,
  String label,
  IconData icon,
  bool hasError, // Parámetro obligatorio para validar errores
  {TextInputType keyboardType = TextInputType.text}) {
  return TextField(
    controller: controller,
    keyboardType: keyboardType,
    decoration: InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.blueAccent),
      filled: true,
      fillColor: Colors.blue[50],
      prefixIcon: Icon(icon, color: Colors.blueAccent),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: hasError ? Colors.red : Colors.blueAccent,
          width: 2.0,
        ),
      ),
      errorText: hasError ? 'Campo inválido' : null,
    ),
  );
}




//
  Widget _buildStyledPasswordField(
  TextEditingController controller,
  String label,
  IconData icon, {
  bool hasError = false, // Parámetro opcional con valor predeterminado
  bool oscuro = true,
}) {
  return StatefulBuilder(
    builder: (context, setState) {
      return TextField(
        controller: controller,
        obscureText: oscuro,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.blueAccent),
          filled: true,
          fillColor: Colors.blue[50],
          prefixIcon: Icon(icon, color: Colors.blueAccent),
          suffixIcon: IconButton(
            icon: Icon(
              oscuro ? Icons.visibility_off : Icons.visibility,
              color: Colors.blueAccent,
            ),
            onPressed: () {
              setState(() {
                oscuro = !oscuro;
              });
            },
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: hasError ? Colors.red : Colors.blueAccent,
              width: 2.0,
            ),
          ),
          errorText: hasError ? 'Campo inválido' : null,
        ),
      );
    },
  );
}

//
  Widget _buildStyledDropdownField(
    String label, List<String> items, String? selectedItem, ValueChanged<String?> onChanged, bool hasError, IconData icon) {
  return DropdownButtonFormField<String>(
    decoration: InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.blueAccent),
      filled: true,
      fillColor: Colors.blue[50],
      prefixIcon: Icon(icon, color: Colors.blueAccent),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: hasError ? Colors.red : Colors.blueAccent,
          width: 2.0,
        ),
      ),
    ),
    value: selectedItem,
    items: items.map((String item) {
      return DropdownMenuItem<String>(
        value: item,
        child: Text(
          item,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      );
    }).toList(),
    onChanged: onChanged,
  );
}



  Widget buildStyledDropdown({
    required String labelText,
    required String? value,
    required Map<String, List<String>> items,
    required IconData icon,
    required ValueChanged<String?> onChanged,
    required BuildContext context,
  }) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.blueAccent),
        filled: true,
        fillColor: Colors.blue[50],
        prefixIcon: Icon(icon, color: Colors.blueAccent),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      ),
      value: value,
      isExpanded: true,
      items: items.keys.map((String key) {
        return DropdownMenuItem<String>(
          value: key,
          child: Text(
            key,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        );
      }).toList(),
      onChanged: onChanged,
      selectedItemBuilder: (BuildContext context) {
        return items.keys.map((String key) {
          return Text(
            key,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.black),
          );
        }).toList();
      },
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            height: 2,
            width: double.infinity,
            color: Colors.blueAccent.withOpacity(0.6),
          ),
        ],
      ),
    );
  }
}

Future<void> guardarDatosAdicionales(
    User user, Map<String, dynamic> datos) async {
  CollectionReference usuariosCollection =
      FirebaseFirestore.instance.collection('perfiles');
  await usuariosCollection.doc(user.uid).set(datos);
}
