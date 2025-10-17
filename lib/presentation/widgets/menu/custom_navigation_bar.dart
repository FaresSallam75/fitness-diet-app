import 'package:flutter/material.dart';
import 'package:ordering_app/constants/colors.dart';
import 'package:ordering_app/main.dart';
import 'package:ordering_app/presentation/widgets/auth/custommaterialbutton.dart';
import 'package:ordering_app/presentation/widgets/auth/customtext.dart';

class CustomNavigationBar extends StatelessWidget {
  final String textButton;
  final void Function()? onPressed;
  final ThemeData theme;
  final Size size;
  final int calculateCalrories;
  final int calculatePrice;
  const CustomNavigationBar({
    super.key,
    required this.textButton,
    required this.onPressed,
    required this.theme,
    required this.size,
    required this.calculateCalrories,
    required this.calculatePrice,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 165.0,
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: (myBox!.get("isDark") ?? false)
            ? MyColors.grey01
            : MyColors.whiteObasity,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              customText(
                "Calories",
                theme.textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 16.0,
                ),
                EdgeInsets.all(0.0),
              ),

              customText(
                "$calculateCalrories  Cal out of ${myBox!.get("bmr") ?? "0"} Cal",
                //"1198 Cal out of 1200 Cal",
                theme.textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.w400,
                  color: MyColors.greyLight,
                  fontSize: 14.0,
                ),
                EdgeInsets.all(0.0),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              customText(
                "Price",
                theme.textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 16.0,
                ),
                EdgeInsets.all(0.0),
              ),
              customText(
                "$calculatePrice\$", // Assuming calculatePrice is an int
                // "125\$",
                theme.textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.w400,
                  color: MyColors.orange,
                  fontSize: 16.0,
                ),
                EdgeInsets.all(0.0),
              ),
            ],
          ),
          CustomMaterialButton(
            color: MyColors.orange,
            height: 60.0,
            minWidth: size.width,
            onPressed: onPressed,
            radius: 12.0,
            child: customText(
              textButton,
              theme.textTheme.headlineSmall!.copyWith(color: MyColors.white),
              EdgeInsets.all(0.0),
            ),
          ),
        ],
      ),
    );
  }

  Widget customText(
    String text,
    TextStyle? textStyle,
    EdgeInsetsGeometry? padding, {
    TextAlign? textAlign,
  }) {
    return CustomText(
      title: text,
      textAlign: textAlign,
      padding: padding,
      textStyle: textStyle,
    );
  }
}
