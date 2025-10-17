import 'dart:convert';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ordering_app/business_logic/monthly_renewal/monthly_renewal_state.dart';
import 'package:ordering_app/core/services/get_it_services.dart';
import 'package:ordering_app/core/services/secure_storage.dart';
import 'package:ordering_app/data/model/monthly_renewal_model.dart';
import 'package:ordering_app/data/repositary/monthly_renewal_repository.dart';

class MonthlyRenewalCubit extends Cubit<MonthlyRenewalState> {
  final MonthlyRenewalRepository monthlyRenewalRepository;
  MonthlyRenewalCubit(this.monthlyRenewalRepository)
    : super(MonthlyRenewalInitialState());

  List<MonthlyRenewalModel> listMonthlyRenewalModel = [];
  SecureStorage storage = GetItServices.getIt<SecureStorage>();
  String? userId;

  Future<void> getUserData() async {
    final jsonString = await storage.getUserData();
    if (jsonString != null) {
      final map = jsonDecode(jsonString);
      userId = map['id'];
      log("map ======================= $map");
      log("userId ======================= $userId");
    }
  }

  Future<void> viewAllMonthlyRenewal() async {
    await getUserData();
    emit(MonthlyRenewalLoadingState());
    final response = await monthlyRenewalRepository.viewAllMonthlyRenewal(
      userId!,
    );

    response.fold(
      (failure) => emit(MonthlyRenewalFailureState(failure.message)),
      (success) {
        listMonthlyRenewalModel = success
            .map<MonthlyRenewalModel>((e) => MonthlyRenewalModel.fromJson(e))
            .toList();
        emit(
          MonthlyRenewalLoadedState(
            listMonthlyRenewalModel: listMonthlyRenewalModel,
          ),
        );
        log("listMonthlyRenewalModel ============$listMonthlyRenewalModel");
      },
    );
  }
}
