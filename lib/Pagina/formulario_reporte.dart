import 'package:flutter/material.dart';
import 'package:sivigila/Admin/data/services/reportesServices.dart';

class FormularioReporte extends StatefulWidget {
  final String seccion;
  final String categoria;
  final String subcategoria;
  final String subsubcategoria; // Agrega este parámetro
  final String evento;

  const FormularioReporte({
    super.key,
    required this.seccion,
    required this.categoria,
    required this.subcategoria,
    required this.subsubcategoria, // Asegúrate de recibir subsubcategoria
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

  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulario de Reporte'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInfoText('Sección: ${widget.seccion}'),
              _buildInfoText('Categoría: ${widget.categoria}'),
              _buildInfoText('Subcategoría: ${widget.subcategoria}'),
              _buildInfoText('Evento: ${widget.evento}'),
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
                    _guardarReporte(context);
                  },
                  style: ElevatedButton.styleFrom(
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
          border: OutlineInputBorder(),
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
          border: OutlineInputBorder(),
        ),
        items: items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}
