import 'package:flutter/material.dart';
import 'package:ordering_app/constants/images_asset.dart';
import 'package:ordering_app/constants/colors.dart';
import 'package:ordering_app/presentation/widgets/auth/customtext.dart';

class CardioWorkout extends StatefulWidget {
  const CardioWorkout({super.key});

  @override
  State<CardioWorkout> createState() => _CardioWorkoutState();
}

class _CardioWorkoutState extends State<CardioWorkout> {
  List<String> listCardioWorkout = [
    AppImagesAssets.cardio_1,
    AppImagesAssets.cardio_2,
    AppImagesAssets.cardio_3,
    AppImagesAssets.cardio_4,
    AppImagesAssets.cardio_5,
    AppImagesAssets.cardio_6,
    AppImagesAssets.cardio_7,
    AppImagesAssets.cardio_8,
    AppImagesAssets.cardio_9,
    AppImagesAssets.cardio_10,
    AppImagesAssets.cardio_11,
    AppImagesAssets.cardio_12,
    AppImagesAssets.cardio_13,
    AppImagesAssets.cardio_14,
    AppImagesAssets.cardio_15,
    AppImagesAssets.cardio_16,
    AppImagesAssets.cardio_17,
    AppImagesAssets.cardio_18,
    AppImagesAssets.cardio_19,
    AppImagesAssets.cardio_20,
    AppImagesAssets.cardio_21,
    AppImagesAssets.cardio_22,
    AppImagesAssets.cardio_23,
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cardio Workout"),
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
              itemCount: listCardioWorkout.length,
              itemBuilder: (context, index) => Container(
                color: MyColors.grey03,
                height: 150,
                width: size.width,
                child: Image.asset(listCardioWorkout[index]),
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
