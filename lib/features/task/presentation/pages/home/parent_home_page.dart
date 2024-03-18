import 'package:flutter/material.dart';
import 'package:flutter_achievments/features/app/domain/shared_entities/parent_entity.dart';
import 'package:flutter_achievments/features/app/presentation/provider/user_provider.dart';
import 'package:flutter_achievments/features/task/presentation/widgets/common/animated_navbar.dart';
import 'package:flutter_achievments/features/task/presentation/widgets/common/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

class ParentHomePage extends StatefulWidget {
  static const String routeName = '/parent-home';
  const ParentHomePage({super.key});

  @override
  State<ParentHomePage> createState() => _ParentHomePageState();
}

class _ParentHomePageState extends State<ParentHomePage> {
  late DraggableScrollableController _controller;

  @override
  void initState() {
    super.initState();
    _controller = DraggableScrollableController();
  }

  @override
  void dispose() {
    
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final parent = Provider.of<UserProvider>(context, listen: true).currentUser
        as ParentEntity;
    final maxChildSize = _getMaxChildSize(context);
    final minChildSize = _getMinChildSize(context);
    return Scaffold(
        body: Stack(
      children: [
        AnimatedNavbar(
          controller: _controller,
          maxChildSize: maxChildSize,
          minChildSize: minChildSize,
        ),
        HomeBottomSheet(
          controller: _controller,
          maxChildSize: maxChildSize,
          minChildSize: minChildSize,
        )
      ],
    ));
  }

  double _getMaxChildSize(BuildContext context) {
    var isTablet = MediaQuery.of(context).size.shortestSide > 600;
    return isTablet ? 0.91 : 0.88; // Example adjustment, customize as needed
  }

  double _getMinChildSize(BuildContext context) {
    var isTablet = MediaQuery.of(context).size.shortestSide > 600;
    return isTablet ? 0.89 : 0.84; // Example adjustment, customize as needed
  }
}
//0.84 0.87990

//783 838
