import 'package:equatable/equatable.dart';
import 'package:ordering_app/data/model/coachmodel.dart';

class CoachState extends Equatable {
  const CoachState();
  @override
  List<Object?> get props => [];
}

final class CoachInitialState extends CoachState {
  const CoachInitialState();
  @override
  List<Object?> get props => [];
}

final class CoachLoadingState extends CoachState {
  const CoachLoadingState();
  @override
  List<Object?> get props => [];
}

final class CoachLoadedState extends CoachState {
  final List<CoachModel> listCoaches;
  const CoachLoadedState(this.listCoaches);
  @override
  List<Object?> get props => [listCoaches];
}

final class CoachFailureState extends CoachState {
  final String messageFailure;
  @override
  List<Object?> get props => [messageFailure];
  const CoachFailureState(this.messageFailure);
}
