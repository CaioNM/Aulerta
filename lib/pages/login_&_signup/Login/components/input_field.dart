import 'package:aulerta_final/utils/constans.dart';
import 'package:aulerta_final/utils/text_field_container.dart';
import 'package:flutter/material.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const RoundedInputField({
    super.key,
    required this.hintText,
    this.icon = Icons.person,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
            hintText: hintText,
            border: InputBorder.none,
            icon: Icon(
              icon,
              color: kPrimaryColor,
            )),
      ),
    );
  }
}

