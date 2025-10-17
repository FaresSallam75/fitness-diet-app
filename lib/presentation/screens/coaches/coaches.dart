import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ordering_app/business_logic/coaches/coache_cubit.dart';
import 'package:ordering_app/business_logic/coaches/coache_state.dart';
import 'package:ordering_app/constants/images_asset.dart';
import 'package:ordering_app/constants/colors.dart';
import 'package:ordering_app/constants/routes.dart';
import 'package:ordering_app/core/dio_services/api_end_point.dart';
import 'package:ordering_app/core/helper/show_toast_notification.dart';
import 'package:ordering_app/presentation/widgets/menu/custom_text.dart';

class CoachesScreen extends StatefulWidget {
  const CoachesScreen({super.key});

  @override
  State<CoachesScreen> createState() => _CoachesScreenState();
}

class _CoachesScreenState extends State<CoachesScreen> {
  late final CoachCubit coacheCubit;

  @override
  void initState() {
    super.initState();
    coacheCubit = context.read<CoachCubit>();
    coacheCubit.getAllCoaches();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return BlocBuilder<CoachCubit, CoachState>(
      builder: (context, state) {
        if (state is CoachLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          ); //ShowShimmerLoading.show();
        } else if (state is CoachFailureState) {
          ShowToastMessage.showErrorToastMessage(
            context,
            message: state.messageFailure,
          );
        }

        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: GridView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: ClampingScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 250,
              childAspectRatio: 0.9, //2.2 / 2.8,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
            ),
            itemCount: coacheCubit.listCoaches.length,
            itemBuilder: (context, index) {
              final coaches = coacheCubit.listCoaches[index];
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    AppRoutes.coachDetailsScreen,
                    arguments: {
                      "id": "${coaches.id}",
                      "name": "${coaches.name}",
                      "image": "${ApiEndPoints.coachImages}/${coaches.image}",
                      "phone": coaches.phone,
                    },
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: MyColors.grey03,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        flex: 2,
                        child: FadeInImage.assetNetwork(
                          height: 100.0,
                          width: 100.0,
                          placeholder: AppImagesAssets.loading,
                          image: "${ApiEndPoints.coachImages}/${coaches.image}",
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

                      // Expanded(
                      //   flex: 1,
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //     children: [
                      //       CustomMenuText(
                      //         text: coaches.coacheName ?? '',
                      //         textStyle: theme.textTheme.headlineSmall!,
                      //         padding: EdgeInsetsGeometry.all(0.0),
                      //       ),
                      //       CustomMenuText(
                      //         text: coaches.coachePhone ?? '',
                      //         textStyle: theme.textTheme.headlineSmall!,
                      //         padding: EdgeInsetsGeometry.all(0.0),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      CustomMenuText(
                        text: coaches.name ?? '',
                        textStyle: theme.textTheme.headlineMedium!,
                        padding: EdgeInsetsGeometry.all(0.0),
                      ),
                      CustomMenuText(
                        text: coaches.phone ?? '',
                        textStyle: theme.textTheme.headlineSmall!.copyWith(
                          color: MyColors.orange,
                        ),
                        padding: EdgeInsetsGeometry.all(0.0),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
