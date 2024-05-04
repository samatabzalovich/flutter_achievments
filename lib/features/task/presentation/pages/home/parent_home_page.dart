import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/common/widgets/avatar_builder.dart';
import 'package:flutter_achievments/core/common/widgets/custom_text.dart';
import 'package:flutter_achievments/core/constant/colors.dart';
import 'package:flutter_achievments/core/services/get_it.dart';
import 'package:flutter_achievments/core/utils/screen_utilities.dart';
import 'package:flutter_achievments/features/app/domain/shared_entities/parent_entity.dart';
import 'package:flutter_achievments/features/app/presentation/provider/user_provider.dart';
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
  late final ParentEntity parent;

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
    parent = Provider.of<UserProvider>(context, listen: false).currentUser
        as ParentEntity;
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
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [lightBlue, lightBlue2],
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
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      drawer: SafeArea(
        child: ListTileTheme(
          textColor: Colors.white,
          iconColor: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                children: [
                  Container(
                    width: 128.0,
                    height: 128.0,
                    margin: const EdgeInsets.only(
                      top: 24.0,
                      bottom: 14.0,
                    ),
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                      color: Colors.black26,
                      shape: BoxShape.circle,
                    ),
                    child: AvatarBuilder(
                      parent.name!,
                      avatarEntity: parent.avatar,
                    ),
                  ),
                  CustomText(
                    parent.name!,
                    color: Colors.white,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 40,
                  )
                ],
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.home),
                title: const CustomText(
                  'Home',
                  color: Colors.white,
                  textAlign: TextAlign.start,
                ),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.account_circle_rounded),
                title: const CustomText(
                  'Profile',
                  color: Colors.white,
                  textAlign: TextAlign.start,
                ),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.favorite),
                title: const CustomText(
                  'Favorites',
                  color: Colors.white,
                  textAlign: TextAlign.start,
                ),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.settings),
                title: const CustomText(
                  'Settings',
                  color: Colors.white,
                  textAlign: TextAlign.start,
                ),
              ),
              const Spacer(),
              DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white54,
                ),
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 16.0,
                  ),
                  child: const Text('Terms of Service | Privacy Policy'),
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
