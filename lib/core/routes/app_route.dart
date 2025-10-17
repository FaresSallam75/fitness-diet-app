import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ordering_app/business_logic/auth/login_cubit.dart';
import 'package:ordering_app/business_logic/auth/register_cubit.dart';
import 'package:ordering_app/business_logic/chat/chat_cubit.dart';
import 'package:ordering_app/business_logic/menu/menu_cubit.dart';
import 'package:ordering_app/business_logic/monthly_renewal/monthly_renewal_cubit.dart';
import 'package:ordering_app/business_logic/offer/offer_cubit.dart';
import 'package:ordering_app/constants/routes.dart';
import 'package:ordering_app/core/app/user_app.dart';
import 'package:ordering_app/core/routes/base_route.dart';
import 'package:ordering_app/core/services/get_it_services.dart';
import 'package:ordering_app/data/repositary/auth_repository.dart';
import 'package:ordering_app/data/repositary/chat_repository.dart';
import 'package:ordering_app/data/repositary/menu_repository.dart';
import 'package:ordering_app/data/repositary/monthly_renewal_repository.dart';
import 'package:ordering_app/data/repositary/offer_repository.dart';
import 'package:ordering_app/presentation/screens/auth/login.dart';
import 'package:ordering_app/presentation/screens/auth/signup.dart';
import 'package:ordering_app/presentation/screens/chat/chat.dart';
import 'package:ordering_app/presentation/screens/coaches/coach_card_chat.dart';
import 'package:ordering_app/presentation/screens/coaches/coach_homepage.dart';
import 'package:ordering_app/presentation/screens/coaches/coach_details.dart';
import 'package:ordering_app/presentation/screens/monthly_renewal.dart';
import 'package:ordering_app/presentation/screens/offerscreen.dart';
import 'package:ordering_app/presentation/screens/onboarding.dart';
import 'package:ordering_app/presentation/screens/workout/arm.dart';
import 'package:ordering_app/presentation/screens/workout/back.dart';
import 'package:ordering_app/presentation/screens/workout/cardio.dart';
import 'package:ordering_app/presentation/screens/workout/leg.dart';
import 'package:ordering_app/presentation/screens/workout/sholder.dart';
import 'package:ordering_app/presentation/screens/home/cart.dart';
import 'package:ordering_app/presentation/screens/workout/chest.dart';
import 'package:ordering_app/presentation/screens/home/details.dart';
import 'package:ordering_app/presentation/screens/home/home.dart';
import 'package:ordering_app/presentation/screens/home/menu.dart';
import 'package:ordering_app/presentation/screens/workout/workout.dart';

class AppRouter {
  Route<dynamic> generateRoute(RouteSettings settings) {
    final menuCubit = MenuCubit(GetItServices.getIt<MenuRepository>());
    final chatCubit = ChatCubit(GetItServices.getIt<ChatRepository>());

    switch (settings.name) {
      case AppRoutes.boarding:
        return BaseRoute(
          pageBuilder: (_, _, _) {
            if (UserApp.isAuthorized) {
              return Home();
            } else if (CoachApp.isCoachAuthorized) {
              return BlocProvider.value(
                value: chatCubit,
                child: const CoachHomePage(),
              );
            } else {
              return OnBoardingScreen();
            }
          },
        );

      case AppRoutes.homeScreen:
        return BaseRoute(
          settings: const RouteSettings(name: AppRoutes.homeScreen),
          pageBuilder: (_, _, _) =>
              BlocProvider.value(value: menuCubit, child: Home()),
        );

      // ignore: unreachable_switch_case
      case AppRoutes.login:
        return BaseRoute(
          settings: const RouteSettings(name: AppRoutes.login),
          pageBuilder: (_, _, _) => BlocProvider(
            create: (_) => LoginCubit(GetItServices.getIt<AuthRepositary>()),
            child: const Login(),
          ),
        );

      case AppRoutes.register:
        return BaseRoute(
          pageBuilder: (_, _, _) => BlocProvider(
            create: (_) => RegisterCubit(GetItServices.getIt<AuthRepositary>()),
            child: const SignUp(),
          ),
        );

      case AppRoutes.coachHomePage:
        return BaseRoute(
          settings: const RouteSettings(name: AppRoutes.coachHomePage),
          pageBuilder: (_, _, _) => BlocProvider.value(
            value: chatCubit,
            child: const CoachHomePage(),
          ),
        );

      case AppRoutes.chatScreen:
        final args = settings.arguments as Map<String, dynamic>? ?? {};
        final id = args["id"] ?? "";
        final name = args["name"] ?? "";
        return BaseRoute(
          settings: const RouteSettings(name: AppRoutes.chatScreen),
          pageBuilder: (_, _, _) => BlocProvider.value(
            value: chatCubit,
            child: ChatScreen(reciever: id, userName: name),
          ),
        );

      case AppRoutes.coachCardChat:
        return BaseRoute(
          pageBuilder: (_, _, _) => BlocProvider.value(
            value: chatCubit,
            child: const CoachCardChat(),
          ),
        );

      case AppRoutes.menuScreen:
        return BaseRoute(pageBuilder: (_, _, _) => const MenuScreen());

      case AppRoutes.chestWorkout:
        return BaseRoute(pageBuilder: (_, _, _) => const ChestWorkout());

      case AppRoutes.workout:
        return BaseRoute(pageBuilder: (_, _, _) => const Workout());

      case AppRoutes.backWorkout:
        return BaseRoute(pageBuilder: (_, _, _) => const BackExercise());

      case AppRoutes.sholderWorkout:
        return BaseRoute(pageBuilder: (_, _, _) => const SholderWorkout());

      case AppRoutes.armWorkout:
        return BaseRoute(pageBuilder: (_, _, _) => const ArmsWorkout());

      case AppRoutes.legWorkout:
        return BaseRoute(pageBuilder: (_, _, _) => const LegsWorkout());

      case AppRoutes.cardioWorkout:
        return BaseRoute(pageBuilder: (_, _, _) => const CardioWorkout());

      case AppRoutes.coachDetailsScreen:
        final args = settings.arguments as Map<String, dynamic>? ?? {};

        return BaseRoute(
          settings: const RouteSettings(name: AppRoutes.coachDetailsScreen),
          pageBuilder: (_, _, _) => CoachDetails(
            id: args["id"] ?? "",
            name: args["name"] ?? "",
            image: args["image"] ?? "",
            phone: args["phone"] ?? "",
          ),
        );

      case AppRoutes.cartScreen:
        return BaseRoute(
          pageBuilder: (_, _, _) =>
              BlocProvider.value(value: menuCubit, child: const CartScreen()),
        );
      case AppRoutes.offerScreen:
        return BaseRoute(
          pageBuilder: (_, _, _) => BlocProvider(
            create: (context) =>
                OfferCubit(GetItServices.getIt<OfferRepository>()),
            child: const OfferScreen(),
          ),
        );

      case AppRoutes.userDetails:
        return BaseRoute(pageBuilder: (_, _, _) => const UserDetails());
      case AppRoutes.monthlyRenewal:
        return BaseRoute(
          pageBuilder: (_, _, _) => BlocProvider(
            create: (context) => MonthlyRenewalCubit(
              GetItServices.getIt<MonthlyRenewalRepository>(),
            ),
            child: MonthlyRenewal(),
          ),
        );

      default:
        return BaseRoute(
          pageBuilder: (_, _, _) =>
              const Scaffold(body: Center(child: Text('Page not found'))),
        );
    }
  }
}
