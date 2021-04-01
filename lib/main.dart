import 'dart:io';
import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/bloc/detail_restaurant_bloc.dart';
import 'package:restaurant_app/bloc/favorite_restaurant_bloc.dart';
import 'package:restaurant_app/bloc/restaurant_bloc.dart';
import 'package:restaurant_app/bloc/search_restaurant_bloc.dart';
import 'package:restaurant_app/bloc/setting_bloc.dart';
import 'package:restaurant_app/res/colors.dart';
import 'package:restaurant_app/routes/route_paths.dart';
import 'package:restaurant_app/screens/detail_restaurant_page.dart';
import 'package:restaurant_app/screens/favorite_restaurant_page.dart';
import 'package:restaurant_app/screens/home_page.dart';
import 'package:restaurant_app/screens/search_restaurant_page.dart';
import 'package:restaurant_app/screens/setting_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restaurant_app/utils/background_service.dart';
import 'package:restaurant_app/utils/notification_helper.dart';
import 'package:restaurant_app/common/navigation.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();
  _service.initializeIsolate();
  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(MultiBlocProvider(providers: [
    BlocProvider<RestaurantBloc>(
      create: (context) => RestaurantBloc(),
    ),
    BlocProvider<DetailRestaurantBloc>(
      create: (context) => DetailRestaurantBloc(),
    ),
    BlocProvider<SearchRestaurantBloc>(
      create: (context) => SearchRestaurantBloc(),
    ),
    BlocProvider<FavoriteRestaurantBloc>(
      create: (context) => FavoriteRestaurantBloc(),
    ),
    BlocProvider<SettingBloc>(
      create: (context) => SettingBloc(),
    ),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant',
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      theme: ThemeData(
        primaryColor: RestaurantColors.PRIMARY_COLOR,
        accentColor: RestaurantColors.ACCENT_COLOR,
      ),
      initialRoute: homePageRoute,
      routes: {
        homePageRoute: (context) => HomePage(),
        searchRestaurantPageRoute: (context) => SearchRestaurantPage(),
        favoriteRestaurantPageRoute: (context) => FavoriteRestaurantPage(),
        settingPageRoute: (context) => SettingPage(),
        detailRestaurantPageRoute: (context) => DetailRestaurant(
            restaurant: ModalRoute.of(context).settings.arguments)
      },
    );
  }
}
