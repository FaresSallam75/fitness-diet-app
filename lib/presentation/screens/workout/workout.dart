import 'package:flutter/material.dart';
import 'package:ordering_app/constants/images_asset.dart';
import 'package:ordering_app/constants/colors.dart';
import 'package:ordering_app/constants/routes.dart';
import 'package:ordering_app/presentation/screens/workout/diet.dart';
import 'package:ordering_app/presentation/widgets/menu/custom_text.dart';

class Workout extends StatefulWidget {
  const Workout({super.key});

  @override
  State<Workout> createState() => _WorkoutState();
}

class _WorkoutState extends State<Workout> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
      child: GridView(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.9,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
        children: [
          customCardData(theme, AppImagesAssets.diet, "Diet Plan", () {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => DietPlansScreen()));
          }),
          customCardData(theme, AppImagesAssets.cardio, "Cardio", () {
            Navigator.of(context).pushNamed(AppRoutes.cardioWorkout);
          }),
          customCardData(theme, AppImagesAssets.chest, "Chest", () {
            Navigator.of(context).pushNamed(AppRoutes.chestWorkout);
          }),
          customCardData(theme, AppImagesAssets.back, "Back", () {
            Navigator.of(context).pushNamed(AppRoutes.backWorkout);
          }),
          customCardData(theme, AppImagesAssets.sholder, "Sholders", () {
            Navigator.of(context).pushNamed(AppRoutes.sholderWorkout);
          }),
          customCardData(theme, AppImagesAssets.arm, "Arms", () {
            Navigator.of(context).pushNamed(AppRoutes.armWorkout);
          }),
          customCardData(theme, AppImagesAssets.leg, "Legs", () {
            Navigator.of(context).pushNamed(AppRoutes.legWorkout);
          }),
        ],
      ),
    );
  }

  Widget customCardData(
    ThemeData theme,
    String image,
    String exerciseName,
    Function()? onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: MyColors.grey03,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              flex: 2,
              child: Image.asset(
                image,
                height: 120.0,
                width: 150.0,
                fit: BoxFit.fitHeight,
              ),
            ),
            Expanded(
              child: CustomMenuText(
                textAlign: TextAlign.center,
                text: exerciseName,
                textStyle: theme.textTheme.headlineMedium!.copyWith(),
                padding: const EdgeInsets.all(0.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
