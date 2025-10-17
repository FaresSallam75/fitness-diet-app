import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:multi_payment_gateway/stripe_setup.dart';
import 'package:ordering_app/business_logic/theme/theme_cubit.dart';
import 'package:ordering_app/business_logic/theme/theme_state.dart';
import 'package:ordering_app/constants/localization.dart';
import 'package:ordering_app/core/app/user_app.dart';
import 'package:ordering_app/core/dio_services/dio.dart';
import 'package:ordering_app/core/routes/app_route.dart';
import 'package:ordering_app/core/services/get_it_services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ordering_app/firebase_options.dart';
import 'package:ordering_app/presentation/screens/chat/local_notification.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:developer';


Box? myBox;
Future<Box> initBoxHive(String boxName) async {
  if (!Hive.isBoxOpen(boxName)) {
    log("Box is not open");
    Hive.init((await getApplicationDocumentsDirectory()).path);
  } else {
    log("Box is already open");
  }
  return Hive.openBox(boxName);
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  NotificationService notificationService = NotificationService();
  if (message.notification != null) {
    await notificationService.showNotification(
      id: 2,
      title: message.notification?.title ?? "Background Message",
      body: message.notification?.body ?? "",
      payload: "background",
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  GetItServices.setup();
  await Future.wait([
    UserApp.userIsAuthorized(),
    CoachApp.coachIsAuthorized(),
    DioService.init(),
  ]);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  myBox = await initBoxHive("fares");
  if (!myBox!.containsKey("isDark")) {
    myBox!.put("isDark", false); // Default to light theme
  }
  StripeSetup.setup(
    publishableKey:
    String.fromEnvironment('STRIPE_SECRET_KEY'),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppSettingsCubit(),
      child: BlocBuilder<AppSettingsCubit, AppSettingsState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            debugShowMaterialGrid: false,
            locale: state.locale,
            theme: state.themeData,
            themeAnimationCurve: Curves.fastOutSlowIn,
            themeAnimationDuration: const Duration(milliseconds: 1500),
            supportedLocales: const [Locale('en'), Locale('ar')],
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            onGenerateRoute: AppRouter().generateRoute,
          );
        },
      ),
    );
  }
}
