import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ordering_app/business_logic/monthly_renewal/monthly_renewal_cubit.dart';
import 'package:ordering_app/business_logic/monthly_renewal/monthly_renewal_state.dart';
import 'package:ordering_app/core/helper/show_toast_notification.dart';
import 'package:ordering_app/presentation/widgets/auth/customtext.dart';

class MonthlyRenewal extends StatefulWidget {
  const MonthlyRenewal({super.key});

  @override
  State<MonthlyRenewal> createState() => _MonthlyRenewalState();
}

class _MonthlyRenewalState extends State<MonthlyRenewal> {
  late final MonthlyRenewalCubit monthlyRenewalCubit;
  final Map<String, List<dynamic>> groupedByYear = {};

  @override
  void initState() {
    super.initState();
    monthlyRenewalCubit = context.read<MonthlyRenewalCubit>();
    monthlyRenewalCubit.viewAllMonthlyRenewal();
  }

  Map<String, List<dynamic>> groupPaymentsByYear(List<dynamic> paymentsList) {
    for (var payment in paymentsList) {
      final DateTime start = DateTime.parse(payment.startDate!);
      final String year = DateFormat('yyyy').format(start);
      groupedByYear.putIfAbsent(year, () => []);
      groupedByYear[year]!.add(payment);
    }
    return groupedByYear;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: CustomText(title: "Payment History")),
      body: BlocBuilder<MonthlyRenewalCubit, MonthlyRenewalState>(
        builder: (context, state) {
          if (state is MonthlyRenewalLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is MonthlyRenewalFailureState) {
            ShowToastMessage.showErrorToastMessage(
              context,
              message: state.messageFailure,
            );
          } else if (state is MonthlyRenewalLoadedState) {
            final groupedByYear = groupPaymentsByYear(
              state.listMonthlyRenewalModel,
            );
            return customBodyData(groupedByYear);
          }

          return const Center(child: Text("No Data Found"));
        },
      ),
    );
  }

  Widget customBodyData(Map<String, List<dynamic>> groupedByYear) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: groupedByYear.entries.map((entry) {
          final String year = entry.key;
          final List<dynamic> yearPayments = entry.value;
          return Column(
            children: [
              // ✅ السنة كعنوان
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: CustomText(
                  textAlign: TextAlign.start,
                  title: year, //📅
                ),
              ),

              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.4,
                ),
                itemCount: yearPayments.length,
                itemBuilder: (context, index) {
                  final payments = yearPayments[index];
                  final DateTime start = DateTime.parse(payments.startDate!);
                  final String monthName = DateFormat('MMMM').format(start);
                  final bool isPaid = payments.status == 1;
                  log("year = $year → month = $monthName");
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    decoration: BoxDecoration(
                      color: isPaid ? Colors.green[100] : Colors.red[100],
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isPaid ? Colors.green : Colors.red,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          monthName,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: isPaid ? Colors.green[800] : Colors.red[800],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Icon(
                          isPaid ? Icons.check_circle : Icons.cancel,
                          color: isPaid ? Colors.green : Colors.red,
                          size: 32,
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          );
        }).toList(),
      ),
    );
  }
}
