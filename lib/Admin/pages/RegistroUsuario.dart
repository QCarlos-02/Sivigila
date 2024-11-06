import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sivigila/Admin/Widgets/listaDesplegable.dart';
import 'package:sivigila/Admin/controllers/controlPerfil.dart';
import 'package:sivigila/Admin/controllers/storage_pass.dart';
import 'package:sivigila/Admin/data/services/peticionesPerfil.dart';
import 'package:sivigila/Pagina/login_page.dart';

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
    return UsuarioListScreen();
  }
}

class UsuarioListScreen extends StatefulWidget {
  const UsuarioListScreen({super.key});
  @override
  State<UsuarioListScreen> createState() => _UsuarioListScreenState();
}

class _UsuarioListScreenState extends State<UsuarioListScreen> {
  List<String> administradores = [];
  List<String> lideres = [];

  @override
  void initState() {
    super.initState();
    _fetchUsuarios();
  }

  Future<void> _fetchUsuarios() async {
    final CollectionReference perfilesCollection =
        FirebaseFirestore.instance.collection('perfiles');

    try {
      final QuerySnapshot snapshot = await perfilesCollection.get();

      List<String> adminList = [];
      List<String> leaderList = [];

      for (var doc in snapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        final nombre = data['nombres'] ?? 'Sin Nombre';

        if (data['rol'] == 'Admin') {
          adminList.add(nombre);
        } else if (data['rol'] == 'Lider') {
          leaderList.add(nombre);
        }
      }

      setState(() {
        administradores = adminList;
        lideres = leaderList;
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
                  usuario,
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
                  usuario,
                  style: const TextStyle(fontSize: 16),
                ),
                tileColor: Colors.green[50],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                onTap: () => _showUserOptions(context, usuario, 'Lider'),
              )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add, size: 30),
        backgroundColor: Colors.blueAccent,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RegistroUsuarios(),
            ),
          );
        },
      ),
    );
  }

  void _showUserOptions(BuildContext context, String usuario, String rol) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
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
                "Opciones para $usuario ($rol)",
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.redAccent),
                title: const Text("Eliminar Usuario"),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("$usuario eliminado"),
                      backgroundColor: Colors.redAccent,
                    ),
                  );
                  setState(() {
                    if (rol == 'Admin') {
                      administradores.remove(usuario);
                    } else {
                      lideres.remove(usuario);
                    }
                  });
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
  const RegistroUsuarios({super.key});

  @override
  _RegistroUsuariosState createState() => _RegistroUsuariosState();
}

class _RegistroUsuariosState extends State<RegistroUsuarios> {
  String _selectedRole = 'Líder';
  Controlperfil cp = Get.find();

  final _adminNameController = TextEditingController();
  final _adminEmailController = TextEditingController();
  final _adminPasswordController = TextEditingController();
  final _adminConfirmPasswordController = TextEditingController();

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
  bool _obscureText = true;

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
    _loadComunasYBarrios();
    _loadDepartmentsAndMuncipalities();
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

  Future<void> _loadDepartmentsAndMuncipalities() async {
    final String jsonString =
        await rootBundle.loadString('assets/departamentos_municipios.json');
    final List<dynamic> jsonList = json.decode(jsonString);

    Map<String, List<String>> departmentsAndMunicipalities = {};
    for (var item in jsonList) {
      String department = item['departamento'];
      String municipality = item['municipio'];
      if (!departmentsAndMunicipalities.containsKey(department)) {
        departmentsAndMunicipalities[department] = [];
      }
      departmentsAndMunicipalities[department]!.add(municipality);
    }
    departmentsAndMunicipalities.forEach((key, value) {
      value.sort();
    });

    final sortedDepartments = Map.fromEntries(
        departmentsAndMunicipalities.entries.toList()
          ..sort((a, b) => a.key.compareTo(b.key)));

    setState(() {
      _departmentsAndMunicipalities = sortedDepartments;
    });
  }

