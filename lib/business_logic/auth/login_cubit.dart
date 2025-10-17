import 'dart:convert';
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ordering_app/business_logic/auth/login_state.dart';
import 'package:ordering_app/core/app/user_app.dart';
import 'package:ordering_app/core/services/get_it_services.dart';
import 'package:ordering_app/core/services/secure_storage.dart';
import 'package:ordering_app/data/model/coachmodel.dart';
import 'package:ordering_app/data/model/user_model.dart';
import 'package:ordering_app/data/repositary/auth_repository.dart';
import 'package:ordering_app/main.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepositary authRepository;
  LoginCubit(this.authRepository)
    : super(LoginInitial(isPasswordVisible: false));
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;
  SecureStorage storage = GetItServices.getIt<SecureStorage>();

  String? userTableName;

  void changePasswordVisibility() {
    final currentState = state;
    if (currentState is LoginInitial) {
      final current = currentState.isPasswordVisible;
      emit(LoginInitial(isPasswordVisible: !current));
    }
  }

  void getUserToken() {
    FirebaseMessaging.instance.getToken().then((value) {
      log("========================== Value Of Token $value");
      // ignore: unused_local_variable
      String? token = value;
    });
  }

  Future<void> login() async {
    emit(LoginLoadingState());
    final result = await authRepository.loginData(
      emailController.text.trim(),
      passwordController.text.trim(),
    );
    result.fold(
      (failure) {
        emit(LoginFailedState(failure.message));
      },
      (userData) async {
        userTableName = "users";

        await saveUserData(UserModel.fromJson(userData[0]));
        await UserApp.userIsAuthorized();
        emit(LoginSuccessState());
        FirebaseMessaging.instance.subscribeToTopic("fares");
        FirebaseMessaging.instance.subscribeToTopic(
          "fares${userData[0]['id']}",
        );
      },
    );
  }

  Future<void> coachLogin() async {
    emit(LoginLoadingState());
    final result = await authRepository.coachLoginData(
      emailController.text.trim(),
      passwordController.text.trim(),
    );
    result.fold(
      (failure) {
        emit(LoginFailedState(failure.message));
      },
      (userData) async {
        userTableName = "coaches";
        await saveCoachData(CoachModel.fromJson(userData[0]));
        await CoachApp.coachIsAuthorized();
        emit(LoginSuccessState());
        FirebaseMessaging.instance.subscribeToTopic("fares");
        FirebaseMessaging.instance.subscribeToTopic(
          "fares${userData[0]['id']}",
        );
      },
    );
  }

  Future<void> saveUserData(UserModel userData) async {
    final jsonString = jsonEncode(userData.toJson());
    await storage.addUserData(jsonString);
    await myBox!.put("userId", userData.id.toString());
    await myBox!.put("userName", userData.name);
    await myBox!.put("userEmail", userData.email);
  }

  Future<void> saveCoachData(CoachModel coachData) async {
    final jsonString = jsonEncode(coachData.toJson());
    await storage.addCoachData(jsonString);
    await myBox!.put("coachId", coachData.id.toString());
    await myBox!.put("coachName", coachData.name);
    await myBox!.put("coachEmail", coachData.email);
    await myBox!.put("coachePhone", coachData.phone);
    await myBox!.put("coacheImage", coachData.image);
  }

  Future<UserModel?> getUserData() async {
    final jsonString = await storage.getUserData();
    if (jsonString != null) {
      final map = jsonDecode(jsonString);
      return UserModel.fromJson(map);
    }
    return null;
  }
}
