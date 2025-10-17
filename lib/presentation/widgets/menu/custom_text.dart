import 'package:flutter/material.dart';
import 'package:ordering_app/presentation/widgets/auth/customtext.dart';

class CustomMenuText extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final EdgeInsetsGeometry padding;
  final TextAlign? textAlign;

  const CustomMenuText({
    super.key,
    required this.text,
    required this.textStyle,
    required this.padding,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return CustomText(
      title: text,
      textAlign: textAlign,
      padding: padding,
      textStyle: textStyle,
    );
  }
}
