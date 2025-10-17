import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ordering_app/constants/colors.dart';
import 'package:ordering_app/presentation/widgets/auth/customtext.dart';

class CustomTextFormFieldDetails extends StatelessWidget {
  final String hintText;
  final String prefixText;
  final TextEditingController controller;
  final void Function(String)? onChanged;
  final TextStyle? style;
  const CustomTextFormFieldDetails({
    super.key,
    required this.hintText,
    required this.prefixText,
    required this.controller,
    required this.onChanged,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.0,
      child: TextFormField(
        style: style,
        onChanged: onChanged,
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
          hintText: hintText,
          hintStyle: GoogleFonts.questrial(
            textStyle: TextStyle(
              color: MyColors.greyLight,
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
            ),
          ),
          suffixIcon: prefixText != ""
              ? customText(
                  prefixText,
                  MyColors.greyDark,
                  EdgeInsets.only(top: 15.0),
                  textAlign: TextAlign.center,
                )
              : null,
          border: OutlineInputBorder(
            gapPadding: 8.0,
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(width: 1.0, color: MyColors.grey03),
          ),
        ),
      ),
    );
  }

  Widget customText(
    String text,
    Color color,
    EdgeInsetsGeometry? padding, {
    TextAlign? textAlign,
  }) {
    return CustomText(
      textAlign: textAlign,
      title: text,
      padding: padding,
      textStyle: GoogleFonts.poppins(
        textStyle: TextStyle(
          color: color,
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
