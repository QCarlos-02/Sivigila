import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'DetalleReporteRef.dart';

class InicioRef extends StatelessWidget {
  const InicioRef({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Fondo con gradiente
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueAccent, Colors.lightBlue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Casos - Referente',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Text(
              'Gestión de casos pendientes',
              style: TextStyle(
                fontSize: 12,
                color: Colors.white70,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            tooltip: 'Cerrar sesión',
            onPressed: () => _confirmLogout(context),
          ),
        ],
        elevation: 4.0,
      ),
      drawer: _buildDrawer(context), // Drawer actualizado
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('Casos Pendientes'),
            _buildCaseList(
              query: FirebaseFirestore.instance
                  .collection('reportes')
                  .where('estado', isEqualTo: 'Pendiente')
                  .snapshots(),
              context: context,
              color: Colors.lightBlue[50]!,
              icon: Icons.pending_actions,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    // Obtener datos del usuario actual
    final User? user = FirebaseAuth.instance.currentUser;
    final String userName = user?.displayName ?? 'Referente';

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blueAccent, Colors.lightBlue],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            accountName: Text(
              userName,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            accountEmail: Text(user?.email ?? 'Correo no disponible'),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: Colors.blueAccent, size: 40),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard, color: Colors.blueAccent),
            title: const Text('Inicio'),
            onTap: () {
              Navigator.pop(context); // Cerrar el Drawer
              // Navegar a Inicio si es necesario
            },
          ),
          ListTile(
            leading: const Icon(Icons.pending_actions, color: Colors.orange),
            title: const Text('Casos Pendientes'),
            onTap: () {
              Navigator.pop(context); // Cerrar el Drawer
              // Acción específica para Casos Pendientes
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.redAccent),
            title: const Text('Cerrar sesión'),
            onTap: () => _confirmLogout(context),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmLogout(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmación'),
          content: const Text('¿Está seguro de que desea cerrar sesión?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar',
                  style: TextStyle(color: Colors.blueAccent)),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, '/');
              },
              child: const Text('Cerrar sesión',
                  style: TextStyle(color: Colors.redAccent)),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.blueAccent,
        ),
      ),
    );
  }

  Widget _buildCaseList({
    required Stream<QuerySnapshot> query,
    required BuildContext context,
    required Color color,
    required IconData icon,
  }) {
    return StreamBuilder<QuerySnapshot>(
      stream: query,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No hay casos disponibles'));
        }

        final casos = snapshot.data!.docs;

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: casos.length,
          itemBuilder: (context, index) {
            final caso = casos[index];
            final data = caso.data() as Map<String, dynamic>;

            return Card(
              color: color,
              elevation: 3,
              margin:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: Icon(icon, color: Colors.blueGrey),
                title: Text(
                  'Apellidos: ${data['apellidos']}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Barrio: ${data['barrio']}'),
                    Text('Categoría: ${data['categoria']}'),
                    Text('Descripción: ${data['descripcion']}'),
                  ],
                ),
                trailing: IconButton(
                  icon:
                      const Icon(Icons.arrow_forward, color: Colors.blueAccent),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetalleReporteRef(
                          casoId: caso.id,
                          data: data,
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}
