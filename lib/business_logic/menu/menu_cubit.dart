import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ordering_app/business_logic/menu/menus_state.dart';
import 'package:ordering_app/data/model/cartmodel.dart';
import 'package:ordering_app/data/model/menu_model.dart';
import 'package:ordering_app/data/repositary/menu_repository.dart';
import 'package:ordering_app/main.dart';

class MenuCubit extends Cubit<MenuState> {
  final MenuRepository menuRepository;
  MenuCubit(this.menuRepository) : super(MenuLoadingState());

  List<MenuModel> listMenuModel = [];
  List<CartModel> listCartsData = [];

  Future<void> viewAllMenu() async {
    emit(MenuLoadingState());
    final result = await menuRepository.getMenuData();
    result.fold(
      (failure) {
        emit(MenuFailureState(failure.message));
      },
      (menuModel) {
        listMenuModel = menuModel
            .map<MenuModel>((data) => MenuModel.fromJson(data))
            .toList();
        emit(MenuLoadedState(listMenuModel, []));
      },
    );
  }

  Future<void> addCart(
    String vegtableId,
    String name,
    int unitPrice,
    int unitCalories,
    int quantity,
    String image,
  ) async {
    emit(MenuLoadingState());

    final result = await menuRepository.addCartData({
      "userId": myBox!.get("userId"),
      "vegtableId": vegtableId,
      "name": name,
      "unitPrice": unitPrice,
      "unitCalories": unitCalories,
      "quantity": quantity,
      "price": unitPrice * quantity,
      "calories": unitCalories * quantity,
      "image": image,
    });

    result.fold(
      (failure) {
        emit(MenuFailureState(failure.message));
      },
      (cartModel) {
        emit(MenuLoadedState([], []));
        viewAllCart();
      },
    );
  }

  Future<void> removeCart(String vegtableId) async {
    emit(MenuLoadingState());

    final result = await menuRepository.removeCartData({
      "userId": myBox!.get("userId"),
      "vegtableId": vegtableId,
    });

    result.fold(
      (failure) {
        emit(MenuFailureState(failure.message));
      },
      (cartModel) {
        emit(MenuLoadedState([], []));
        viewAllCart();
      },
    );
  }

  Future<void> viewAllCart() async {
    emit(MenuLoadingState());
    final result = await menuRepository.viewCartData({
      "userId": myBox!.get("userId"),
    });
    result.fold(
      (failure) {
        emit(MenuFailureState(failure.message));
      },
      (menuModel) {
        emit(MenuLoadedState([], listCartsData));
        listCartsData = menuModel
            .map<CartModel>((data) => CartModel.fromJson(data))
            .toList();
      },
    );
  }

  String getQuantityForItem(String vegetableId) {
    final cartItem = listCartsData.firstWhere(
      (cart) =>
          cart.vegtableId.toString() == vegetableId &&
          cart.userId == myBox!.get("userId"),
      orElse: () => CartModel(),
    );

    return cartItem.quantity ?? "0";
  }

  int get totalCartPrice {
    return listCartsData.fold<int>(0, (sum, item) => sum + (item.price ?? 0));
  }

  int get totalCartCalories {
    return listCartsData.fold<int>(
      0,
      (sum, item) => sum + (item.calories ?? 0),
    );
  }
}
