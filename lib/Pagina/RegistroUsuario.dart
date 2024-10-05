import 'package:flutter/material.dart';

class Registrousuario extends StatefulWidget {
  const Registrousuario({super.key});

  @override
  State<Registrousuario> createState() => _RegistrousuarioState();
}

class _RegistrousuarioState extends State<Registrousuario> {
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

class UsuarioListScreen extends StatelessWidget {
  final List<String> usuarios = [
    "Usuario 1",
    "Usuario 2",
    "Usuario 3",
  ];

  UsuarioListScreen({super.key}); // Lista de usuarios registrados

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
                            // Lógica para eliminar usuario
                            Navigator.pop(context); // Cerrar el submenú
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("${usuarios[index]} eliminado"),
                              ),
                            );
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
              builder: (context) => const RegistroUsuarioScreen(),
            ),
          );
        },
      ),
    );
  }
}

class RegistroUsuarioScreen extends StatefulWidget {
  const RegistroUsuarioScreen({super.key});

  @override
  _RegistroUsuarioScreenState createState() => _RegistroUsuarioScreenState();
}

class _RegistroUsuarioScreenState extends State<RegistroUsuarioScreen> {
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String nombre = '';
  String cc = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Registro de Usuario")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Campo de correo
              TextFormField(
                decoration: const InputDecoration(labelText: 'Correo'),
                onSaved: (value) {
                  email = value ?? '';
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese un correo válido';
                  }
                  return null;
                },
              ),
              // Campo de nombre
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nombre'),
                onSaved: (value) {
                  nombre = value ?? '';
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese su nombre';
                  }
                  return null;
                },
              ),
              // Campo de cédula (cc)
              TextFormField(
                decoration: const InputDecoration(labelText: 'Cédula (CC)'),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  cc = value ?? '';
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese su número de cédula';
                  }
                  return null;
                },
              ),
              // Campo de contraseña
              TextFormField(
                decoration: const InputDecoration(labelText: 'Contraseña'),
                obscureText: true,
                onSaved: (value) {
                  password = value ?? '';
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese una contraseña';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // Botón para registrar
              ElevatedButton(
                child: const Text("Registrar"),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Lógica para registrar usuario
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Usuario registrado')),
                    );
                    Navigator.pop(context); // Regresar a la lista
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
