import 'package:flutter/material.dart';

class DashboardWidget extends StatelessWidget {
  const DashboardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        children: [
          SizedBox(height: 18),
          Text("INICIO"),
          // const HeaderWidget(),
          SizedBox(height: 18),
        ],
      ),
    );
  }
}
