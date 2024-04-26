import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/services/get_it.dart';
import 'package:flutter_achievments/core/utils/screen_utilities.dart';
import 'package:flutter_achievments/features/task/presentation/bloc/chat_bloc/chat_bloc.dart';
import 'package:flutter_achievments/features/task/presentation/provider/chat_bloc_provider.dart';
import 'package:flutter_achievments/features/task/presentation/provider/chat_messages_provider.dart';
import 'package:flutter_achievments/features/task/presentation/provider/page_index.dart';
import 'package:flutter_achievments/features/task/presentation/widgets/common/animated_navbar.dart';
import 'package:flutter_achievments/features/task/presentation/widgets/common/bottom_nav_bar.dart';
import 'package:flutter_achievments/features/task/presentation/widgets/common/floating_action_button.dart';
import 'package:flutter_achievments/features/task/presentation/widgets/common/modal_bottom_sheet.dart';
import 'package:flutter_achievments/features/task/presentation/widgets/common/tab_bottom_sheet_widgets.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
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
  StreamSubscription? chatErrorSubscription;
  final _advancedDrawerController = AdvancedDrawerController();

  @override
  void initState() {
    super.initState();
    _controller = DraggableScrollableController();
    final chatBlocProvider =
        Provider.of<ChatBlocProvider>(context, listen: false);
    final chatProvider =
        Provider.of<ChatMessagesProvider>(context, listen: false);
    chatBlocProvider.init(sl<ChatBloc>(), chatProvider);
    initErrorStreamSub(chatBlocProvider.chatBloc!);
  }

  // TODO: dispose all image controllers in provider and chat bloc and chat messages proivder when log out
  @override
  void dispose() {
    _controller.dispose();
    chatErrorSubscription?.cancel();
    _advancedDrawerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final maxChildSize = sl<ScreenUtilities>().getMaxChildSize(context);
    final minChildSize = sl<ScreenUtilities>().getMinChildSize(context);
    return AdvancedDrawer(
      backdrop: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blueGrey, Colors.blueGrey.withOpacity(0.2)],
          ),
        ),
      ),
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      // openScale: 1.0,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        // NOTICE: Uncomment if you want to add shadow behind the page.
        // Keep in mind that it may cause animation jerks.
        // boxShadow: <BoxShadow>[
        //   BoxShadow(
        //     color: Colors.black12,
        //     blurRadius: 0.0,
        //   ),
        // ],
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      drawer: SafeArea(
        child: ListTileTheme(
          textColor: Colors.white,
          iconColor: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: 128.0,
                height: 128.0,
                margin: const EdgeInsets.only(
                  top: 24.0,
                  bottom: 64.0,
                ),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: Colors.black26,
                  shape: BoxShape.circle,
                ),
                child: Text('Avatar'),
              ),
              ListTile(
                onTap: () {},
                leading: Icon(Icons.home),
                title: Text('Home'),
              ),
              ListTile(
                onTap: () {},
                leading: Icon(Icons.account_circle_rounded),
                title: Text('Profile'),
              ),
              ListTile(
                onTap: () {},
                leading: Icon(Icons.favorite),
                title: Text('Favourites'),
              ),
              ListTile(
                onTap: () {},
                leading: Icon(Icons.settings),
                title: Text('Settings'),
              ),
              Spacer(),
              DefaultTextStyle(
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white54,
                ),
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 16.0,
                  ),
                  child: Text('Terms of Service | Privacy Policy'),
                ),
              ),
            ],
          ),
        ),
      ),
      child: Scaffold(
        extendBody: true,
        floatingActionButton: const CustomFloatingActionButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: SafeArea(
          top: false,
          child: Stack(
            children: [
              AnimatedNavbar(
                controller: _controller,
                maxChildSize: maxChildSize,
                minChildSize: minChildSize,
                // advancedDrawerController: _advancedDrawerController,
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
                          offset: Offset(0, 100),
                        ),
                      ]),
                    ),
                  ))
            ],
          ),
        ),
        bottomNavigationBar: CustomBottomNavBar(onTabSelected: (index) {
          Provider.of<PageIndexProvider>(context, listen: false)
              .setPageNumber(index);
        }),
      ),
    );
  }

  void initErrorStreamSub(ChatBloc chatBloc) {
    chatErrorSubscription = chatBloc.messageErrorStream.listen((event) {
      if (event != null) {
        //TODO: edit this error handling
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(event.dialogMessage),
            backgroundColor: Colors.red,
          ),
        );
      }
    });
  }
}
//0.84 0.87990

//783 838
