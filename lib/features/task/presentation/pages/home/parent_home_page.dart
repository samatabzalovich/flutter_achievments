import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/services/get_it.dart';
import 'package:flutter_achievments/core/utils/screen_utilities.dart';
import 'package:flutter_achievments/features/task/presentation/provider/page_index.dart';
import 'package:flutter_achievments/features/task/presentation/widgets/common/animated_navbar.dart';
import 'package:flutter_achievments/features/task/presentation/widgets/common/bottom_nav_bar.dart';
import 'package:flutter_achievments/features/task/presentation/widgets/common/floating_action_button.dart';
import 'package:flutter_achievments/features/task/presentation/widgets/common/modal_bottom_sheet.dart';
import 'package:flutter_achievments/features/task/presentation/widgets/common/tab_bottom_sheet_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    final maxChildSize = sl<ScreenUtilities>(). getMaxChildSize(context);
    final minChildSize = sl<ScreenUtilities>().getMinChildSize(context);
    return Scaffold(
      extendBody: true,
      floatingActionButton: const CustomFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Stack(
        children: [
          AnimatedNavbar(
            controller: _controller,
            maxChildSize: maxChildSize,
            minChildSize: minChildSize,
          ),
          CustomBottomSheet(
            controller: _controller,
            maxChildSize: maxChildSize,
            minChildSize: minChildSize,
            builder: (context, scrollController) {
              return TabBottomSheetWidgets(
                controller: _controller,
                minChildSize: minChildSize,
                maxChildSize: maxChildSize,
                scrollController: scrollController,
              );
            },
          ),

          Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: 110.h,
                width: double.infinity,
                child: const DecoratedBox(
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Colors.white,
                      spreadRadius: 10,
                      blurRadius: 50,
                      offset: Offset(0, 0),
                    ),
                  ]),
                ),
              ))
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(onTabSelected: (index) {
        Provider.of<PageIndexProvider>(context, listen: false).setPageNumber(index);
      }),
    );
  }

  
}
//0.84 0.87990

//783 838
