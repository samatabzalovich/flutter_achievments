// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/common/widgets/custom_text.dart';
import 'package:flutter_achievments/core/constant/colors.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.labelText,
    required this.focusNode,
    required this.onChanged,
    required this.validator,
    required this.onSubmitted,
    this.prefixIcon,
    required this.isPassword,
    this.borderRadius = 10,
    this.inputType = TextInputType.text,
    this.onInit,
    this.border = false,
  });
  final String labelText;
  final FocusNode focusNode;
  final Function(String) onChanged;
  final bool Function(String) validator;
  final Function(String) onSubmitted;
  final bool isPassword;
  final TextInputType inputType;
  final double borderRadius;
  final Widget? prefixIcon;
  final Function(TextEditingController)? onInit;
  final bool border;
  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool isVisible;
  bool isFocused = false;
  bool isValid = true;
  bool wasValid = true;
  late TextEditingController controller;  
  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(() {
      setState(() {
        isFocused = widget.focusNode.hasFocus;
      });
    });
    isVisible = widget.isPassword;
    controller = TextEditingController();
    widget.onInit?.call(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.focusNode.requestFocus();
      },
      child: Container(
        height: 56,
        decoration: BoxDecoration(
            border: !widget.border ? isValid
                ? isFocused
                    ? Border.all(color: borderBlueColor, width: 1)
                    : Border.all(color: Colors.transparent, width: 1)
                : Border.all(color: redColor, width: 1) : Border.all(color: greyColor, width: 1),
            color: Colors.white,
            borderRadius: BorderRadius.circular(widget.borderRadius)),
        alignment: Alignment.center,
        child: TextFormField(
          controller: controller,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: darkBlue,
          ),
          focusNode: widget.focusNode,
          onChanged: (text) {
            wasValid = isValid;
            isValid = widget.validator(text);
            widget.onChanged(text);
            if (isValid != wasValid) {
              setState(() {});
            }
          },
          onFieldSubmitted: widget.onSubmitted,
          cursorColor: borderBlueColor,
          cursorHeight: 18,
          keyboardType: widget.inputType,
          obscureText: isVisible,
          decoration: InputDecoration(
            prefixIcon: widget.prefixIcon,
            contentPadding: const EdgeInsets.only(left: 16, bottom: 10),
            border: InputBorder.none,
            label: CustomText(
              widget.labelText,
              color: greyColor,
            ),
            suffixIcon: widget.isPassword
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        isVisible = !isVisible;
                      });
                    },
                    icon: Icon(
                      isVisible ? Icons.visibility_off : Icons.visibility,
                      color: greyColor,
                    ),
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
