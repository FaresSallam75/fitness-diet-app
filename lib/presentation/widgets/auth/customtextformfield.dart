// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String? labelText;
  final TextInputType? keyboardType;
  final IconData? icon;
  final bool? obscureText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final TextEditingController? controller;

  const CustomTextFormField({
    super.key,
    required this.labelText,
    required this.keyboardType,
    required this.icon,
    required this.obscureText,
    required this.suffixIcon,
    required this.validator,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context).textTheme;
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: controller,
            obscureText: obscureText!,
            validator: validator,
            style: themeData.headlineSmall,
            decoration: InputDecoration(
              prefixIcon: Icon(icon),
              labelText: labelText,
              labelStyle: themeData.headlineMedium,
              suffixIcon: suffixIcon,
            ),
            keyboardType: keyboardType,
          ),
        ),
      ],
    );
  }
}

// TextFormField(
//               textAlign: TextAlign.start,
//               validator: validator,
//               controller: myController,
//               keyboardType: TextInputType.multiline,
//               style: kTitleStyle, //heme.of(context).textTheme.headlineSmall,
//               obscureText: obscureText,
//               decoration: InputDecoration(
//                 suffixIcon: IconButton(
//                   onPressed: onPressedIcon,
//                   icon: Icon(iconData),
//                 ),
//                 hintText: hintText,
//                 hintStyle: kTitleStyle.copyWith(fontSize: 18.0),

//                 border: InputBorder.none,
//                 focusedBorder: const OutlineInputBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(30.0)),
//                   borderSide: BorderSide(color: Colors.blue),
//                 ),
//                 contentPadding: const EdgeInsets.symmetric(
//                   vertical: 10,
//                   horizontal: 12,
//                 ),
//               ),
//             ),
