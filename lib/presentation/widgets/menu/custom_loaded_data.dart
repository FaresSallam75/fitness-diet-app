import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ordering_app/business_logic/menu/menu_cubit.dart';
import 'package:ordering_app/business_logic/menu/menus_state.dart';
import 'package:ordering_app/constants/images_asset.dart';
import 'package:ordering_app/constants/colors.dart';
import 'package:ordering_app/core/dio_services/api_end_point.dart';
import 'package:ordering_app/core/helper/show_toast_notification.dart';
import 'package:ordering_app/data/model/menu_model.dart';
import 'package:ordering_app/main.dart';
import 'package:ordering_app/presentation/widgets/menu/custom_text.dart';

class CustomLoadedData extends StatelessWidget {
  final ThemeData theme;
  final List<MenuModel> categoryItems;
  final MapEntry<String, List<MenuModel>> entry;

  const CustomLoadedData({
    super.key,
    required this.theme,
    required this.categoryItems,
    required this.entry,
  });

  @override
  Widget build(BuildContext context) {
    final MenuCubit menuCubit = context.read<MenuCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        SizedBox(height: 30),
        CustomMenuText(
          text: entry.key,
          textStyle: theme.textTheme.headlineMedium!.copyWith(
            color: (myBox!.get("isDark") ?? false)
                ? MyColors.whiteObasity
                : MyColors.black,
          ),
          padding: EdgeInsets.only(bottom: 10.0),
        ),
        // SizedBox(height: 10),
        GridView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: ClampingScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 0.9, //2.2 / 2.8,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
          ),
          itemCount: categoryItems.length,
          itemBuilder: (context, index) {
            final item = categoryItems[index];
            final quantity = menuCubit.getQuantityForItem(
              item.vegetableid ?? "0",
            );
            return Container(
              decoration: BoxDecoration(
                color: (myBox!.get("isDark") ?? false)
                    ? MyColors.grey01
                    : MyColors.grey03,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex: 2,
                    child: FadeInImage.assetNetwork(
                      width: 130.0,
                      height: 130.0,
                      placeholder: AppImagesAssets.loading,
                      image:
                          "${ApiEndPoints.menuImages}/${item.vegetableimage}",
                      fit: BoxFit.contain,
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          AppImagesAssets.loading,
                          width: 100,
                          height: 100,
                          fit: BoxFit.contain,
                        );
                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomMenuText(
                          text: item.vegetablename ?? '',
                          textStyle: theme.textTheme.headlineMedium!.copyWith(
                            fontSize: 16.0,
                          ),

                          padding: EdgeInsetsGeometry.all(0.0),
                        ),
                        CustomMenuText(
                          text: "${item.vegetablecalories} Cal",
                          textStyle: theme.textTheme.headlineMedium!.copyWith(
                            fontSize: 14.0,
                            color: MyColors.greyLight,
                          ),

                          padding: EdgeInsetsGeometry.all(0.0),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,

                      children: [
                        CustomMenuText(
                          text: "${item.vegetableprice}\$",
                          textStyle: theme.textTheme.headlineSmall!.copyWith(
                            color: MyColors.black01,
                          ),
                          padding: EdgeInsetsGeometry.all(0.0),
                        ),
                        SizedBox(width: 30.0),
                        customGestureDetector(() {
                          menuCubit.removeCart(item.vegetableid!);
                          ShowToastMessage.showSucessToastMessage(
                            context,
                            message: "Item removed from cart",
                          );
                        }, Icons.remove_circle),

                        BlocSelector<MenuCubit, MenuState, String>(
                          selector: (state) {
                            if (state is MenuLoadedState) {
                              menuCubit.getQuantityForItem(
                                item.vegetableid ?? "0",
                              );
                            }
                            return "0";
                          },
                          builder: (context, state) {
                            return CustomMenuText(
                              text: quantity,
                              textStyle: theme.textTheme.headlineSmall!
                                  .copyWith(color: MyColors.black),
                              padding: EdgeInsets.all(0.0),
                            );
                          },
                        ),
                        customGestureDetector(() {
                          menuCubit.addCart(
                            item.vegetableid!,
                            item.vegetablename!,
                            int.parse(item.vegetableprice!),
                            int.parse(item.vegetablecalories!),
                            1,
                            item.vegetableimage!,
                          );
                          ShowToastMessage.showSucessToastMessage(
                            context,
                            message: "Item added to cart",
                          );
                        }, Icons.add_circle),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
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
