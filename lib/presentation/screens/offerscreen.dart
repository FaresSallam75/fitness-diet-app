// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ordering_app/business_logic/offer/offer_cubit.dart';
import 'package:ordering_app/business_logic/offer/offer_state.dart';
import 'package:ordering_app/constants/colors.dart';
import 'package:ordering_app/core/dio_services/api_end_point.dart';
import 'package:ordering_app/core/helper/show_toast_notification.dart';
import 'package:ordering_app/main.dart';
import 'package:ordering_app/presentation/widgets/auth/customtext.dart';

class OfferScreen extends StatefulWidget {
  const OfferScreen({super.key});

  @override
  State<OfferScreen> createState() => _OfferScreenState();
}

class _OfferScreenState extends State<OfferScreen> {
  late final OfferCubit offerCubit;

  @override
  void initState() {
    super.initState();
    offerCubit = context.read<OfferCubit>();
    offerCubit.viewAllOffers();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: CustomText(title: "Offers")),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
        child: BlocBuilder<OfferCubit, OfferState>(
          builder: (context, state) {
            if (state is OfferLoadingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is OfferFailureState) {
              ShowToastMessage.showErrorToastMessage(
                context,
                message: state.messageFailure,
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: offerCubit.listOfferModel.length,
              itemBuilder: (context, index) {
                final offer = offerCubit.listOfferModel[index];

                return Card(
                  elevation: 6,
                  shadowColor: MyColors.black.withOpacity(0.2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 8,
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CachedNetworkImage(
                        imageUrl:
                            "${ApiEndPoints.viewOffersImages}/${offer.image}",
                        width: size,
                        height: 220,
                        fit: BoxFit.cover,
                        progressIndicatorBuilder: (context, url, progress) =>
                            Container(
                              height: 220,
                              color: MyColors.grey,
                              alignment: Alignment.center,
                              child: const CircularProgressIndicator(),
                            ),
                        errorWidget: (context, url, error) => Container(
                          height: 220,
                          color: MyColors.grey, //shade300
                          child: const Icon(
                            Icons.image_not_supported_outlined,
                            size: 60,
                            color: MyColors.grey,
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              offer.name!,
                              style: theme.textTheme.headlineSmall!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: (myBox!.get("isDark") ?? false)
                                    ? MyColors.whiteObasity
                                    : MyColors.black01,
                              ),
                            ),
                            const SizedBox(height: 8),

                            Row(
                              children: [
                                const Icon(
                                  Icons.local_offer,
                                  color: MyColors.blueLight,
                                  size: 20,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  "${offer.price} E£",
                                  style: theme.textTheme.headlineSmall!
                                      .copyWith(
                                        color: (myBox!.get("isDark") ?? false)
                                            ? MyColors.whiteObasity
                                            : MyColors.greyDark,
                                      ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 8),

                            Row(
                              children: [
                                const Icon(
                                  Icons.access_time,
                                  color: MyColors.blueLight,
                                  size: 20,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  "Period: ${offer.period ?? 'N/A'}",
                                  style: theme.textTheme.headlineSmall!
                                      .copyWith(
                                        color: (myBox!.get("isDark") ?? false)
                                            ? MyColors.whiteObasity
                                            : MyColors.black01,
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
