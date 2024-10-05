import 'package:flutter/material.dart';
import 'package:sivigila/Admin/dashboard_widget.dart';
import 'package:sivigila/Admin/Widgets/Drawer.dart';

class Pagina02 extends StatefulWidget {
  const Pagina02({super.key});

  @override
  State<Pagina02> createState() => _Pagina02State();
}

class _Pagina02State extends State<Pagina02> {
  late final GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scaffoldKey = GlobalKey<ScaffoldState>();
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
        child: const DashboardWidget(),
      ),
    );
  }
}
