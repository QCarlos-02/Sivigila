import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sivigila/Admin/Widgets/exportarExcel.dart';
import 'package:sivigila/Admin/controllers/reporteController.dart';
import 'package:sivigila/Admin/controllers/userController.dart';
import 'package:sivigila/Admin/pages/CasosDescartados.dart';
import 'package:sivigila/Admin/pages/CasosEnProceso.dart';
import 'package:sivigila/Admin/pages/CasosFallidos.dart';
import 'package:sivigila/Admin/pages/Casosexitosos.dart';
import 'package:sivigila/Admin/pages/Casospendientes.dart';
import 'package:sivigila/Admin/pages/RegistroUsuario.dart';
import 'package:sivigila/Models/reporte.dart';
import 'package:sivigila/Pagina/login_page.dart';

Widget drawer(BuildContext context) {
  final ControlUserAuth cua = Get.find(); // Obtén el controlador
  final Reportecontroller rc = Get.find();
  final double screenWidth = MediaQuery.of(context).size.width;
  final bool isMobile = screenWidth < 600;

  return Drawer(
    backgroundColor: const Color.fromARGB(255, 0, 44, 81),
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color.fromARGB(255, 0, 44, 81), Colors.blueAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.account_circle,
                color: Colors.white,
                size: isMobile ? 50 : 60,
              ),
              const SizedBox(height: 10),
              // Usa Obx para observar cambios en el nombre del usuario logueado
              Obx(() {
                String nombre = cua
                    .adminName; // Usar la propiedad adminName del controlador
                return Text(
                  nombre,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isMobile ? 18 : 20,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }),
              const SizedBox(height: 5),
              const Text(
                'Panel de Usuario',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        // Sección de reportes
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'Reportes',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        _buildDrawerItem(
          context,
          icon: Icons.pending_actions_outlined,
          text: "Situaciones pendientes",
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Casospendientes()),
            );
          },
        ),
        _buildDrawerItem(
          context,
          icon: Icons.double_arrow_rounded,
          text: "Situaciones en proceso",
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Casosenproceso()),
            );
          },
        ),
        _buildDrawerItem(
          context,
          icon: Icons.check_circle_outline,
          text: "Situaciones exitosos",
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Casosexitosos()),
            );
          },
        ),
        _buildDrawerItem(
          context,
          icon: Icons.archive,
          text: "Situaciones fallidos",
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Casosfallidos()),
            );
          },
        ),
        _buildDrawerItem(
          context,
          icon: Icons.cancel,
          text: 'Situaciones descartados',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CasosDescartados()),
            );
          },
        ),
        const Divider(color: Colors.white54, thickness: 1),
        // Sección de administración
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'Exportar Reportes',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        _buildDrawerItem(context, icon: Icons.download_outlined, text: 'Excel',
            onTap: () {
          rc.consultarReportesgeneral();
          mostrarDialogoExportarReportes(context, rc.listgeneral!);
        }),
        const Divider(color: Colors.white54, thickness: 1),
        // Sección de administración
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'Administración',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        _buildDrawerItem(
          context,
          icon: Icons.app_registration,
          text: "Registro de usuarios",
          onTap: () {
            cua.consultarUsuarios();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Registro()),
            );
          },
        ),
        const Divider(color: Colors.white54, thickness: 1),
        // Sección de salida
        _buildDrawerItem(
          context,
          icon: Icons.exit_to_app,
          text: "Salir",
          onTap: () {
            cua.cerrarSesion();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            );
          },
        ),
      ],
    ),
  );
}

void mostrarDialogoExportarReportes(
    BuildContext context, List<Reporte> reportes) {
  List<String> estadosSeleccionados = [];

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text('Exportar Reportes',
                style: TextStyle(color: Colors.blue[800])),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CheckboxListTile(
                  activeColor: Colors.blue[800],
                  title: Text('Pendientes',
                      style: TextStyle(color: Colors.blue[800])),
                  value: estadosSeleccionados.contains('Pendiente'),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value == true) {
                        estadosSeleccionados.add('Pendiente');
                      } else {
                        estadosSeleccionados.remove('Pendiente');
                      }
                    });
                  },
                ),
                CheckboxListTile(
                  activeColor: Colors.blue[800],
                  title: Text('En Proceso',
                      style: TextStyle(color: Colors.blue[800])),
                  value: estadosSeleccionados.contains('En proceso'),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value == true) {
                        estadosSeleccionados.add('En proceso');
                      } else {
                        estadosSeleccionados.remove('En proceso');
                      }
                    });
                  },
                ),
                CheckboxListTile(
                  activeColor: Colors.blue[800],
                  title: Text('Exitosos',
                      style: TextStyle(color: Colors.blue[800])),
                  value: estadosSeleccionados.contains('Exitoso'),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value == true) {
                        estadosSeleccionados.add('Exitoso');
                      } else {
                        estadosSeleccionados.remove('Exitoso');
                      }
                    });
                  },
                ),
                CheckboxListTile(
                  activeColor: Colors.blue[800],
                  title: Text('Fallidos',
                      style: TextStyle(color: Colors.blue[800])),
                  value: estadosSeleccionados.contains('Fallido'),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value == true) {
                        estadosSeleccionados.add('Fallido');
                      } else {
                        estadosSeleccionados.remove('Fallido');
                      }
                    });
                  },
                ),
                CheckboxListTile(
                  activeColor: Colors.blue[800],
                  title: Text('Descartados',
                      style: TextStyle(color: Colors.blue[800])),
                  value: estadosSeleccionados.contains('Descartado'),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value == true) {
                        estadosSeleccionados.add('Descartado');
                      } else {
                        estadosSeleccionados.remove('Descartado');
                      }
                    });
                  },
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.blue[800]),
                child: Text('Cancelar', style: TextStyle(color: Colors.white)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.blue[800]),
                child: Text('Exportar', style: TextStyle(color: Colors.white)),
                onPressed: () {
                  Navigator.of(context).pop();
                  List<Reporte> reportesFiltrados = reportes
                      .where((reporte) =>
                          estadosSeleccionados.contains(reporte.estado))
                      .toList();
                  exportReportesToExcel(reportesFiltrados);
                },
              ),
            ],
          );
        },
      );
    },
  );
}

Widget _buildDrawerItem(BuildContext context,
    {required IconData icon, required String text, required Function() onTap}) {
  final double screenWidth = MediaQuery.of(context).size.width;
  final bool isMobile = screenWidth < 600;

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: ListTile(
      leading: Icon(icon, color: Colors.white, size: isMobile ? 24 : 28),
      title: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: isMobile ? 16 : 18,
        ),
      ),
      onTap: onTap,
    ),
  );
}
