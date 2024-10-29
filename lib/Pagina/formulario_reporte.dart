import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart'; // Para formatear la fecha

class FormularioReporte extends StatefulWidget {
  final String seccion;
  final String categoria;
  final String subcategoria;
  final String subsubcategoria;

  const FormularioReporte({
    super.key,
    required this.seccion,
    required this.categoria,
    required this.subcategoria,
    required this.subsubcategoria,
  });

  @override
  _FormularioReporteState createState() => _FormularioReporteState();
}

class _FormularioReporteState extends State<FormularioReporte> {
  final List<String> _zonas = ['Urbana', 'Rural'];
  Map<String, List<String>> _comunasYBarrios = {};

  String? _zonaSeleccionada;
  String? _comunaSeleccionada;
  String? _barrioSeleccionado;
  List<String> _comunasFiltradas = [];
  List<String> _barriosFiltrados = [];
  DateTime? _fechaIncidente;

  String? _nombres;
  String? _apellidos;
  String? _comuna;

  final TextEditingController _personaController = TextEditingController();
  final TextEditingController _direccionController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  final TextEditingController _barrioManualController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchUserDetails();
    _loadComunasYBarrios();
  }

  Future<void> _fetchUserDetails() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String userId = user.uid;

        final DocumentSnapshot snapshot = await FirebaseFirestore.instance
            .collection('perfiles')
            .doc(userId)
            .get();

        if (snapshot.exists) {
          setState(() {
            _nombres = snapshot['nombres'];
            _apellidos = snapshot['apellidos'];
            _comuna = snapshot['comuna'];
          });
        } else {
          print("No se encontró el documento para el usuario con UID $userId");
        }
      }
    } catch (e) {
      print("Error al obtener los datos del usuario: $e");
    }
  }

  Future<void> _loadComunasYBarrios() async {
    try {
      final String jsonString = await rootBundle.loadString('assets/Comunas_y_Barrios_Valledupar.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonString);

      setState(() {
        _comunasYBarrios = jsonMap.map((key, value) => MapEntry(key, List<String>.from(value)));
      });
    } catch (e) {
      print("Error al cargar el JSON: $e");
    }
  }

  void _actualizarComunas() {
    setState(() {
      _comunasFiltradas = _comunasYBarrios.keys.toList();
      _comunaSeleccionada = null;
      _barrioSeleccionado = null;
      _barriosFiltrados = [];
    });
  }

  void _actualizarBarrios(String comuna) {
    setState(() {
      _barriosFiltrados = _comunasYBarrios[comuna] ?? [];
      _barrioSeleccionado = null;
    });
  }

  Future<void> _selectFechaIncidente(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _fechaIncidente) {
      setState(() {
        _fechaIncidente = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulario de Reporte'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue[300]!, Colors.blue[700]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, color: Colors.blue[700]),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${_nombres ?? 'Cargando...'} ${_apellidos ?? ''}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Comuna: ${_comuna ?? 'Cargando...'}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _buildInfoText('Sección: ${widget.seccion}'),
              _buildInfoText('Categoría: ${widget.categoria}'),
              _buildInfoText('Subcategoría: ${widget.subcategoria}'),
              _buildInfoText('Sub-Subcategoria: ${widget.subsubcategoria}'),
              const SizedBox(height: 20),
              _buildFechaIncidenteField(),
              const SizedBox(height: 20),
              _buildDropdown('Zona', _zonas, (value) {
                setState(() {
                  _zonaSeleccionada = value;
                  _actualizarComunas();
                });
              }),
              if (_zonaSeleccionada == 'Urbana' && _zonaSeleccionada != null)
                _buildDropdown('Comuna', _comunasFiltradas, (value) {
                  setState(() {
                    _comunaSeleccionada = value;
                    _actualizarBarrios(_comunaSeleccionada!);
                  });
                }),
              if (_zonaSeleccionada == 'Urbana' && _comunaSeleccionada != null)
                _buildDropdown('Barrio', _barriosFiltrados, (value) {
                  setState(() {
                    _barrioSeleccionado = value;
                  });
                }),
              if (_zonaSeleccionada == 'Rural')
                _buildTextField('Barrio (entrada manual)', _barrioManualController),
              _buildTextField('Dirección del evento', _direccionController),
              _buildTextField('Descripción de lo sucedido', _descripcionController, maxLines: 3),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    if (_zonaSeleccionada == null || _direccionController.text.isEmpty || _descripcionController.text.isEmpty || _fechaIncidente == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Por favor, complete todos los campos requeridos")),
                      );
                      return;
                    }

                    try {
                      User? user = FirebaseAuth.instance.currentUser;
                      if (user != null) {
                        final reporte = {
                          'seccion': widget.seccion,
                          'categoria': widget.categoria,
                          'subcategoria': widget.subcategoria,
                          'subsubcategoria': widget.subsubcategoria,
                          'nombres': _nombres ?? '',
                          'apellidos': _apellidos ?? '',
                          'comuna': _comuna ?? '',
                          'fecha_incidente': _fechaIncidente!.toIso8601String(),
                          'zona': _zonaSeleccionada,
                          'comuna_evento': _comunaSeleccionada,
                          'barrio': _zonaSeleccionada == 'Urbana' ? _barrioSeleccionado : _barrioManualController.text,
                          'direccion': _direccionController.text,
                          'descripcion': _descripcionController.text,
                          'timestamp': FieldValue.serverTimestamp(),
                          'userId': user.uid, // Guarda el UID del usuario
                        };

                        await FirebaseFirestore.instance.collection('reportes').add(reporte);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Reporte enviado exitosamente")),
                        );

                        _direccionController.clear();
                        _descripcionController.clear();
                        setState(() {
                          _zonaSeleccionada = null;
                          _comunaSeleccionada = null;
                          _barrioSeleccionado = null;
                          _fechaIncidente = null;
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Error: Usuario no autenticado")),
                        );
                      }
                    } catch (e) {
                      print("Error al enviar el reporte: $e");
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Error al enviar el reporte")),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue[700],
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Enviar Reporte'),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue[700],
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Volver'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoText(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white),
          filled: true,
          fillColor: Colors.white.withOpacity(0.2),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildDropdown(String label, List<String> items, ValueChanged<String?> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: DropdownButtonFormField<String>(
        value: items.contains(label == 'Comuna' ? _comunaSeleccionada : _barrioSeleccionado) 
            ? (label == 'Comuna' ? _comunaSeleccionada : _barrioSeleccionado)
            : null,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white),
          filled: true,
          fillColor: Colors.white.withOpacity(0.2),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
        items: items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value, style: TextStyle(color: Colors.blue[700])),
          );
        }).toList(),
        onChanged: onChanged,
        dropdownColor: Colors.white,
      ),
    );
  }

  Widget _buildFechaIncidenteField() {
    return GestureDetector(
      onTap: () => _selectFechaIncidente(context),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _fechaIncidente != null
                  ? DateFormat('yyyy-MM-dd').format(_fechaIncidente!)
                  : 'Seleccione la fecha del incidente',
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            const Icon(Icons.calendar_today, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
