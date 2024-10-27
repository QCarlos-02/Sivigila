import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DashboardWidget extends StatelessWidget {
  const DashboardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 18),
          Text("${auth.currentUser!.email}, Uid: ${auth.currentUser!.uid}"),
          // const HeaderWidget(),
          const SizedBox(height: 18),
        ],
      ),
    );
  }
}
