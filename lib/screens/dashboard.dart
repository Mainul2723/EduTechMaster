import 'package:flutter/material.dart' ;

class DashBoard extends StatelessWidget {
  const DashBoard({super.key, required this.controller});
  final PageController controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Text('This is Dashboard'),
    );
  }
}
