import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:ordering_app/business_logic/coaches/coache_cubit.dart';
import 'package:ordering_app/constants/images_asset.dart';
import 'package:ordering_app/constants/colors.dart';
import 'package:ordering_app/constants/fcmc.config.dart';
import 'package:ordering_app/constants/routes.dart';
import 'package:ordering_app/core/services/get_it_services.dart';
import 'package:ordering_app/data/repositary/coaches_repository.dart';
import 'package:ordering_app/presentation/screens/chat/local_notification.dart';
import 'package:ordering_app/presentation/screens/coaches/coaches.dart';
import 'package:ordering_app/presentation/screens/home/details.dart';
import 'package:ordering_app/presentation/screens/settings.dart';
import 'package:ordering_app/presentation/screens/workout/workout.dart';
import 'package:ordering_app/presentation/screens/home/menu.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  String? currentPage;
  bool _isVisible = false;

  NotificationService notificationService = NotificationService();

  final List<Widget> _screens = [
    MenuScreen(),
    UserDetails(),
    Workout(),
    // CoachesScreen(),
    BlocProvider(
      create: (context) => CoachCubit(GetItServices.getIt<CoachesRepository>()),
      child: const CoachesScreen(),
    ),
    Settings(),
  ];

  final List<String> _titles = [
    "Meals", //Create your order
    "BMI",
    "Workout",
    "Coaches",
    "Settings",
  ];

  @override
  void initState() {
    super.initState();
    requestPermissionNotifications();
    openFcmsConfigration();
    backgroundFcmsConfigration();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   final route = ModalRoute.of(context);
    //   if (route != null && route.isCurrent) {
    //     currentPage = route.settings.name ?? "unknown";
    //     _isVisible = true;
    //     debugPrint("📍 Current page (init): $currentPage");
    //   }
    // });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final route = ModalRoute.of(context);
    final routeName = route?.settings.name ?? "unknown";
    final isNowVisible = route?.isCurrent ?? false;

    debugPrint("🔄 didChangeDependencies: $routeName, visible: $isNowVisible");

    if (routeName == AppRoutes.chatScreen) {
      if (_isVisible) {
        _isVisible = false;
        currentPage = "";
        debugPrint("🚫 Forced invisible page: $routeName");
      }
      return;
    }

    if (isNowVisible && !_isVisible) {
      _isVisible = true;
      currentPage = routeName;
      debugPrint("✅ Page became visible: $currentPage");
    } else if (!isNowVisible && _isVisible) {
      _isVisible = false;
      currentPage = "";
      debugPrint("🚫 Page hidden, currentPage reset");
    }
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   final route = ModalRoute.of(context);
  //   final routeName = route?.settings.name ?? "unknown";
  //   final isNowVisible = route?.isCurrent ?? false;
  //   debugPrint(
  //     "🔄 didChangeDependencies called. Route: $routeName, isNowVisible: $isNowVisible",
  //   );
  //   if (routeName == AppRoutes.chatScreen) {
  //     if (_isVisible) {
  //       _isVisible = false;
  //       currentPage = "";
  //       debugPrint("🚫 Forced invisible page: $routeName");
  //     }
  //     return;
  //   }
  //   if (isNowVisible && !_isVisible) {
  //     _isVisible = true;
  //     currentPage = routeName;
  //     debugPrint("✅ Page became visible: $currentPage");
  //   } else if (!isNowVisible && _isVisible) {
  //     _isVisible = false;
  //     currentPage = "";
  //     debugPrint("🚫 Page hidden, currentPage reset");
  //   }
  // }

  void openFcmsConfigration() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        if (currentPage == "/homeScreen") {
          notificationService.showNotification(
            id: 0,
            title: "${message.notification!.title}",
            body: "${message.notification!.body}",
            payload: "event_payload",
            imageUrl: AppImagesAssets.notificationLogo,
          );
        }
      }
    });
  }

  void backgroundFcmsConfigration() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (mounted) {
        Navigator.of(context).pushNamed(
          AppRoutes.chatScreen,
          arguments: {
            "id": message.data['reciever'],
            "name": message.data['name'],
          },
        );
      }
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return OfflineBuilder(
      connectivityBuilder:
          (
            BuildContext context,
            List<ConnectivityResult> connectivity,
            Widget child,
          ) {
            final bool connected = !connectivity.contains(
              ConnectivityResult.none,
            );
            if (!connected) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                // final messenger = ScaffoldMessenger.maybeOf(context);
                // if (messenger != null && mounted) {
                //   messenger.showSnackBar(
                //     const SnackBar(content: Text("No internet connection")),
                //   );
                // }
                if (mounted) {
                  customShowAlertDialog(
                    context,
                    "Connection Failed",
                    "Please Check Your Internet Connection",
                    "OK",
                    "Setting",
                    () {
                      Navigator.of(context).pop();
                    },
                    () {
                      AppSettings.openAppSettings(type: AppSettingsType.wifi);
                      Navigator.of(context).pop();
                    },
                  );
                }
              });

              return Scaffold(
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.signal_wifi_off, size: 60, color: Colors.grey),
                      SizedBox(height: 16),
                      Text(
                        'No Internet Connection',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              );
            }
            return child;
          },

      child: customBodyScreen(theme),
    );
  }

  Widget customBodyScreen(ThemeData theme) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_selectedIndex]),
        titleTextStyle: theme.appBarTheme.titleTextStyle,
        // backgroundColor: MyColors.orange,
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: MyColors.orange,
        unselectedItemColor: MyColors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu_outlined),
            label: "Menu",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center_sharp),
            label: "BMI",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.sports), label: "Workout"),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: "Coaches"),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
      ),
    );
  }

  Future<void> customShowAlertDialog(
    BuildContext context,
    String title,
    String content,
    String textOkButton,
    String textCancelButton, [
    final void Function()? onPressedOk,
    final void Function()? onPressedCancel,
  ]) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: MyColors.white,
          title: Text(textAlign: TextAlign.center, title),
          content: Text(content),
          actions: [
            ElevatedButton(onPressed: onPressedOk, child: Text(textOkButton)),
            const SizedBox(width: 50.0),
            ElevatedButton(
              onPressed: onPressedCancel,
              child: Text(textCancelButton),
            ),
          ],
        );
      },
    );
  }
}
