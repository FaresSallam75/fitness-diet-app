import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ordering_app/business_logic/auth/login_cubit.dart';
import 'package:ordering_app/business_logic/theme/theme_cubit.dart';
import 'package:ordering_app/constants/images_asset.dart';
import 'package:ordering_app/constants/localization.dart';
import 'package:ordering_app/constants/colors.dart';
import 'package:ordering_app/constants/routes.dart';
import 'package:ordering_app/core/app/user_app.dart';
import 'package:ordering_app/core/dio_services/api_end_point.dart';
import 'package:ordering_app/core/services/get_it_services.dart';
import 'package:ordering_app/core/services/secure_storage.dart';
import 'package:ordering_app/main.dart';
import 'package:ordering_app/presentation/widgets/auth/customtext.dart';

class CoachProfile extends StatefulWidget {
  const CoachProfile({super.key});

  @override
  State<CoachProfile> createState() => _CoachProfileState();
}

class _CoachProfileState extends State<CoachProfile> {
  String? coachId;
  String? caochName;
  String? caochEmail;
  String? caochPhone;
  String? caochImage;
  SecureStorage storage = GetItServices.getIt<SecureStorage>();

  late TextEditingController name;
  late TextEditingController phone;

  late final LoginCubit loginCubit;

  void getCoachData() async {
    final jsonString = await storage.getCoachData();
    if (jsonString != null) {
      final map = jsonDecode(jsonString);
      coachId = map['id'].toString();
      caochName = map['name'].toString();
      caochEmail = map['email'].toString();
      caochPhone = map['phone'].toString();
      caochImage = map['image'].toString();
      name.text = caochName!;
      phone.text = caochPhone!;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getCoachData();
    loginCubit = context.read<LoginCubit>();
    name = TextEditingController();
    phone = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    log("Rebuild ===================== ");
    final ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: Column(
        children: [
          Stack(
            children: [
              Center(
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: "${ApiEndPoints.coachImages}/$caochImage",
                    width: 140, // قطر الدائرة = 2 * radius
                    height: 140,
                    fit: BoxFit.contain,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Image.asset(
                          AppImagesAssets.loading,
                          width: 100,
                          height: 100,
                          fit: BoxFit.contain,
                        ),
                    //  Cener(
                    //   child: CircularProgressIndicator(
                    //     value: downloadProgress.progress,
                    //   ),
                    // ),
                    errorWidget: (context, url, error) => Container(
                      color: MyColors.grey,
                      width: 140,
                      height: 140,
                      child: Icon(Icons.person, size: 50, color: Colors.white),
                    ),
                  ),
                ),
              ),

              // Positioned(
              //   bottom: -10.0,
              //   right: 135.0,
              //   child: IconButton(
              //     onPressed: () {},
              //     icon: Icon(
              //       size: 25.0,
              //       Icons.add_circle,
              //       color: MyColors.orange,
              //     ),
              //   ),
              // ),
            ],
          ),

          CustomText(
            padding: EdgeInsets.only(top: 10.0),
            title: caochName ?? "",
            textStyle: theme.textTheme.headlineMedium!.copyWith(
              color: (myBox!.get("isDark") ?? false)
                  ? MyColors.whiteObasity
                  : MyColors.black01,
            ),
          ),
          CustomText(
            title: caochEmail ?? "",
            textStyle: theme.textTheme.headlineMedium!.copyWith(
              color: (myBox!.get("isDark") ?? false)
                  ? MyColors.whiteObasity
                  : MyColors.black01,
            ),
          ),
          CustomText(
            title: caochPhone ?? "",
            textStyle: theme.textTheme.headlineMedium!.copyWith(
              color: (myBox!.get("isDark") ?? false)
                  ? MyColors.whiteObasity
                  : MyColors.black01,
            ),
          ),

          SizedBox(height: 20.0),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LText(
                'dark_mode',
                style: theme.textTheme.headlineMedium!.copyWith(
                  color: (myBox!.get("isDark") ?? false)
                      ? MyColors.whiteObasity
                      : MyColors.black01,
                ),
              ),
              IconButton(
                onPressed: () {
                  context.read<AppSettingsCubit>().changeThemeMode();
                },
                icon: Icon(Icons.dark_mode),
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LText(
                'change_language',
                style: theme.textTheme.headlineMedium!.copyWith(
                  color: (myBox!.get("isDark") ?? false)
                      ? MyColors.whiteObasity
                      : MyColors.black01,
                ),
              ),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                transitionBuilder: (child, animation) => RotationTransition(
                  turns: Tween(begin: 0.8, end: 1.0).animate(animation),
                  child: FadeTransition(opacity: animation, child: child),
                ),
                child: IconButton(
                  key: ValueKey(
                    context.read<AppSettingsCubit>().state.locale.languageCode,
                  ),
                  onPressed: () {
                    context.read<AppSettingsCubit>().toggleLanguage();
                  },
                  icon: Icon(
                    Icons.language,
                    color: (myBox!.get("isDark") ?? false)
                        ? MyColors.whiteObasity
                        : MyColors.black01,
                    size: 28,
                  ),
                ),
              ),
            ],
          ),

          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LText(
                'logout',
                style: theme.textTheme.headlineMedium!.copyWith(
                  color: (myBox!.get("isDark") ?? false)
                      ? MyColors.whiteObasity
                      : MyColors.black01,
                ),
              ),
              IconButton(
                onPressed: () {
                  SecureStorage storage = GetItServices.getIt<SecureStorage>();
                  storage.deleteCoachData("coachData");
                  myBox!.clear();
                  CoachApp.isCoachAuthorized = false;
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.login,
                    (route) => false,
                  );
                },
                icon: Icon(Icons.logout),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class LText extends StatelessWidget {
  final String keyString;
  final TextStyle? style;

  const LText(this.keyString, {this.style, super.key});

  @override
  Widget build(BuildContext context) {
    // using key not value
    // Text(AppLocalizations.of(context).translate('change_language')),
    return Text(
      AppLocalizations.of(context).translate(keyString),
      style: style,
    );
  }
}
