import 'package:flutter/material.dart';
import 'package:ordering_app/constants/images_asset.dart';
import 'package:ordering_app/constants/colors.dart';
import 'package:ordering_app/presentation/widgets/auth/customtext.dart';

class LegsWorkout extends StatefulWidget {
  const LegsWorkout({super.key});

  @override
  State<LegsWorkout> createState() => _LegsWorkoutState();
}

class _LegsWorkoutState extends State<LegsWorkout> {
  List<String> listLegsWorkout = [
    AppImagesAssets.leg,
    AppImagesAssets.leg_1,
    AppImagesAssets.leg_2,
    AppImagesAssets.leg_3,
    AppImagesAssets.leg_4,
    AppImagesAssets.leg_5,
    AppImagesAssets.leg_6,
    AppImagesAssets.leg_7,
    AppImagesAssets.leg_8,
    AppImagesAssets.leg_9,
    AppImagesAssets.leg_10,
    AppImagesAssets.leg_11,
    AppImagesAssets.leg_12,
    AppImagesAssets.leg_13,
    AppImagesAssets.leg_14,
    AppImagesAssets.leg_15,
    AppImagesAssets.leg_16,
    AppImagesAssets.leg_17,
    AppImagesAssets.leg_18,
    AppImagesAssets.leg_19,
    AppImagesAssets.leg_20,
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Legs Workout"),
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
              itemCount: listLegsWorkout.length,
              itemBuilder: (context, index) => Container(
                color: MyColors.grey03,
                height: 150,
                width: size.width,
                child: Image.asset(listLegsWorkout[index]),
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
