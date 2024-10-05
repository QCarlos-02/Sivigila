import 'package:flutter/material.dart';
import 'package:sivigila/Models/reporte.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FormularioReporte extends StatefulWidget {
  final String seccion;
  final String categoria;
  final String evento;

  const FormularioReporte({
    super.key,
    required this.seccion,
    required this.categoria,
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

  String? _errorMessage; // Variable para almacenar mensajes de error

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                // Muestra mensaje de error si existe
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
                    _enviarReporte();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue[700],
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

  Future<void> _enviarReporte() async {
    // Validar campos antes de enviar
    if (_personaController.text.isEmpty ||
        _zonaSeleccionada == null ||
        _comunaSeleccionada == null ||
        _barrioController.text.isEmpty ||
        _direccionController.text.isEmpty ||
        _descripcionController.text.isEmpty) {
      setState(() {
        _errorMessage = 'Por favor, completa todos los campos.';
      });
      return; // Salir si hay campos vacíos
    }

    // Crear nuevo reporte
    final nuevoReporte = Reporte(
      seccion: widget.seccion,
      categoria: widget.categoria,
      evento: widget.evento,
      fecha: DateTime.now().toString(),
      persona: _personaController.text,
      zona: _zonaSeleccionada!,
      comuna: _comunaSeleccionada!,
      barrio: _barrioController.text,
      direccion: _direccionController.text,
      descripcion: _descripcionController.text,
    );

    try {
      // Guardar en Firestore
      await FirebaseFirestore.instance.collection('reportes').add({
        'seccion': nuevoReporte.seccion,
        'categoria': nuevoReporte.categoria,
        'evento': nuevoReporte.evento,
        'fecha': nuevoReporte.fecha,
        'persona': nuevoReporte.persona,
        'zona': nuevoReporte.zona,
        'comuna': nuevoReporte.comuna,
        'barrio': nuevoReporte.barrio,
        'direccion': nuevoReporte.direccion,
        'descripcion': nuevoReporte.descripcion,
      });

      // Limpiar los campos después de enviar el reporte
      _personaController.clear();
      _barrioController.clear();
      _direccionController.clear();
      _descripcionController.clear();
      _zonaSeleccionada = null;
      _comunaSeleccionada = null;
      setState(() {
        _errorMessage = null; // Limpiar el mensaje de error
      });

      Navigator.pop(context, 'Reporte enviado');
    } catch (e) {
      // Manejar error al guardar en Firestore
      setState(() {
        _errorMessage = 'Error al enviar el reporte. Intente nuevamente.';
      });
    }
  }

  Widget _buildInfoText(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 16, color: Colors.white),
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
          labelStyle: const TextStyle(color: Colors.white),
          filled: true,
          fillColor: Colors.white.withOpacity(0.2),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
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
            child: Text(value),
          );
        }).toList(),
        onChanged: onChanged,
        dropdownColor: Colors.white,
        style: TextStyle(color: Colors.blue[700]),
      ),
    );
  }
}
