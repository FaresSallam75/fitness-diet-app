import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ordering_app/business_logic/auth/login_cubit.dart';
import 'package:ordering_app/business_logic/auth/login_state.dart';
import 'package:ordering_app/constants/clip_path.dart';
import 'package:ordering_app/constants/colors.dart';
import 'package:ordering_app/constants/routes.dart';
import 'package:ordering_app/core/helper/show_toast_notification.dart';
import 'package:ordering_app/core/helper/valid_input.dart';
import 'package:ordering_app/presentation/widgets/auth/custommaterialbutton.dart';
import 'package:ordering_app/presentation/widgets/auth/customtext.dart';
import 'package:ordering_app/presentation/widgets/auth/customtextformfield.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late final LoginCubit loginCubit;

  @override
  void initState() {
    // loginCubit = LoginCubit(GetItServices.getIt<AuthRepositary>());
    loginCubit = context.read<LoginCubit>();
    loginCubit.getUserToken();
    super.initState();
  }

  @override
  void dispose() {
    loginCubit.emailController.dispose;
    loginCubit.passwordController.dispose;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final themeData = Theme.of(context).textTheme;

    return Scaffold(
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          // if (state is LoginLoadingState) {
          //   const Center(child: CircularProgressIndicator());
          // }
          if (state is LoginFailedState) {
            ShowToastMessage.showErrorToastMessage(
              context,
              message: state.message,
            );
          } else if (state is LoginSuccessState) {
            if (loginCubit.userTableName == "users") {
              log("tableName ================= ${loginCubit.userTableName}");
              Navigator.of(context).pushReplacementNamed(AppRoutes.homeScreen);
            } else {
              log("from coaches -------------------------- ");
              Navigator.of(
                context,
              ).pushReplacementNamed(AppRoutes.coachHomePage);
            }
          }
        },
        builder: (context, state) {
          if (state is LoginLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          // else if (state is LoginFailedState) {
          //   ShowToastMessage.showErrorToastMessage(
          //     context,
          //     message: state.message,
          //   );
          // }
          return customLoginBody(screenSize, themeData);
        },
      ),
    );
  }

  Widget customLoginBody(Size screenSize, TextTheme themeData) {
    return Stack(
      children: [
        Container(color: MyColors.blueDark),
        ClipPath(
          clipper: BackgroundCurveClipper(),
          child: Container(
            height: screenSize.height * 0.55,
            color: MyColors.blueLight,
          ),
        ),
        Positioned(
          top: screenSize.height * 0.15,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Go ahead and set up\nyour account",
                  style: themeData.headlineLarge!.copyWith(
                    color: MyColors.grey01,
                  ),
                ),
                const SizedBox(height: 10),

                SizedBox(height: screenSize.height * 0.1),
                Form(
                  key: loginCubit.formKey,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25.0,
                      vertical: 35.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25.0),
                      boxShadow: [
                        BoxShadow(
                          // ignore: deprecated_member_use
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomTextFormField(
                          labelText: "E-mail ID",
                          keyboardType: TextInputType.emailAddress,
                          icon: Icons.email_outlined,
                          validator: (value) {
                            return validInput(value!, 4, 30, "email");
                          },
                          obscureText: false,
                          controller: loginCubit.emailController,
                          suffixIcon: null,
                        ),
                        const SizedBox(height: 20),
                        BlocSelector<LoginCubit, LoginState, bool>(
                          selector: (state) {
                            if (state is LoginInitial) {
                              return state.isPasswordVisible;
                            }
                            return false;
                          },
                          builder: (context, isPasswordVisible) {
                            return CustomTextFormField(
                              labelText: "Password",
                              keyboardType: TextInputType.visiblePassword,
                              icon: Icons.lock_outline,
                              validator: (value) {
                                return validInput(value!, 4, 20, "password");
                              },
                              obscureText: !isPasswordVisible,
                              controller: loginCubit.passwordController,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  isPasswordVisible
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.grey.shade500,
                                ),
                                onPressed: () {
                                  loginCubit.changePasswordVisibility();
                                },
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: 20),
                        InkWell(
                          onTap: () {},
                          child: CustomText(
                            textAlign: TextAlign.end,
                            title: "Forget Your Password?",
                            textStyle: themeData.headlineSmall!.copyWith(
                              color: MyColors.blueDark,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        Row(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  loginCubit.userTableName = "users";
                                },
                                child: CustomText(
                                  title: "Login as User",
                                  textStyle: themeData.headlineSmall!.copyWith(
                                    fontSize: 12.0,
                                    color: MyColors.blueLight,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 5.0),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  loginCubit.userTableName = "coaches";
                                },
                                child: CustomText(
                                  title: "Login as Coach",
                                  textStyle: themeData.headlineSmall!.copyWith(
                                    fontSize: 12.0,
                                    color: MyColors.blueLight,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        CustomMaterialButton(
                          height: 55.0,
                          color: MyColors.blueDark,
                          minWidth: MediaQuery.of(context).size.width - 80,
                          onPressed: () {
                            if (loginCubit.formKey.currentState!.validate()) {
                              loginCubit.formKey.currentState!.save();
                              if (loginCubit.userTableName != null &&
                                  loginCubit.userTableName == "users") {
                                loginCubit.login();
                              } else {
                                loginCubit.coachLogin();
                              }
                            } else {
                              ShowToastMessage.showErrorToastMessage(
                                context,
                                message: "Please fill all the fields",
                              );
                              // ScaffoldMessenger.of(context).showSnackBar(
                              //   SnackBar(
                              //     content: Text(
                              //       "Please fill all the fields",
                              //       style: themeData.headlineSmall!.copyWith(
                              //         color: MyColors.white,
                              //       ),
                              //     ),
                              //   ),
                              // );
                            }
                          },

                          radius: 15.0,
                          child: Text(
                            "Login",
                            style: themeData.headlineMedium!.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 50.0),
                InkWell(
                  onTap: () {
                    Navigator.of(
                      context,
                    ).pushReplacementNamed(AppRoutes.register);
                  },
                  child: Center(
                    child: RichText(
                      text: TextSpan(
                        text: "Not have an account? ",
                        style: themeData.bodySmall!.copyWith(
                          color: MyColors.grey03,
                        ),
                        children: [
                          TextSpan(
                            text: "Register now",
                            style: themeData.bodySmall!.copyWith(
                              color: MyColors.blueLight,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget customDetermineLogin() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            loginCubit.userTableName = "users";
          },
          child: CustomText(title: "Login as User"),
        ),
        SizedBox(width: 10),
        ElevatedButton(
          onPressed: () {
            loginCubit.userTableName = "coaches";
          },
          child: CustomText(title: "Login as Coach"),
        ),
      ],
    );
  }
}