  void _registerAdmin() async {
    String nombres = _adminNameController.text;
    String email = _adminEmailController.text;
    String password = _adminPasswordController.text;
    String confirmPassword = _adminConfirmPasswordController.text;

    if (password == confirmPassword) {
      try {
        await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        var datos = {
          "correo": email,
          "rol": "Admin",
          "nombres": nombres,
          "password": password,
        };

        guardarDatosAdicionales(FirebaseAuth.instance.currentUser!, datos);

        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Admin creado exitosamente')));
      } catch (e) {
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Error al crear admin')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Las contraseñas no coinciden')));
    }
  }

  void _registerLeader() async {
    String nombres = _leaderNameController.text;
    String apellidos = _leaderSurnameController.text;
    String tipoDocumento = _selectedDocumentType.toString();
    String numeroDocumento = _leaderDocumentNumberController.text;
    String nacionalidad = _leaderNationalityController.text;
    String edad = _leaderAgeController.text;
    String telefono = _leaderPhoneController.text;
    String departamento = _leaderDepartmentController.text;
    String municipio = _leaderMunicipalityController.text;
    String comuna = _selectedComuna ?? '';
    String barrio = _selectedBarrio ?? '';
    String direccion = _leaderAddressController.text;
    String area = _selectedAreaOfInfluence.toString();
    String poder = _selectedPowerLevel.toString();
    String participacion = _selectedParticipationLevel.toString();
    String email = _leaderEmailController.text;
    String password = _leaderPasswordController.text;
    String confirmPassword = _leaderConfirmPasswordController.text;

    if (password == confirmPassword) {
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
          "password": password
        };

        createNewUser(email, password, datos);
        print("correo final: ${_auth.currentUser!.email}");
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Líder creado exitosamente')));
      } catch (e) {
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Error al crear líder')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Las contraseñas no coinciden')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Crear Usuario",
          style: TextStyle(
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
                items: ['Líder', 'Admin'].map((String role) {
                  return DropdownMenuItem<String>(
                    value: role,
                    child: Text(
                      role,
                      style: const TextStyle(color: Colors.blueAccent),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedRole = value!;
                  });
                },
              ),
            ),
            const SizedBox(height: 20),

            // Formulario según el rol seleccionado
            _selectedRole == 'Admin' ? _buildAdminForm() : _buildLeaderForm(),
            const SizedBox(height: 20),

            // Botón de Registro
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed:
                    _selectedRole == 'Admin' ? _registerAdmin : _registerLeader,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Registrar $_selectedRole',
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

//
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
        _buildStyledTextField(_adminNameController, 'Nombres', Icons.person),
        const SizedBox(height: 15),
        _buildStyledTextField(_adminEmailController, 'Correo', Icons.email),
        const SizedBox(height: 15),
        _buildStyledPasswordField(
            _adminPasswordController, 'Contraseña', Icons.lock),
        const SizedBox(height: 15),
        _buildStyledPasswordField(
          _adminConfirmPasswordController,
          'Confirmar Contraseña',
          Icons.lock_outline,
        ),
      ],
    );
  }

//
  Widget _buildStyledTextField(
      TextEditingController controller, String label, IconData icon,
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
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      ),
    );
  }

//
  Widget _buildStyledPasswordField(
      TextEditingController controller, String label, IconData icon,
      {bool oscuro = true}) {
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
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          ),
        );
      },
    );
  }

