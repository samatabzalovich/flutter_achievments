import 'package:flutter/material.dart';
import 'package:flutter_achievments/features/app/domain/shared_entities/parent_entity.dart';
import 'package:flutter_achievments/features/app/presentation/provider/user_provider.dart';
import 'package:provider/provider.dart';

class ParentHomePage extends StatefulWidget {
  static const String routeName = '/parent-home';
  const ParentHomePage({super.key});

  @override
  State<ParentHomePage> createState() => _ParentHomePageState();
}

class _ParentHomePageState extends State<ParentHomePage> {
  String dropdownValue = 'One';
  List<String> dropdownItems = ['One', 'Two', 'Three', 'Four']; 
  @override
  Widget build(BuildContext context) {
    final parent = Provider.of<UserProvider>(context, listen: true).currentUser as ParentEntity;
    return const Scaffold(
      body: Column(
        children: [
          // AnimatedNavbar('home', user: parent, )
        ],
      )
    );
  }
}
