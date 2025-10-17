import 'package:equatable/equatable.dart';
import 'package:ordering_app/data/model/offermodel.dart';

class OfferState extends Equatable {
  const OfferState();
  @override
  List<Object?> get props => [];
}

final class OfferInitialState extends OfferState {
  const OfferInitialState();
  @override
  List<Object?> get props => [];
}

final class OfferLoadingState extends OfferState {
  const OfferLoadingState();
  @override
  List<Object?> get props => [];
}

final class OfferLoadedState extends OfferState {
  final List<OfferModel> listOfferModel;
  const OfferLoadedState({required this.listOfferModel});
  @override
  List<Object?> get props => [listOfferModel];
}

final class OfferFailureState extends OfferState {
  final String messageFailure;
  @override
  List<Object?> get props => [messageFailure];
  const OfferFailureState(this.messageFailure);
}
