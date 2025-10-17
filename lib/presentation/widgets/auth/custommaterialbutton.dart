import 'package:flutter/material.dart';

class CustomMaterialButton extends StatelessWidget {
  final Color? color;
  final double? height;
  final double? minWidth;
  final void Function()? onPressed;
  final Widget? child;
  final double radius;
  const CustomMaterialButton({
    super.key,
    required this.color,
    required this.height,
    required this.minWidth,
    required this.onPressed,
    required this.child,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        height: height,
        color: color,
        minWidth: minWidth,
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
