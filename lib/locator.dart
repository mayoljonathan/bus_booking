import 'package:bus_booking/core/viewmodels/create_account_model.dart';
import 'package:bus_booking/core/viewmodels/home_view_model.dart';
import 'package:bus_booking/core/viewmodels/user_model.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt();

void setupLocator() {
  // locator.registerLazySingleton<MenuService>(() => MenuService());
  // locator.registerLazySingleton<OrderService>(() => OrderService());

  locator.registerLazySingleton<UserModel>(() => UserModel());
  locator.registerFactory<CreateAccountModel>(() => CreateAccountModel());

  locator.registerFactory<HomeViewModel>(() => HomeViewModel());

  // locator.registerFactory<MenuModel>(() => MenuModel());
  // locator.registerLazySingleton<ItemDetailModel>(() => ItemDetailModel());
  // locator.registerLazySingleton<MyCartModel>(() => MyCartModel());

  // locator.registerFactory<PaymentModel>(() => PaymentModel());
}