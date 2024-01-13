import 'package:flutter/material.dart';

class RouteNotFoundPage extends StatelessWidget {
  const RouteNotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Route Not Found'),
      ),
      body: const Center(
        child: Text(
          'Oops! The requested route was not found.',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
