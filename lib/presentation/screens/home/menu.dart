import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ordering_app/business_logic/menu/menu_cubit.dart';
import 'package:ordering_app/business_logic/menu/menus_state.dart';
import 'package:ordering_app/constants/routes.dart';
import 'package:ordering_app/core/helper/show_toast_notification.dart';
import 'package:ordering_app/data/model/menu_model.dart';
import 'package:ordering_app/presentation/widgets/menu/custom_loaded_data.dart';
import 'package:ordering_app/presentation/widgets/menu/custom_navigation_bar.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  late final MenuCubit menuCubit;
  final Map<String, List<MenuModel>> groupedMenu = {};

  @override
  void initState() {
    super.initState();
    menuCubit = context.read<MenuCubit>();
    menuCubit.viewAllMenu();
    menuCubit.viewAllCart();
  }

  @override
  Widget build(BuildContext context) {
    log("Call build method =========================== ");
    ThemeData theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;
    return customBodyData(theme, size);
  }

  Widget customBodyData(ThemeData theme, Size size) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: BlocBuilder<MenuCubit, MenuState>(
              builder: (context, state) {
                if (state is MenuLoadingState) {
                  return Center(child: CircularProgressIndicator());
                }
                // else if (state is MenuFailureState) {
                //   ShowToastMessage.showErrorToastMessage(
                //     context,
                //     message: state.messageFailure,
                //   );
                // }
                for (var dept in menuCubit.listMenuModel) {
                  groupedMenu[dept.departmentname!] = menuCubit.listMenuModel
                      .where((item) => item.departmentid == dept.departmentid)
                      .toList();
                }
                return ListView(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  children: groupedMenu.entries.map((entry) {
                    final categoryItems = entry.value.take(2).toList();
                    return CustomLoadedData(
                      theme: theme,
                      categoryItems: categoryItems,
                      entry: entry,
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ),
        BlocBuilder<MenuCubit, MenuState>(
          builder: (context, state) {
            if (state is MenuLoadedState) {
              final totalPrice = menuCubit.totalCartPrice;
              final totalCalories = menuCubit.totalCartCalories;
              return CustomNavigationBar(
                textButton: "Place order",
                onPressed: () {
                  if (totalPrice > 0) {
                    Navigator.of(context).pushNamed(AppRoutes.cartScreen);
                    // ShowToastMessage.showSucessToastMessage(
                    //   context,
                    //   message: "Order placed successfully",
                    // );
                  } else {
                    ShowToastMessage.showErrorToastMessage(
                      context,
                      message: "Your cart is empty",
                    );
                  }
                },
                theme: theme,
                size: size,
                calculatePrice: totalPrice,
                calculateCalrories: totalCalories,
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
