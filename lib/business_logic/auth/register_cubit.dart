import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ordering_app/data/repositary/auth_repository.dart';
part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  late final AuthRepositary authRepository;
  RegisterCubit(this.authRepository)
    : super(RegisterInitial(isPasswordVisible: false));
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  // bool isPasswordVisible = false;

  void changePasswordVisibility() {
    final currentState = state;
    if (currentState is RegisterInitial) {
      final current = currentState.isPasswordVisible;
      emit(RegisterInitial(isPasswordVisible: !current));
    }
  }

  Future<void> register() async {
    emit(RegisterLoadingState());
    var result = await authRepository.regsterData(
      nameController.text.trim(),
      emailController.text.trim(),
      passwordController.text.trim(),
    );
    result.fold(
      (failure) => emit(RegisterFailedState(failure.message)),
      (data) => emit(RegisterSuccessState()),
    );
  }
}
