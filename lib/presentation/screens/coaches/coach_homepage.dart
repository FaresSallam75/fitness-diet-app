import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ordering_app/business_logic/auth/login_cubit.dart';
import 'package:ordering_app/constants/images_asset.dart';
import 'package:ordering_app/constants/colors.dart';
import 'package:ordering_app/constants/fcmc.config.dart';
import 'package:ordering_app/constants/routes.dart';
import 'package:ordering_app/core/services/get_it_services.dart';
import 'package:ordering_app/data/repositary/auth_repository.dart';
import 'package:ordering_app/presentation/screens/chat/local_notification.dart';
import 'package:ordering_app/presentation/screens/coaches/coach_card_chat.dart';
import 'package:ordering_app/presentation/screens/coaches/settings.dart';

class CoachHomePage extends StatefulWidget {
  const CoachHomePage({super.key});

  @override
  State<CoachHomePage> createState() => _CoachHomePageState();
}

class _CoachHomePageState extends State<CoachHomePage> {
  int _selectedIndex = 0;
  String? coachId;
  String? currentPage;
  bool _isVisible = false;
  NotificationService notificationService = NotificationService();

  final List<Widget> _screens = [
    // BlocProvider(
    //   create: (context) => ChatCubit(GetItServices.getIt<ChatRepository>()),
    //   child: CoachCardChat(),
    // ),
    CoachCardChat(),
    BlocProvider(
      create: (context) => LoginCubit(GetItServices.getIt<AuthRepositary>()),
      child: CoachProfile(),
    ),
  ];

  final List<String> _titles = ["Chats", "Profile"];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    requestPermissionNotifications();
    openFcmsConfigration();
    backgroundFcmsConfigration();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      getCoachData();
      final route = ModalRoute.of(context);
      if (route != null && route.isCurrent) {
        currentPage = route.settings.name ?? "unknown";
        _isVisible = true;
        debugPrint("📍 Current page (init):======== $currentPage");
      }
    });
  }

  void getCoachData() async {
    // SecureStorage storage = GetItServices.getIt<SecureStorage>();
    final jsonString = await GetItServices.secureStorage.getCoachData();
    if (jsonString != null) {
      final map = jsonDecode(jsonString);
      coachId = map['id'].toString();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final route = ModalRoute.of(context);
    final routeName = route?.settings.name ?? "";
    final isNowVisible = route?.isCurrent ?? false;

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

  void openFcmsConfigration() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        if (currentPage == "/coachHomePage" || currentPage == "/homeScreen") {
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
            "id": message.data['reciever'] == coachId
                ? message.data['userId']
                : message.data['reciever'],
            "name": message.data['name'],
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_selectedIndex]),
        titleTextStyle: theme.appBarTheme.titleTextStyle,
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
            icon: Icon(Icons.chat_bubble_outlined),
            label: "Chats",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Profile"),
        ],
      ),
    );
  }
}
