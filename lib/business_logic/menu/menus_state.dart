import 'package:equatable/equatable.dart';
import 'package:ordering_app/data/model/cartmodel.dart';
import 'package:ordering_app/data/model/menu_model.dart';

class MenuState extends Equatable {
  const MenuState();
  @override
  List<Object?> get props => [];
}

final class MenuInitialState extends MenuState {
  const MenuInitialState();
  @override
  List<Object?> get props => [];
}

final class MenuLoadingState extends MenuState {
  const MenuLoadingState();
  @override
  List<Object?> get props => [];
}

final class MenuLoadedState extends MenuState {
  final List<MenuModel> listMenuModel;
  final List<CartModel> listCartsData;
  const MenuLoadedState(this.listMenuModel, this.listCartsData);
  @override
  List<Object?> get props => [listMenuModel, listCartsData];
}

final class MenuFailureState extends MenuState {
  final String messageFailure;
  @override
  List<Object?> get props => [messageFailure];
  const MenuFailureState(this.messageFailure);
}
