import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sivigila/Admin/controllers/reporteController.dart';
import 'package:sivigila/Admin/pages/dashboard_widget.dart';
import 'package:sivigila/Admin/Widgets/Drawer.dart';

class Pagina02 extends StatefulWidget {
  const Pagina02({super.key});

  @override
  State<Pagina02> createState() => _Pagina02State();
}

class _Pagina02State extends State<Pagina02> {
  late final GlobalKey<ScaffoldState> _scaffoldKey;
  Reportecontroller reportecontroller = Reportecontroller();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scaffoldKey = GlobalKey<ScaffoldState>();
    reportecontroller.consultarReportesgeneral();
    print(
        "Correo: ${_auth.currentUser!.email}, Uid: ${_auth.currentUser!.uid}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
            icon: const Icon(Icons.menu)),
      ),
      drawer: drawer(context),
      body: Container(
        child: DashboardWidget(),
      ),
    );
  }
}
