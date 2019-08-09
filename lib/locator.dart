import 'package:bus_booking/core/services/bus_service.dart';
import 'package:bus_booking/core/services/favorite_service.dart';
import 'package:bus_booking/core/services/place_service.dart';
import 'package:bus_booking/core/viewmodels/bus_selection_view_model.dart';
import 'package:bus_booking/core/viewmodels/create_account_model.dart';
import 'package:bus_booking/core/viewmodels/home_view_model.dart';
import 'package:bus_booking/core/viewmodels/location_selection_view_model.dart';
import 'package:bus_booking/core/viewmodels/main_view_model.dart';
import 'package:bus_booking/core/viewmodels/seat_selection_view_model.dart';
import 'package:bus_booking/core/viewmodels/user_model.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt();

void setupLocator() {
  // locator.registerLazySingleton<MenuService>(() => MenuService());
  // locator.registerLazySingleton<OrderService>(() => OrderService());

  locator.registerLazySingleton<UserModel>(() => UserModel());
  locator.registerFactory<CreateAccountModel>(() => CreateAccountModel());

  locator.registerLazySingleton<MainViewModel>(() => MainViewModel());
  locator.registerFactory<HomeViewModel>(() => HomeViewModel());
  locator.registerFactory<LocationSelectionViewModel>(() => LocationSelectionViewModel());
  locator.registerFactory<BusSelectionViewModel>(() => BusSelectionViewModel());
  locator.registerFactory<SeatSelectionViewModel>(() => SeatSelectionViewModel());

  locator.registerLazySingleton<FavoriteService>(() => FavoriteService());
  locator.registerLazySingleton<PlaceService>(() => PlaceService());
  locator.registerLazySingleton<BusService>(() => BusService());

  // locator.registerFactory<MenuModel>(() => MenuModel());
  // locator.registerLazySingleton<ItemDetailModel>(() => ItemDetailModel());
  // locator.registerLazySingleton<MyCartModel>(() => MyCartModel());

  // locator.registerFactory<PaymentModel>(() => PaymentModel());
}