import 'package:flutter/material.dart';
import 'package:sivigila/Admin/data/services/reportesServices.dart';

class FormularioReporte extends StatefulWidget {
  final String seccion;
  final String categoria;
<<<<<<< HEAD
=======
  final String subcategoria;
  final String subsubcategoria; // Agrega este parámetro
>>>>>>> b4b31af (Se le da funcionalidad a la parte de registro de usuarios y a casos pendientes)
  final String evento;

  const FormularioReporte({
    super.key,
    required this.seccion,
    required this.categoria,
<<<<<<< HEAD
=======
    required this.subcategoria,
    required this.subsubcategoria, // Asegúrate de recibir subsubcategoria
>>>>>>> b4b31af (Se le da funcionalidad a la parte de registro de usuarios y a casos pendientes)
    required this.evento,
  });

  @override
  _FormularioReporteState createState() => _FormularioReporteState();
}

class _FormularioReporteState extends State<FormularioReporte> {
  final List<String> _zonas = ['Zona 1', 'Zona 2', 'Zona 3'];
  final List<String> _comunas = ['Comuna 1', 'Comuna 2', 'Comuna 3'];

  String? _zonaSeleccionada;
  String? _comunaSeleccionada;

  final TextEditingController _personaController = TextEditingController();
  final TextEditingController _barrioController = TextEditingController();
  final TextEditingController _direccionController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();

<<<<<<< HEAD
  String? _errorMessage; // Variable para almacenar mensajes de error
=======
  String? _errorMessage;
>>>>>>> b4b31af (Se le da funcionalidad a la parte de registro de usuarios y a casos pendientes)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< HEAD
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue[300]!, Colors.blue[700]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        width: double.infinity,
        height: double.infinity,
=======
      appBar: AppBar(
        title: const Text('Formulario de Reporte'),
      ),
      body: Container(
>>>>>>> b4b31af (Se le da funcionalidad a la parte de registro de usuarios y a casos pendientes)
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
<<<<<<< HEAD
              const Text(
                'Formulario de Reporte',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              _buildInfoText('Sección: ${widget.seccion}'),
              _buildInfoText('Categoría: ${widget.categoria}'),
              _buildInfoText('Evento: ${widget.evento}'),
              const SizedBox(height: 20),
              _buildInfoText('Fecha de Notificación (Automática):'),
              Text(
                DateTime.now().toString(),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 20),
=======
              _buildInfoText('Sección: ${widget.seccion}'),
              _buildInfoText('Categoría: ${widget.categoria}'),
              _buildInfoText('Subcategoría: ${widget.subcategoria}'),
              _buildInfoText('Evento: ${widget.evento}'),
              const SizedBox(height: 20),
>>>>>>> b4b31af (Se le da funcionalidad a la parte de registro de usuarios y a casos pendientes)
              _buildTextField('Persona que notificó', _personaController),
              _buildDropdown('Zona', _zonas, (value) {
                setState(() {
                  _zonaSeleccionada = value;
                });
              }),
              _buildDropdown('Comuna', _comunas, (value) {
                setState(() {
                  _comunaSeleccionada = value;
                });
              }),
              _buildTextField(
                  'Barrio donde sucedió el evento', _barrioController),
              _buildTextField('Dirección del evento', _direccionController),
              _buildTextField(
                  'Descripción de lo sucedido', _descripcionController,
                  maxLines: 3),
              if (_errorMessage != null) ...[
<<<<<<< HEAD
                // Muestra mensaje de error si existe
=======
>>>>>>> b4b31af (Se le da funcionalidad a la parte de registro de usuarios y a casos pendientes)
                const SizedBox(height: 10),
                Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              ],
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
<<<<<<< HEAD
                    guardarReporte(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue[700],
=======
                    _guardarReporte(context);
                  },
                  style: ElevatedButton.styleFrom(
>>>>>>> b4b31af (Se le da funcionalidad a la parte de registro de usuarios y a casos pendientes)
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                  ),
                  child: const Text('Enviar Reporte'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

<<<<<<< HEAD
  void guardarReporte(BuildContext context) async {
    await Reportesservices().guardarReporte(
        widget.seccion,
        widget.categoria,
        widget.evento,
        DateTime.now().toString(),
        _personaController.text,
        _zonaSeleccionada!,
        _comunaSeleccionada!,
        _barrioController.text,
        _direccionController.text,
        _descripcionController.text,
        'Pendiente');
  }

  // Future<void> _enviarReporte() async {
  //   // Validar campos antes de enviar
  //   if (_personaController.text.isEmpty ||
  //       _zonaSeleccionada == null ||
  //       _comunaSeleccionada == null ||
  //       _barrioController.text.isEmpty ||
  //       _direccionController.text.isEmpty ||
  //       _descripcionController.text.isEmpty) {
  //     setState(() {
  //       _errorMessage = 'Por favor, completa todos los campos.';
  //     });
  //     return; // Salir si hay campos vacíos
  //   }

  //   // Crear nuevo reporte
  //   final nuevoReporte = Reporte(
  //       seccion: widget.seccion,
  //       categoria: widget.categoria,
  //       evento: widget.evento,
  //       fecha: DateTime.now().toString(),
  //       persona: _personaController.text,
  //       zona: _zonaSeleccionada!,
  //       comuna: _comunaSeleccionada!,
  //       barrio: _barrioController.text,
  //       direccion: _direccionController.text,
  //       descripcion: _descripcionController.text,
  //       estado: "Pendiente");

  //   try {
  //     // Guardar en Firestore
  //     await FirebaseFirestore.instance.collection('reportes').add({
  //       'seccion': nuevoReporte.seccion,
  //       'categoria': nuevoReporte.categoria,
  //       'evento': nuevoReporte.evento,
  //       'fecha': nuevoReporte.fecha,
  //       'persona': nuevoReporte.persona,
  //       'zona': nuevoReporte.zona,
  //       'comuna': nuevoReporte.comuna,
  //       'barrio': nuevoReporte.barrio,
  //       'direccion': nuevoReporte.direccion,
  //       'descripcion': nuevoReporte.descripcion,
  //       'estado': nuevoReporte.estado
  //     });

  //     // Limpiar los campos después de enviar el reporte
  //     _personaController.clear();
  //     _barrioController.clear();
  //     _direccionController.clear();
  //     _descripcionController.clear();
  //     _zonaSeleccionada = null;
  //     _comunaSeleccionada = null;
  //     setState(() {
  //       _errorMessage = null; // Limpiar el mensaje de error
  //     });

  //     Navigator.pop(context, 'Reporte enviado');
  //   } catch (e) {
  //     // Manejar error al guardar en Firestore
  //     setState(() {
  //       _errorMessage = 'Error al enviar el reporte. Intente nuevamente.';
  //     });
  //   }
  // }

  Widget _buildInfoText(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 16, color: Colors.white),
=======
  void _guardarReporte(BuildContext context) async {
    if (_validarCampos()) {
      try {
        await Reportesservices().guardarReporte(
          widget.seccion,
          widget.categoria,
          widget.subcategoria,
          widget
              .subsubcategoria, // Incluye subsubcategoria en el orden correcto
          widget.evento,
          DateTime.now().toString(),
          _personaController.text,
          _zonaSeleccionada ?? '',
          _comunaSeleccionada ?? '',
          _barrioController.text,
          _direccionController.text,
          _descripcionController.text,
          'Pendiente', // Este es el valor de 'estado'
        );
        Navigator.pop(context, 'Reporte enviado');
      } catch (e) {
        setState(() {
          _errorMessage = 'Error al enviar el reporte. Intente nuevamente.';
        });
      }
    } else {
      setState(() {
        _errorMessage = 'Por favor, completa todos los campos.';
      });
    }
  }

  bool _validarCampos() {
    return _personaController.text.isNotEmpty &&
        _zonaSeleccionada != null &&
        _comunaSeleccionada != null &&
        _barrioController.text.isNotEmpty &&
        _direccionController.text.isNotEmpty &&
        _descripcionController.text.isNotEmpty;
  }

  Widget _buildInfoText(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, color: Colors.black),
      ),
>>>>>>> b4b31af (Se le da funcionalidad a la parte de registro de usuarios y a casos pendientes)
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
<<<<<<< HEAD
          labelStyle: const TextStyle(color: Colors.white),
          filled: true,
          fillColor: Colors.white.withOpacity(0.2),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
=======
          border: OutlineInputBorder(),
>>>>>>> b4b31af (Se le da funcionalidad a la parte de registro de usuarios y a casos pendientes)
        ),
      ),
    );
  }

  Widget _buildDropdown(
      String label, List<String> items, ValueChanged<String?> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
<<<<<<< HEAD
          labelStyle: const TextStyle(color: Colors.white),
          filled: true,
          fillColor: Colors.white.withOpacity(0.2),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
=======
          border: OutlineInputBorder(),
>>>>>>> b4b31af (Se le da funcionalidad a la parte de registro de usuarios y a casos pendientes)
        ),
        items: items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: onChanged,
<<<<<<< HEAD
        dropdownColor: Colors.white,
        style: TextStyle(color: Colors.blue[700]),
=======
>>>>>>> b4b31af (Se le da funcionalidad a la parte de registro de usuarios y a casos pendientes)
      ),
    );
  }
}
