import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sivigila/Admin/controllers/controlPerfil.dart';
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
  final List<String> usuarios = [
    "Usuario 1",
    "Usuario 2",
    "Usuario 3",
  ];

  // Lista de usuarios registrados
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registro de Usuarios"),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(25),
        itemCount: usuarios.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(usuarios[index]),
            onTap: () {
              // Submenú al seleccionar un usuario
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Opciones para ${usuarios[index]}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        ListTile(
                          leading: const Icon(Icons.delete, color: Colors.red),
                          title: const Text("Eliminar Usuario"),
                          onTap: () {
                            //  Lógica para eliminar usuario

                            Navigator.pop(context); // Cerrar el submenú
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("${usuarios[index]} eliminado"),
                              ),
                            );
                            usuarios.remove(usuarios[index]);
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      // Botón flotante para ir a la ventana de registro
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
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
}

class RegistroUsuarios extends StatefulWidget {
  const RegistroUsuarios({super.key});

  @override
  _RegistroUsuariosState createState() => _RegistroUsuariosState();
}

class _RegistroUsuariosState extends State<RegistroUsuarios> {
  String _selectedRole = 'Líder';
  Controlperfil cp = Get.find();

  // Controllers para los datos del admin
  final _adminEmailController = TextEditingController();
  final _adminPasswordController = TextEditingController();
  final _adminConfirmPasswordController = TextEditingController();

  // Controllers para los datos del líder
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
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _obscureText = true;

  // Listas de selección para algunos campos
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

  void _registerAdmin() async {
    String email = _adminEmailController.text;
    String password = _adminPasswordController.text;
    String confirmPassword = _adminConfirmPasswordController.text;

    if (password == confirmPassword) {
      try {
        await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        var datos = {"correo": email, "rol": "Admin"};
        print(
            "Registro de datos del perfil codigo: ${FirebaseAuth.instance.currentUser!.uid}");
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
    User? currentUser = FirebaseAuth.instance.currentUser;

    String name = _leaderNameController.text;
    String apellidos = _leaderSurnameController.text;
    String tipoDocumento = _selectedDocumentType.toString();
    String numeroDocumento = _leaderDocumentNumberController.text;
    String nacionalidad = _leaderNationalityController.text;
    String edad = _leaderAgeController.text;
    String telefono = _leaderPhoneController.text;
    String departamento = _leaderDepartmentController.text;
    String municipio = _leaderMunicipalityController.text;
    String comuna = _leaderComunaController.text;
    String barrio = _leaderBarrioController.text;
    String direccion = _leaderAddressController.text;
    String area = _selectedAreaOfInfluence.toString();
    String poder = _selectedPowerLevel.toString();
    String participacion = _selectedParticipationLevel.toString();
    String email = _leaderEmailController.text;
    String password = _leaderPasswordController.text;
    String confirmPassword = _leaderConfirmPasswordController.text;

    if (password == confirmPassword) {
      try {
        await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        // Aquí puedes añadir la lógica para guardar "name" y "comuna" en la base de datos
        var datos = {
          "nombres": name,
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
          "area de influencia": area,
          "nivel de poder": poder,
          "nivel de participacion": participacion,
          "correo": email,
          //"contraseña": password,
          "rol": "Lider"
        };
        print(
            "Registro de datos del perfil codigo: ${FirebaseAuth.instance.currentUser!.uid}");
        guardarDatosAdicionales(FirebaseAuth.instance.currentUser!, datos);
        // await _auth.signOut();
        // if (currentUser != null){
        //   await _auth.signInWithEmailAndPassword(email: currentUser.email.toString(), password: GlobalVariables().adminPassword!);
        // }
        print(FirebaseAuth.instance.currentUser!.uid);
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
        title: const Text('Crear Usuario'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              DropdownButton<String>(
                borderRadius: BorderRadius.circular(15),
                value: _selectedRole,
                items: ['Líder', 'Admin'].map((String role) {
                  return DropdownMenuItem<String>(
                    value: role,
                    child: Text(
                      role,
                      textDirection: TextDirection.rtl,
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedRole = value!;
                  });
                },
              ),
              const SizedBox(height: 20),
              _selectedRole == 'Admin' ? _buildAdminForm() : _buildLeaderForm(),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed:
                    _selectedRole == 'Admin' ? _registerAdmin : _registerLeader,
                child: Text('Registrar $_selectedRole'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAdminForm() {
    return Column(
      children: [
        _buildTextField(_adminEmailController, 'Correo'),
        _buildPassword(_adminPasswordController, 'Contraseña'),
        _buildPassword(
          _adminConfirmPasswordController,
          'Confirmar Contraseña',
        ),
      ],
    );
  }

  Widget _buildLeaderForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Información Personal'),
        _buildTextField(_leaderNameController, 'Nombres'),
        _buildTextField(_leaderSurnameController, 'Apellidos'),
        _buildDropdownField(
            'Tipo de documento', _documentTypes, _selectedDocumentType,
            (String? value) {
          setState(() {
            _selectedDocumentType = value!;
          });
        }),
        _buildTextField(_leaderDocumentNumberController, 'Número de documento'),
        _buildTextField(_leaderNationalityController, 'Nacionalidad'),
        _buildTextField(_leaderAgeController, 'Edad',
            keyboardType: TextInputType.number),
        _buildTextField(_leaderPhoneController, 'Teléfono',
            keyboardType: TextInputType.phone),
        const SizedBox(height: 20),
        _buildSectionTitle('Información de Residencia'),
        _buildTextField(_leaderDepartmentController, 'Departamento'),
        _buildTextField(_leaderMunicipalityController, 'Municipio'),
        _buildTextField(_leaderComunaController, 'Localidad o Comuna'),
        _buildTextField(_leaderBarrioController, 'Barrio o Vereda'),
        _buildTextField(_leaderAddressController, 'Dirección de residencia'),
        const SizedBox(height: 20),
        _buildSectionTitle('Áreas de Influencia y Participación'),
        _buildDropdownField(
            'Área de influencia', _areasOfInfluence, _selectedAreaOfInfluence,
            (String? value) {
          setState(() {
            _selectedAreaOfInfluence = value!;
          });
        }),
        _buildDropdownField('Nivel de poder', _powerLevels, _selectedPowerLevel,
            (String? value) {
          setState(() {
            _selectedPowerLevel = value!;
          });
        }),
        _buildDropdownField('Nivel de participación', _participationLevels,
            _selectedParticipationLevel, (String? value) {
          setState(() {
            _selectedParticipationLevel = value!;
          });
        }),
        _buildSectionTitle("Datos de Ingreso"),
        _buildTextField(_leaderEmailController, 'Correo'),
        _buildPassword(
          _leaderPasswordController,
          'Contraseña',
        ),
        _buildPassword(
          _leaderConfirmPasswordController,
          'Confirmar contraseña',
        )
      ],
    );
  }

  Widget _buildPassword(TextEditingController controller, String label) {
    void togglePasswordVisibility() {
      setState(() {
        _obscureText = !_obscureText;
      });
    }

    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: TextField(
          obscureText: _obscureText,
          controller: controller,
          decoration: InputDecoration(
              labelText: label,
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                  onPressed: togglePasswordVisibility,
                  icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility))),
        ));
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {bool obscureText = false,
      TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        obscureText: obscureText,
        keyboardType: keyboardType,
      ),
    );
  }

  Widget _buildDropdownField(String label, List<String> items,
      String selectedItem, ValueChanged<String?> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        value: selectedItem,
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
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
//dshsbc