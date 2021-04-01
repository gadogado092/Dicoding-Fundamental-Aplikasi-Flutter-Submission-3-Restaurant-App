import 'package:flutter/material.dart';
import 'package:restaurant_app/bloc/detail_restaurant_bloc.dart';
import 'package:restaurant_app/bloc/favorite_restaurant_bloc.dart';
import 'package:restaurant_app/bloc/restaurant_bloc.dart';
import 'package:restaurant_app/bloc/search_restaurant_bloc.dart';
import 'package:restaurant_app/res/colors.dart';
import 'package:restaurant_app/routes/route_paths.dart';
import 'package:restaurant_app/screens/detail_restaurant_page.dart';
import 'package:restaurant_app/screens/favorite_restaurant_page.dart';
import 'package:restaurant_app/screens/home_page.dart';
import 'package:restaurant_app/screens/search_restaurant_page.dart';
import 'package:restaurant_app/screens/setting_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
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
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant',
      debugShowCheckedModeBanner: false,
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
