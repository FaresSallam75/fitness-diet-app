import 'package:flutter/material.dart';
import 'package:ordering_app/constants/images_asset.dart';
import 'package:ordering_app/constants/colors.dart';
import 'package:ordering_app/presentation/widgets/auth/customtext.dart';

class ArmsWorkout extends StatefulWidget {
  const ArmsWorkout({super.key});

  @override
  State<ArmsWorkout> createState() => _ArmsWorkoutState();
}

class _ArmsWorkoutState extends State<ArmsWorkout> {
  List<String> listArmsWorkout = [
    AppImagesAssets.arm_1,
    AppImagesAssets.arm_2,
    AppImagesAssets.arm_3,
    AppImagesAssets.arm_4,
    AppImagesAssets.arm_5,
    AppImagesAssets.arm_6,
    AppImagesAssets.arm_7,
    AppImagesAssets.arm_8,
    AppImagesAssets.arm_9,
    AppImagesAssets.arm_10,
    AppImagesAssets.arm_11,
    AppImagesAssets.arm_12,
    AppImagesAssets.arm_13,
    AppImagesAssets.arm_14,
    AppImagesAssets.arm_15,
    AppImagesAssets.arm_16,
    AppImagesAssets.arm_17,
    AppImagesAssets.arm_18,
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Biceps & Triceps Workout"),
        titleTextStyle: theme.appBarTheme.titleTextStyle,
        iconTheme: theme.iconTheme,
      ),

      body: Column(
        children: [
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              customTraining("3", theme),
              customTraining("12", theme),
              customTraining("30", theme),
            ],
          ),
          SizedBox(height: 10.0),
          Expanded(
            child: GridView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: ClampingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
                childAspectRatio: 1.0,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
              ),
              itemCount: listArmsWorkout.length,
              itemBuilder: (context, index) => Container(
                color: MyColors.grey03,
                height: 150,
                width: size.width,
                child: Image.asset(listArmsWorkout[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget customTraining(String text, ThemeData theme) {
    return Container(
      height: 50.0,
      width: 50.0,
      decoration: BoxDecoration(
        color: MyColors.grey01,
        borderRadius: BorderRadius.circular(50.0),
      ),
      child: CustomText(
        title: text,
        textStyle: theme.textTheme.headlineSmall,
        textAlign: TextAlign.center,
        padding: EdgeInsets.only(top: 15.0),
      ),
    );
  }
}
