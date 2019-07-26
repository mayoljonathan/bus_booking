import 'package:get_it/get_it.dart';

import 'package:bus_booking/ui/views/create_account/create_account_model.dart';

GetIt locator = GetIt();

void setupLocator() {
  // locator.registerLazySingleton<MenuService>(() => MenuService());
  // locator.registerLazySingleton<OrderService>(() => OrderService());

  locator.registerFactory<CreateAccountModel>(() => CreateAccountModel());
  // locator.registerFactory<MenuModel>(() => MenuModel());
  // locator.registerLazySingleton<ItemDetailModel>(() => ItemDetailModel());
  // locator.registerLazySingleton<MyCartModel>(() => MyCartModel());

  // locator.registerFactory<PaymentModel>(() => PaymentModel());
}