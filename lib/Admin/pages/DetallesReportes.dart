import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sivigila/Admin/controllers/controlPerfil.dart';
import 'package:sivigila/Admin/controllers/reporteController.dart';
import 'package:sivigila/Models/reporte.dart';

class DetallesReporteScreen extends StatefulWidget {
  final Reporte reporte;
  final String? estado;

  DetallesReporteScreen({required this.reporte, this.estado});

  @override
  _DetallesReporteScreenState createState() => _DetallesReporteScreenState();
}

class _DetallesReporteScreenState extends State<DetallesReporteScreen> {
  Reportecontroller rp = Get.find();
  late TextEditingController observacionesController;
  String? estadoSeleccionado; // Valor inicial del estado

  @override
  void initState() {
    super.initState();
    observacionesController = TextEditingController();
    observacionesController.text = widget.reporte.observaciones;
    estadoSeleccionado = widget.reporte.estado;
    print(
        "ID REPORTE: ${widget.reporte.id}"); // Asigna el valor de estado desde el reporte
  }

  @override
  void dispose() {
    observacionesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles del Reporte'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Campos de visualización
            _buildReadOnlyField('Nombres', widget.reporte.nombres),
            _buildReadOnlyField('Apellidos', widget.reporte.apellidos),
            _buildReadOnlyField('Barrio', widget.reporte.barrio),
            _buildReadOnlyField('Comuna', widget.reporte.comuna),
            _buildReadOnlyField('Categoría', widget.reporte.categoria),
            _buildReadOnlyField('Descripción', widget.reporte.descripcion),
            _buildReadOnlyField('Dirección', widget.reporte.direccion),
            _buildReadOnlyField('Fecha Índice', widget.reporte.fecha),
            _buildReadOnlyField('Sección', widget.reporte.seccion),
            _buildReadOnlyField('Subcategoría', widget.reporte.subcategoria),
            _buildReadOnlyField(
                'Sub-subcategoría', widget.reporte.subsubcategoria),
            _buildReadOnlyField('Zona', widget.reporte.zona),

            // Campo editable: Estado
            const SizedBox(height: 16),
            Text(
              'Estado',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: estadoSeleccionado,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              items: ['Pendiente', 'En Proceso', 'Exitoso', 'Fallido']
                  .map((String estado) {
                return DropdownMenuItem<String>(
                  value: estado,
                  child: Text(estado),
                );
              }).toList(),
              onChanged: (String? nuevoEstado) {
                setState(() {
                  estadoSeleccionado = nuevoEstado!;
                });
              },
            ),

            // Campo editable: Observaciones
            const SizedBox(height: 16),
            Text(
              'Observaciones',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: observacionesController,
              decoration: const InputDecoration(
                hintText: 'Añadir observaciones',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),

            // Botón de Guardar Cambios
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Acción para guardar los cambios (observaciones y estado)
                  actualizarReporte(context);
                  print('Estado seleccionado: $estadoSeleccionado');
                  print('Observaciones: ${observacionesController.text}');
                  rp.consultarReportesgeneral();
                  rp.consultarReportesPorEstado(widget.estado!);
                  Navigator.pop(context, true); // Vuelve a la pantalla anterior
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text('Guardar Cambios'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Método para construir campos de solo lectura
  Widget _buildReadOnlyField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 4),
          TextFormField(
            initialValue: value,
            readOnly: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void actualizarReporte(BuildContext context) async {
    try {
      await Reportecontroller().actualizarReporte(widget.reporte.id, {
        "estado": estadoSeleccionado,
        "observaciones": observacionesController.text,
      });
      print("Reporte actualizado correctamente");
    } catch (e) {
      print("Error al actualizar el reporte: $e");
    }
  }
}
