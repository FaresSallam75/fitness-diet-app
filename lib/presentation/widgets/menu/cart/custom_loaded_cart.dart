import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ordering_app/business_logic/menu/menu_cubit.dart';
import 'package:ordering_app/business_logic/menu/menus_state.dart';
import 'package:ordering_app/constants/images_asset.dart';
import 'package:ordering_app/constants/colors.dart';
import 'package:ordering_app/core/dio_services/api_end_point.dart';
import 'package:ordering_app/core/helper/show_toast_notification.dart';
import 'package:ordering_app/presentation/widgets/menu/custom_navigation_bar.dart';
import 'package:ordering_app/presentation/widgets/menu/custom_text.dart';

class CustomLoadedCart extends StatelessWidget {
  final MenuCubit menuCubit;
  final ThemeData theme;
  final Size size;
  const CustomLoadedCart({
    super.key,
    required this.menuCubit,
    required this.theme,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: menuCubit.listCartsData.isEmpty
              ? Center(child: Text('Cart is empty'))
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: menuCubit.listCartsData.length,

                  itemBuilder: (context, index) {
                    final data = menuCubit.listCartsData[index];
                    return Card(
                      child: ListTile(
                        leading: FadeInImage.assetNetwork(
                          fit: BoxFit.scaleDown,
                          height: 60,
                          width: 60,
                          placeholder: AppImagesAssets.loading,
                          image: "${ApiEndPoints.menuImages}/${data.image}",
                        ),
                        title: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "${data.name}  ",
                                style: theme.textTheme.headlineSmall!,
                              ),
                              // TextSpan(
                              //   text:
                              //       '(x${menuCubit.listCartsData[index].quantity})',
                              //   style: theme.textTheme.headlineSmall!,
                              // ),
                            ],
                          ),
                        ),
                        subtitle: Text(
                          '${data.calories} Cal',
                          style: theme.textTheme.headlineSmall!.copyWith(
                            fontSize: 14.0,
                            color: MyColors.greyLight,
                          ),
                        ),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            CustomMenuText(
                              text: "\$${data.vegetableprice}",
                              textStyle: theme.textTheme.headlineMedium!
                                  .copyWith(fontSize: 16.0),
                              padding: EdgeInsetsGeometry.all(0.0),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,

                              children: [
                                customGestureDetector(() {
                                  menuCubit.removeCart(data.vegetableid!);
                                  ShowToastMessage.showSucessToastMessage(
                                    context,
                                    message: "Item removed from cart",
                                  );
                                }, Icons.remove_circle),
                                SizedBox(width: 15.0),

                                BlocSelector<MenuCubit, MenuState, String>(
                                  selector: (state) {
                                    if (state is MenuLoadedState) {
                                      menuCubit.getQuantityForItem(
                                        data.vegetableid ?? "0",
                                      );
                                    }
                                    return "0";
                                  },
                                  builder: (context, state) {
                                    return CustomMenuText(
                                      text:
                                          "${menuCubit.listCartsData[index].quantity}",
                                      textStyle: theme.textTheme.headlineSmall!,
                                      padding: EdgeInsets.all(0.0),
                                    );
                                  },
                                ),
                                SizedBox(width: 15.0),
                                customGestureDetector(() {
                                  menuCubit.addCart(
                                    data.vegetableid!,
                                    data.vegetablename!,
                                    int.parse(data.vegetableprice!),
                                    int.parse(data.vegetablecalories!),
                                    1,
                                    data.vegetableimage!,
                                  );
                                  ShowToastMessage.showSucessToastMessage(
                                    context,
                                    message: "Item added to cart",
                                  );
                                }, Icons.add_circle),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
        Padding(
          padding: const EdgeInsets.all(0.0),
          child: CustomNavigationBar(
            textButton: "Confirm",
            onPressed: () {},
            theme: theme,
            size: size,
            calculatePrice: menuCubit.totalCartPrice,
            calculateCalrories: menuCubit.totalCartCalories,
          ),
        ),
      ],
    );
  }

  Widget customGestureDetector(
    final void Function()? onTap,
    final IconData? iconData,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(iconData, size: 24.0, color: MyColors.orange),
    );
  }
}
