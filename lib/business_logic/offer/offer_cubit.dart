import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ordering_app/business_logic/offer/offer_state.dart';
import 'package:ordering_app/data/model/offermodel.dart';
import 'package:ordering_app/data/repositary/offer_repository.dart';

class OfferCubit extends Cubit<OfferState> {
  final OfferRepository offerRepository;
  OfferCubit(this.offerRepository) : super(OfferLoadingState());

  List<OfferModel> listOfferModel = [];

  Future<void> viewAllOffers() async {
    emit(OfferLoadingState());
    final result = await offerRepository.getOffers();
    result.fold(
      (failure) {
        emit(OfferFailureState(failure.message));
      },
      (offerModel) {
        listOfferModel = offerModel
            .map<OfferModel>((data) => OfferModel.fromJson(data))
            .toList();
        emit(OfferLoadedState(listOfferModel: listOfferModel));
      },
    );
  }
}
