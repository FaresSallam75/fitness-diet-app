import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ordering_app/business_logic/coaches/coache_state.dart';
import 'package:ordering_app/data/model/coachmodel.dart';
import 'package:ordering_app/data/repositary/coaches_repository.dart';

class CoachCubit extends Cubit<CoachState> {
  final CoachesRepository coachesRepository;
  CoachCubit(this.coachesRepository) : super(CoachInitialState());

  List<CoachModel> listCoaches = [];

  Future<void> getAllCoaches() async {
    emit(CoachLoadingState());
    final result = await coachesRepository.getAllCoaches();
    result.fold(
      (failure) {
        emit(CoachFailureState(failure.message));
      },
      (menuModel) {
        listCoaches = menuModel
            .map<CoachModel>((data) => CoachModel.fromJson(data))
            .toList();
        emit(CoachLoadedState(listCoaches));
      },
    );
  }
}
