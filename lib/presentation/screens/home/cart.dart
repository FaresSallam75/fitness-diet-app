import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ordering_app/business_logic/menu/menu_cubit.dart';
import 'package:ordering_app/business_logic/menu/menus_state.dart';
import 'package:ordering_app/presentation/widgets/menu/cart/custom_loaded_cart.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late final MenuCubit menuCubit;

  @override
  void initState() {
    super.initState();
    menuCubit = context.read<MenuCubit>();
    menuCubit.viewAllCart();
    menuCubit.viewAllMenu();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
        titleTextStyle: Theme.of(context).appBarTheme.titleTextStyle,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 12.0),
        child: BlocBuilder<MenuCubit, MenuState>(
          builder: (context, state) {
            if (state is MenuLoadingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is MenuFailureState) {
              return Center(child: Text(state.messageFailure));
            }

            return CustomLoadedCart(
              theme: theme,
              menuCubit: menuCubit,
              size: size,
            );
          },
        ),
      ),
    );
  }
}
