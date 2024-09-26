import 'package:flutter/material.dart';

class CommonTextFormField extends StatelessWidget {
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String? hintText;
  final FocusNode? focusNode;

  const CommonTextFormField({
    this.hintText,
    this.controller,
    this.keyboardType,
    this.focusNode,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      cursorHeight: 14,
      textAlignVertical: TextAlignVertical.center,
      textCapitalization: TextCapitalization.sentences,
      keyboardType: keyboardType,
      controller: controller,
      cursorWidth: 1,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        helperMaxLines: 1,
        contentPadding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
        hintText: hintText,
        counterText: '',
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.black,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.black,
          ),
        ),
        // errorBorder: errorBorder
      ),
    );
  }
}
