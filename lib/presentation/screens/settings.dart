import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ordering_app/business_logic/theme/theme_cubit.dart';
import 'package:ordering_app/constants/localization.dart';
import 'package:ordering_app/constants/colors.dart';
import 'package:ordering_app/constants/routes.dart';
import 'package:ordering_app/core/app/user_app.dart';
import 'package:ordering_app/core/services/get_it_services.dart';
import 'package:ordering_app/core/services/secure_storage.dart';
import 'package:ordering_app/main.dart';
import 'package:ordering_app/presentation/widgets/auth/customtext.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    log("Rebuild ===================== ");
    final ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Column(
        children: [
          Center(
            child: CircleAvatar(
              backgroundColor: MyColors.greyDark,
              radius: 70.0,
              child: Icon(Icons.person, size: 50.0, color: MyColors.grey01),
            ),
          ),

          CustomText(
            padding: EdgeInsets.only(top: 10.0),
            title: "${myBox!.get("userName")}",
            textStyle: theme.textTheme.headlineMedium!.copyWith(
              color: (myBox!.get("isDark") ?? false)
                  ? MyColors.whiteObasity
                  : MyColors.black01,
            ),
          ),
          CustomText(
            title: "${myBox!.get("userEmail")}",
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

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LText(
                'monthly_renewal',
                style: theme.textTheme.headlineMedium!.copyWith(
                  color: (myBox!.get("isDark") ?? false)
                      ? MyColors.whiteObasity
                      : MyColors.black01,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.monthlyRenewal);
                },
                icon: Icon(Icons.money_sharp),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LText(
                'offer',
                style: theme.textTheme.headlineMedium!.copyWith(
                  color: (myBox!.get("isDark") ?? false)
                      ? MyColors.whiteObasity
                      : MyColors.black01,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.offerScreen);
                },
                icon: Icon(Icons.local_offer_outlined),
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
                  storage.deleteUserData("userData");
                  myBox!.clear();
                  UserApp.isAuthorized = false;
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
