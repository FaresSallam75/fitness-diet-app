import 'package:get_it/get_it.dart';
import 'package:ordering_app/business_logic/theme/theme_cubit.dart';
import 'package:ordering_app/core/services/secure_storage.dart';
import 'package:ordering_app/data/repositary/auth_repository.dart';
import 'package:ordering_app/data/repositary/chat_repository.dart';
import 'package:ordering_app/data/repositary/coaches_repository.dart';
import 'package:ordering_app/data/repositary/menu_repository.dart';
import 'package:ordering_app/data/repositary/monthly_renewal_repository.dart';
import 'package:ordering_app/data/repositary/offer_repository.dart';

abstract class GetItServices {
  static final GetIt getIt = GetIt.instance;
  static SecureStorage secureStorage = GetItServices.getIt<SecureStorage>();
  static void setup() {
    getIt.registerLazySingleton<AuthRepositary>(() => AuthRepositary());
    getIt.registerLazySingleton<SecureStorage>(() => SecureStorage());
    getIt.registerLazySingleton<AppSettingsCubit>(() => AppSettingsCubit());
    getIt.registerLazySingleton<MenuRepository>(() => MenuRepository());
    getIt.registerLazySingleton<CoachesRepository>(() => CoachesRepository());
    getIt.registerLazySingleton<ChatRepository>(() => ChatRepository());
    getIt.registerLazySingleton<OfferRepository>(() => OfferRepository());
    getIt.registerLazySingleton<MonthlyRenewalRepository>(
      () => MonthlyRenewalRepository(),
    );
  }
}
