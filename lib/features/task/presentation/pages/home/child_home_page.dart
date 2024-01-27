import 'package:flutter/material.dart';

class ChildHomePage extends StatelessWidget {
  static const String routeName = '/child-home-page';
  const ChildHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Child Home Page'),
      ),
      body: const Center(
        child: Text('Child Home Page'),
      ),
    );
  }
}