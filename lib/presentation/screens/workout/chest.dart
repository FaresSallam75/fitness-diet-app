import 'package:flutter/material.dart';
import 'package:ordering_app/constants/images_asset.dart';
import 'package:ordering_app/constants/colors.dart';
import 'package:ordering_app/presentation/widgets/auth/customtext.dart';

class ChestWorkout extends StatefulWidget {
  const ChestWorkout({super.key});

  @override
  State<ChestWorkout> createState() => _ChestState();
}

class _ChestState extends State<ChestWorkout> {
  List<String> listChestWorkout = [
    AppImagesAssets.chest_1,
    AppImagesAssets.chest_2,
    AppImagesAssets.chest_3,
    AppImagesAssets.chest_4,
    AppImagesAssets.chest_5,
    AppImagesAssets.chest_6,
    AppImagesAssets.chest_7,
    AppImagesAssets.chest_8,
    AppImagesAssets.chest_9,
    AppImagesAssets.chest_10,
    AppImagesAssets.chest_11,
    AppImagesAssets.chest_12,
    AppImagesAssets.chest_13,
    AppImagesAssets.chest_14,
    AppImagesAssets.chest_15,
    AppImagesAssets.chest_16,
    AppImagesAssets.chest_17,
    AppImagesAssets.chest_18,
    AppImagesAssets.chest_19,
    AppImagesAssets.chest_20,
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chest Workout"),
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
              itemCount: listChestWorkout.length,
              itemBuilder: (context, index) => Container(
                color: MyColors.grey03,
                height: 150,
                width: size.width,
                child: Image.asset(listChestWorkout[index]),
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
