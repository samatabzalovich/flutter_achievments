import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/common/widgets/avatar_builder.dart';
import 'package:flutter_achievments/core/common/widgets/custom_text.dart';
import 'package:flutter_achievments/core/common/widgets/custom_text_no_tr.dart';
import 'package:flutter_achievments/core/constant/colors.dart';
import 'package:flutter_achievments/features/app/domain/shared_entities/child_entity.dart';
import 'package:flutter_achievments/features/app/domain/shared_entities/parent_entity.dart';
import 'package:flutter_achievments/features/app/presentation/provider/selected_user_provider.dart';
import 'package:flutter_achievments/features/app/presentation/provider/user_provider.dart';
import 'package:flutter_achievments/generated/locale_keys.g.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class CustomDropdown<T> extends StatefulWidget {
  /// onChange is called when the selected option is changed.;
  /// It will pass back the value and the index of the option.

  /// dropdownButtonStyles passes styles to OutlineButton.styleFrom()
  final AnimationController animationController;
  const CustomDropdown({
    Key? key,
    required this.animationController,
  }) : super(key: key);

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState<T> extends State<CustomDropdown<T>>
    with TickerProviderStateMixin {
  late Animation<double> _expandAnimation;
  late Animation<double> _rotateAnimation;
  final LayerLink _layerLink = LayerLink();
  final ScrollController _scrollController =
      ScrollController(initialScrollOffset: 0);
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;
  int _currentIndex = -1;

  late List<ChildEntity> children;

  @override
  void initState() {
    _expandAnimation = CurvedAnimation(
      parent: widget.animationController,
      curve: Curves.easeInOut,
    );
    _rotateAnimation = Tween(begin: 0.0, end: 0.5).animate(CurvedAnimation(
      parent: widget.animationController,
      curve: Curves.easeInOut,
    ));
    if (_overlayEntry != null && _overlayEntry!.mounted) {
      _overlayEntry!.remove();
    }
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    if (_overlayEntry != null && _overlayEntry!.mounted) {
      widget.animationController.reverse();
      _overlayEntry!.remove();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ChildEntity? selectedChild =
        Provider.of<SelectedUserProvider>(context, listen: false).selectedUser
            as ChildEntity?;

    children = (Provider.of<UserProvider>(context, listen: false).currentUser
                as ParentEntity)
            .children ??
        [];

    // link the overlay to the button
    return CompositedTransformTarget(
      link: _layerLink,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(10),
          ),
          color: _isOpen ? dropDownBackground : Colors.transparent,
        ),
        child: SizedBox(
          width: _dropdownWidth,
          height: 64.h,
          child: InkWell(
            onTap: _toggleDropdown,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                selectedChild != null
                    ? _buildChildProfile(
                        selectedChild,
                        selected: true,
                      )
                    : _buildAllTasksWidget(
                        selected: true,
                      ),
                RotationTransition(
                  turns: _rotateAnimation,
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.white,
                    size: 35.h,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  OverlayEntry _createOverlayEntry() {
    // find the size and position of the current widget
    RenderBox renderBox = context.findRenderObject()! as RenderBox;
    var size = renderBox.size;

    var offset = renderBox.localToGlobal(Offset.zero);
    var topOffset = offset.dy + size.height + 5;
    return OverlayEntry(
      // full screen GestureDetector to register when a
      // user has clicked away from the dropdown
      builder: (context) => GestureDetector(
        onTap: () => _toggleDropdown(close: true),
        behavior: HitTestBehavior.translucent,
        // full screen container to register taps anywhere and close drop down
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Positioned(
                left: offset.dx,
                top: topOffset,
                width: _dropdownWidth,
                child: CompositedTransformFollower(
                  offset: Offset(0, size.height),
                  link: _layerLink,
                  showWhenUnlinked: false,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black
                              .withOpacity(0.2), // Customize your shadow here
                          blurRadius: 30.0,
                          spreadRadius: 1.0,
                          offset: const Offset(0, 7),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(10),
                      ),
                      child: Material(
                        child: SizeTransition(
                          axisAlignment: 1,
                          sizeFactor: _expandAnimation,
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxHeight: (MediaQuery.of(context).size.height -
                                          topOffset -
                                          15)
                                      .isNegative
                                  ? 100.h
                                  : MediaQuery.of(context).size.height -
                                      topOffset -
                                      15,
                            ),
                            child: RawScrollbar(
                              thumbVisibility: false,
                              controller: _scrollController,
                              child: ListView(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                controller: _scrollController,
                                children: children.asMap().entries.map((item) {
                                  final provider =
                                      Provider.of<SelectedUserProvider>(context,
                                          listen: false);
                                  late Widget profile;
                                  if (item.value ==
                                      provider.selectedUser as ChildEntity?) {
                                    profile = _buildAllTasksWidget(
                                      selected: false,
                                    );
                                  } else {
                                    profile = _buildChildProfile(
                                      item.value,
                                      selected: false,
                                    );
                                  }
                                  return InkWell(
                                    splashColor: dropDownBackground,
                                    onTap: () {
                                      setState(() => _currentIndex = item.key);
                                      _toggleDropdown();
                                      if (item.value ==
                                          provider.selectedUser
                                              as ChildEntity?) {
                                        provider.setSelectedUser(null);
                                      } else {
                                        provider.setSelectedUser(item.value);
                                      }
                                    },
                                    child: profile,
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _toggleDropdown({bool close = false}) async {
    if (_isOpen || close) {
      await widget.animationController.reverse();
      if (mounted) {
        setState(() {
          _isOpen = false;
        });
      } else {
        _isOpen = false;
      }
      _overlayEntry?.remove();
    } else {
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context).insert(_overlayEntry!);
      setState(() => _isOpen = true);
      widget.animationController.forward();
    }
  }

  double get _dropdownWidth =>
      MediaQuery.of(context).size.shortestSide > 600 ? 210.w : 250.w;

  Widget _buildChildProfile(
    ChildEntity child, {
    bool selected = false,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: SizedBox(
        height: 65.h,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildChildAvatar(child),
            SizedBox(
              width: 10.w,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextNoTr(
                  child.name!,
                  fontSize: 19,
                  color: selected ? Colors.white : darkBlue,
                ),
                Row(
                  children: [
                    SvgPicture.asset('assets/icons/gem.svg',
                        width: 20.w, height: 25.h),
                    SizedBox(
                      width: 5.w,
                    ),
                    CustomTextNoTr(
                      '0',
                      fontSize: 19,
                      color: selected ? Colors.white : darkBlue,
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChildAvatar(ChildEntity child) {
    return AvatarBuilder(
      child.name!,
      avatarEntity: child.avatar,
      width: 56,
    );
  }

  Widget _buildAllTasksWidget({
    bool selected = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: SizedBox(
        height: 64.h,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/icons/person.svg',
                width: 60.w,
                height: 60.w,
                colorFilter: ColorFilter.mode(
                  selected ? Colors.white : darkBlue,
                  BlendMode.srcIn,
                )),
            SizedBox(
              width: 10.w,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  LocaleKeys.allTasks,
                  fontSize: 18,
                  color: selected ? Colors.white : darkBlue,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// DropdownItem is just a wrapper for each child in the dropdown list.\n
/// It holds the value of the item.
// class DropdownItem<T> extends StatelessWidget {
//   final T? value;
//   final Widget child;

//   const DropdownItem({Key? key, this.value, required this.child})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return child;
//   }
// }

// class DropdownButtonStyle {
//   final MainAxisAlignment? mainAxisAlignment;
//   final ShapeBorder? shape;
//   final double elevation;
//   final Color? backgroundColor;
//   final EdgeInsets? padding;
//   final BoxConstraints? constraints;
//   final double? width;
//   final double? height;
//   final Color? primaryColor;

//   const DropdownButtonStyle({
//     this.mainAxisAlignment,
//     this.backgroundColor,
//     this.primaryColor,
//     this.constraints,
//     this.height,
//     this.width,
//     this.elevation = 0,
//     this.padding,
//     this.shape,
//   });
// }

// class DropdownStyle {
//   final double? elevation;
//   final Color? color;
//   final EdgeInsets? padding;
//   final BoxConstraints? constraints;
//   final Color? scrollbarColor;

//   /// Add shape and border radius of the dropdown from here
//   final ShapeBorder? shape;

//   /// position of the top left of the dropdown relative to the top left of the button
//   final Offset? offset;

//   ///button width must be set for this to take effect
//   final double? width;

//   const DropdownStyle({
//     this.constraints,
//     this.offset,
//     this.width,
//     this.elevation,
//     this.shape,
//     this.color,
//     this.padding,
//     this.scrollbarColor,
//   });
// }
