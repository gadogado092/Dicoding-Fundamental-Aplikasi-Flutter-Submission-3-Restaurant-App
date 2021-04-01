import 'package:flutter/material.dart';
import 'package:restaurant_app/bloc/restaurant_bloc.dart';
import 'package:restaurant_app/bloc/restaurant_event.dart';
import 'package:restaurant_app/bloc/restaurant_state.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/res/colors.dart';
import 'package:restaurant_app/routes/route_paths.dart';
import 'package:restaurant_app/utils/background_service.dart';
import 'package:restaurant_app/utils/notification_helper.dart';
import 'package:restaurant_app/widgets/base_text.dart';
import 'package:restaurant_app/widgets/empty.dart';
import 'package:restaurant_app/widgets/error.dart';
import 'package:restaurant_app/widgets/item_restaurant.dart';
import 'package:restaurant_app/widgets/loading.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  RestaurantBloc _restaurantBloc;
  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  @override
  void initState() {
    _restaurantBloc = BlocProvider.of(this.context);
    _restaurantBloc.add(FetchRestaurant());
    port.listen((_) async => await _service.someTask());
    _notificationHelper
        .configureSelectNotificationSubject(detailRestaurantPageRoute);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    selectNotificationSubject.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
              height: 150,
              child: Stack(
                children: [
                  Container(
                    height: 150,
                    padding: EdgeInsets.all(24),
                    color: RestaurantColors.PRIMARY_COLOR,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        BaseText(
                          text: 'Juragan Restaurant',
                          typographicScale: TypographicScale.H1,
                          textColor: Colors.white,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        BaseText(
                            text: 'Where do you want to Eat?',
                            textColor: Colors.white)
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, searchRestaurantPageRoute);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 16),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        BaseText(
                                          text: 'Find Restaurant',
                                          textColor:
                                              RestaurantColors.GREY_COLOR_1,
                                        ),
                                        Icon(
                                          Icons.search,
                                          color: RestaurantColors.PRIMARY_COLOR,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              iconSize: 32,
                              color: Colors.white,
                              icon: Icon(Icons.favorite),
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  favoriteRestaurantPageRoute,
                                );
                              },
                            ),
                            IconButton(
                              iconSize: 32,
                              color: Colors.white,
                              icon: Icon(Icons.settings),
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  settingPageRoute,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              )),
          Expanded(child: BlocBuilder<RestaurantBloc, RestaurantState>(
            builder: (context, state) {
              if (state is RestaurantLoadSuccess) {
                return ListView.builder(
                    itemCount: state.listRestaurant.length,
                    itemBuilder: (context, position) {
                      Restaurant restaurant = state.listRestaurant[position];
                      return ItemRestaurant(
                        restaurant: restaurant,
                        onTap: () {
                          Navigator.pushNamed(
                              context, detailRestaurantPageRoute,
                              arguments: restaurant);
                        },
                      );
                    });
              } else if (state is RestaurantLoadFailure) {
                return Error(
                  onTap: () => _restaurantBloc.add(FetchRestaurant()),
                );
              } else if (state is RestaurantEmptyData) {
                return EmptyWidget(
                  msg: "Data Restaurant Belum Ada",
                );
              }
              return LoadingWidget();
            },
          ))
        ],
      )),
    );
  }
}
