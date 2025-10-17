import 'package:equatable/equatable.dart';
import 'package:ordering_app/data/model/monthly_renewal_model.dart';

class MonthlyRenewalState extends Equatable {
  const MonthlyRenewalState();
  @override
  List<Object?> get props => [];
}

final class MonthlyRenewalInitialState extends MonthlyRenewalState {
  const MonthlyRenewalInitialState();
  @override
  List<Object?> get props => [];
}

final class MonthlyRenewalLoadingState extends MonthlyRenewalState {
  const MonthlyRenewalLoadingState();
  @override
  List<Object?> get props => [];
}

final class MonthlyRenewalLoadedState extends MonthlyRenewalState {
  final List<MonthlyRenewalModel> listMonthlyRenewalModel;
  const MonthlyRenewalLoadedState({required this.listMonthlyRenewalModel});
  @override
  List<Object?> get props => [listMonthlyRenewalModel];
}

final class MonthlyRenewalFailureState extends MonthlyRenewalState {
  final String messageFailure;
  const MonthlyRenewalFailureState(this.messageFailure);
  @override
  List<Object?> get props => [messageFailure];
}
