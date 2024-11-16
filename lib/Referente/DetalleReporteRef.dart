import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetalleReporteRef extends StatelessWidget {
  final String casoId;
  final Map<String, dynamic> data;

  const DetalleReporteRef({super.key, required this.casoId, required this.data});

  @override
  Widget build(BuildContext context) {
    final List<String>? comentarios = data['ComentRef'] != null
        ? List<String>.from(data['ComentRef'])
        : null;

    final bool yaComentado = comentarios != null && comentarios.isNotEmpty;
    final TextEditingController comentarioController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle del Caso'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionHeader('Datos Personales'),
              _buildListTile('Nombres', data['nombres'], Icons.person),
              _buildListTile('Apellidos', data['apellidos'], Icons.person_outline),
              const SizedBox(height: 16),
              
              _buildSectionHeader('Ubicación'),
              _buildListTile('Barrio', data['barrio'], Icons.location_city),
              _buildListTile('Comuna', data['comuna'], Icons.map),
              _buildListTile('Dirección', data['direccion'], Icons.home),
              const SizedBox(height: 16),

              _buildSectionHeader('Detalles del Incidente'),
              _buildListTile('Categoría', data['categoria'], Icons.category),
              _buildListTile('Comuna Evento', data['comuna_evento'], Icons.event),
              _buildListTile('Descripción', data['descripcion'], Icons.description),
              _buildListTile('Estado', data['estado'], Icons.flag),
              _buildListTile('Fecha Incidente', data['fecha_incidente'], Icons.date_range),
              const SizedBox(height: 20),

              _buildSectionHeader('Comentario del Referente'),
              const SizedBox(height: 10),
              if (yaComentado) ...[
                // Mostrar el comentario existente
                Text(
                  'Comentario existente:',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                Text(
                  comentarios!.first, // Mostrar el primer comentario
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ] else ...[
                // Campo de texto para añadir un nuevo comentario
                TextField(
                  controller: comentarioController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Escribe tu comentario aquí...',
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    if (comentarioController.text.isNotEmpty) {
                      await FirebaseFirestore.instance
                          .collection('reportes')
                          .doc(casoId)
                          .update({
                        'ComentRef': FieldValue.arrayUnion([comentarioController.text]),
                        'tieneComentario': true, // Actualizamos a true
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Comentario añadido')),
                      );
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Guardar Comentario'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: Colors.blueGrey,
        ),
      ),
    );
  }

  Widget _buildListTile(String label, dynamic value, IconData icon) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: Colors.blueAccent),
          title: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          subtitle: Text(
            value != null ? value.toString() : 'N/A',
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ),
        const Divider(color: Colors.grey), // Línea separadora
      ],
    );
  }
}
