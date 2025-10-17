import 'package:flutter/material.dart';
import 'package:ordering_app/constants/images_asset.dart';
import 'package:ordering_app/constants/colors.dart';
import 'package:ordering_app/presentation/widgets/auth/customtext.dart';

class SholderWorkout extends StatefulWidget {
  const SholderWorkout({super.key});

  @override
  State<SholderWorkout> createState() => _SholderWorkoutState();
}

class _SholderWorkoutState extends State<SholderWorkout> {
  List<String> listSholderWorkout = [
    AppImagesAssets.sholder,
    AppImagesAssets.sholder_1,
    AppImagesAssets.sholder_2,
    AppImagesAssets.sholder_3,
    AppImagesAssets.sholder_4,
    AppImagesAssets.sholder_5,
    AppImagesAssets.sholder_6,
    AppImagesAssets.sholder_7,
    AppImagesAssets.sholder_8,
    AppImagesAssets.sholder_9,
    AppImagesAssets.sholder_10,
    AppImagesAssets.sholder_11,
    AppImagesAssets.sholder_12,
    AppImagesAssets.sholder_13,
    AppImagesAssets.sholder_14,
    AppImagesAssets.sholder_15,
    AppImagesAssets.sholder_16,
    AppImagesAssets.sholder_17,
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sholder Workout"),
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
              itemCount: listSholderWorkout.length,
              itemBuilder: (context, index) => Container(
                color: MyColors.grey03,
                height: 150,
                width: size.width,
                child: Image.asset(listSholderWorkout[index]),
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
