part of 'register_cubit.dart';

@immutable
sealed class RegisterState extends Equatable {}

final class RegisterInitial extends RegisterState {
  final bool isPasswordVisible;
  RegisterInitial({required this.isPasswordVisible});
  @override
  List<Object?> get props => [isPasswordVisible];
}

final class RegisterLoadingState extends RegisterState {
  @override
  List<Object?> get props => [];
}

final class RegisterSuccessState extends RegisterState {
  @override
  List<Object?> get props => [];
}

final class RegisterFailedState extends RegisterState {
  final String message;

  RegisterFailedState(this.message);
  @override
  List<Object?> get props => [message];
}