//
  Widget _buildLeaderForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Información Personal'),
        _buildStyledTextField(_leaderNameController, 'Nombres', Icons.person),
        const SizedBox(height: 15),
        _buildStyledTextField(
            _leaderSurnameController, 'Apellidos', Icons.person_outline),
        const SizedBox(height: 15),
        _buildStyledDropdownField(
            'Tipo de documento', _documentTypes, _selectedDocumentType,
            (String? value) {
          setState(() {
            _selectedDocumentType = value!;
          });
        }, Icons.article),
        const SizedBox(height: 15),
        _buildStyledTextField(_leaderDocumentNumberController,
            'Número de documento', Icons.badge),
        const SizedBox(height: 15),
        _buildStyledTextField(
            _leaderNationalityController, 'Nacionalidad', Icons.public),
        const SizedBox(height: 15),
        _buildStyledTextField(
            _leaderAgeController, 'Edad', Icons.calendar_today,
            keyboardType: TextInputType.number),
        const SizedBox(height: 15),
        _buildStyledTextField(_leaderPhoneController, 'Teléfono', Icons.phone,
            keyboardType: TextInputType.phone),
        const SizedBox(height: 20),
        _buildSectionTitle('Información de Residencia'),
        const SizedBox(height: 10),
        buildStyledDropdown(
          labelText: "Departamento",
          value: _selectedDepartment,
          items: _departmentsAndMunicipalities,
          icon: Icons.location_city,
          onChanged: (String? newValue) {
            setState(() {
              _selectedDepartment = newValue;
              _filteredMunicipalities =
                  _departmentsAndMunicipalities[_selectedDepartment] ?? [];
              _selectedMunicipality = null;
            });
          },
          context: context,
        ),
        const SizedBox(height: 15),
        if (_filteredMunicipalities.isNotEmpty)
          buildStyledDropdown(
            labelText: "Municipio",
            value: _selectedMunicipality,
            items: {for (var i in _filteredMunicipalities) i: []},
            icon: Icons.location_on,
            onChanged: (String? newValue) {
              setState(() {
                _selectedMunicipality = newValue;
              });
            },
            context: context,
          ),
        const SizedBox(height: 15),
        _buildStyledDropdownField(
            'Comuna', _comunasYBarrios.keys.toList(), _selectedComuna,
            (String? newValue) {
          setState(() {
            _selectedComuna = newValue;
            _barriosFiltrados = _comunasYBarrios[_selectedComuna] ?? [];
            _selectedBarrio = null;
          });
        }, Icons.home),
        const SizedBox(height: 15),
        _buildStyledDropdownField('Barrio', _barriosFiltrados, _selectedBarrio,
            (String? newValue) {
          setState(() {
            _selectedBarrio = newValue;
          });
        }, Icons.home_outlined),
        const SizedBox(height: 15),
        _buildStyledTextField(
            _leaderAddressController, 'Dirección de residencia', Icons.map),
        const SizedBox(height: 20),
        _buildSectionTitle('Áreas de Influencia y Participación'),
        //
        const SizedBox(height: 15),
        _buildStyledDropdownField(
            "Categoria", _rolesOptions.keys.toList(), _selectedOption,
            (String? value) {
          setState(() {
            _selectedOption = value;
            _rolesFiltrados = _rolesOptions[_selectedOption] ?? [];
            _selectRole = null;
          });
        }, Icons.category),
        const SizedBox(height: 15),
        _buildStyledDropdownField("Rol", _rolesFiltrados, _selectRole,
            (String? value) {
          setState(() {
            _selectRole = value;
          });
        }, Icons.contact_emergency_rounded),
        const SizedBox(height: 15),
        _buildStyledDropdownField(
            'Área de influencia', _areasOfInfluence, _selectedAreaOfInfluence,
            (String? value) {
          setState(() {
            _selectedAreaOfInfluence = value!;
          });
        }, Icons.info),
        const SizedBox(height: 15),
        _buildStyledDropdownField(
            'Nivel de poder', _powerLevels, _selectedPowerLevel,
            (String? value) {
          setState(() {
            _selectedPowerLevel = value!;
          });
        }, Icons.leaderboard),
        const SizedBox(height: 15),
        _buildStyledDropdownField('Nivel de participación',
            _participationLevels, _selectedParticipationLevel, (String? value) {
          setState(() {
            _selectedParticipationLevel = value!;
          });
        }, Icons.group),
        _buildSectionTitle("Datos de Ingreso"),
        _buildStyledTextField(_leaderEmailController, 'Correo', Icons.email),
        const SizedBox(height: 15),
        _buildStyledPasswordField(
            _leaderPasswordController, 'Contraseña', Icons.lock),
        const SizedBox(height: 15),
        _buildStyledPasswordField(_leaderConfirmPasswordController,
            'Confirmar contraseña', Icons.lock_outline),
      ],
    );
  }

//
  Widget _buildStyledDropdownField(String label, List<String> items,
      String? selectedItem, ValueChanged<String?> onChanged, IconData icon) {
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
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
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
      selectedItemBuilder: (BuildContext context) {
        // Esta propiedad permite personalizar el valor seleccionado
        return items.map((String item) {
          return Container(
            width: MediaQuery.of(context).size.width *
                0.7, // Ajustar el ancho para el valor seleccionado
            child: Text(
              item,

              overflow: TextOverflow
                  .ellipsis, // Muestra "..." si el texto es muy largo
              style: const TextStyle(
                  color: Colors.black), // Estilo para el texto seleccionado
            ),
          );
        }).toList();
      },
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
    double screenWidth = MediaQuery.of(context).size.width;

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
      isExpanded: true, // Hace que el DropdownButton ocupe el ancho completo
      items: items.keys.map((String key) {
        return DropdownMenuItem<String>(
          value: key,
          child: Text(
            key,
            maxLines: 1,
            overflow:
                TextOverflow.ellipsis, // Muestra "..." si el texto es muy largo
          ),
        );
      }).toList(),
      onChanged: onChanged,
      selectedItemBuilder: (BuildContext context) {
        // Personaliza cómo se muestra el valor seleccionado
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
