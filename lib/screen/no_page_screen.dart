import 'package:flutter/material.dart';

class NoPageScreen extends StatelessWidget {
  const NoPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('404'),
      ),
    );
  }
}
