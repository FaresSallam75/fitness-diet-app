import 'package:flutter/material.dart';
import 'package:ordering_app/constants/images_asset.dart';
import 'package:ordering_app/constants/colors.dart' show MyColors;
import 'package:ordering_app/presentation/widgets/auth/customtext.dart';

class BackExercise extends StatefulWidget {
  const BackExercise({super.key});

  @override
  State<BackExercise> createState() => _BackExerciseState();
}

class _BackExerciseState extends State<BackExercise> {
  List<String> listBackWorkout = [
    AppImagesAssets.back_1,
    AppImagesAssets.back_2,
    AppImagesAssets.back_3,
    AppImagesAssets.back_4,
    AppImagesAssets.back_5,
    AppImagesAssets.back_6,
    AppImagesAssets.back_7,
    AppImagesAssets.back_8,
    AppImagesAssets.back_9,
    AppImagesAssets.back_10,
    AppImagesAssets.back_11,
    AppImagesAssets.back_12,
    AppImagesAssets.back_13,
    AppImagesAssets.back_14,
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Back Workout"),
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
              itemCount: listBackWorkout.length,
              itemBuilder: (context, index) => Container(
                color: MyColors.grey03,
                height: 150,
                width: size.width,
                child: Image.asset(listBackWorkout[index]),
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
