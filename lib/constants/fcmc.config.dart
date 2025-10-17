import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:ordering_app/business_logic/chat/chat_cubit.dart';

void requestPermissionNotifications() async {
  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
}

void fcmsConfigration(
  ChatCubit cubit,
  String currentPageName,
  String reciever,
  context,
) {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    // print("==================== Notifications  ================");
    // print(message.notification!.title);
    // print(message.notification!.body);
    // NotificationService notificationService = NotificationService();
    // FlutterRingtonePlayer flutterRingtonePlayer = FlutterRingtonePlayer();
    // flutterRingtonePlayer.playNotification();

    // if (message.data['pagename'] == currentPageName) {}
    // notificationService.showNotification(
    //   id: 0,
    //   title: "${message.notification!.title}",
    //   body: "${message.notification!.body}",
    //   payload: "event_payload",
    // );

    refreshChatPage(message.data, cubit, currentPageName, reciever, context);
  });

  // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  //   NotificationService notificationService = NotificationService();
  //   notificationService.showNotification(
  //     id: 0,
  //     title: "${message.notification!.title}",
  //     body: "${message.notification!.body}",
  //     payload: "event_payload",
  //     imageUrl: AppImagesAssets.notificationLogo,
  //   );
  //   Navigator.of(context).pushNamed(AppRoutes.chatScreen);
  // });
}

void refreshChatPage(
  Map data,
  ChatCubit cubit,
  String currentPageName,
  String reciever,
  context,
) {
  log("data['pagename'] ===================== ${data['pagename']}");
  log("data =========================== $data");
  if (data['pagename'] == currentPageName) {
    cubit.getAllChats(reciever);
  }
}


// ScaffoldMessenger.of(
      // ignore: use_build_context_synchronously
      //   context,
      // ).showSnackBar(SnackBar(content: Text(message.notification!.title!)));