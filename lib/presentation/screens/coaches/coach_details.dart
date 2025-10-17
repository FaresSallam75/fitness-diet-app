import 'package:flutter/material.dart';
import 'package:ordering_app/constants/images_asset.dart';
import 'package:ordering_app/constants/colors.dart';
import 'package:ordering_app/constants/routes.dart';
import 'package:ordering_app/presentation/widgets/auth/customtext.dart';
import 'package:url_launcher/url_launcher.dart';

class CoachDetails extends StatefulWidget {
  final String id;
  final String name;
  final String image;
  final String phone;
  const CoachDetails({
    super.key,
    required this.id,
    required this.name,
    required this.image,
    required this.phone,
  });

  @override
  State<CoachDetails> createState() => _CoachDetailsState();
}

class _CoachDetailsState extends State<CoachDetails> {
  @override
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: CustomText(title: "Coach Details"),
        titleTextStyle: theme.appBarTheme.titleTextStyle,
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 10.0, vertical: 15.0),
        child: Column(
          children: [
            SizedBox(
              height: 150,
              child: FadeInImage.assetNetwork(
                height: 150.0,
                width: size.width,
                placeholder: AppImagesAssets.loading,
                image: widget.image,
                fit: BoxFit.contain,
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    AppImagesAssets.loading,
                    width: 100,
                    height: 100,
                    fit: BoxFit.contain,
                  );
                },
              ),
            ),

            CustomText(
              title: "Coach: ${widget.name}",
              padding: EdgeInsets.symmetric(vertical: 10.0),
            ),

            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        AppRoutes.chatScreen,
                        arguments: {"id": widget.id, "name": widget.name},
                      );
                    },
                    child: SizedBox(
                      height: 80.0,
                      child: Card(
                        color: MyColors.blueLight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.chat_bubble_outlined,
                              color: MyColors.whiteObasity,
                            ),
                            SizedBox(width: 10.0),
                            CustomText(
                              title: "Chat",
                              textStyle: theme.textTheme.headlineMedium!
                                  .copyWith(color: MyColors.whiteObasity),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      //  await launchUrl(Uri.parse("tel:00201062873239"));
                      if (!await launchUrl(
                        Uri.parse('tel:002${widget.phone}'),
                      )) {
                        throw Exception(
                          'Could not launch ${Uri.parse('tel:002${widget.phone}')}',
                        );
                      }
                    },
                    child: SizedBox(
                      height: 80.0,
                      child: Card(
                        color: MyColors.orange,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.phone, color: MyColors.whiteObasity),
                            SizedBox(width: 10.0),
                            CustomText(
                              title: "Phone",
                              textStyle: theme.textTheme.headlineMedium!
                                  .copyWith(color: MyColors.whiteObasity),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            CustomText(
              padding: EdgeInsets.symmetric(vertical: 15.0),
              textAlign: TextAlign.justify,
              textStyle: theme.textTheme.headlineSmall!.copyWith(
                color: MyColors.grey,
              ),

              title:
                  "I’m a personal trainer who helps people get fit, stay healthy, and feel confident. I create simple workout plans and give guidance on healthy habits that match your lifestyle and goals. Whether you want to lose weight, build strength, or just improve your fitness, I’ll support and motivate you every step of the way.",
            ),
          ],
        ),
      ),
    );
  }
}
