import 'package:flutter/material.dart';
import 'package:restaurant_app/bloc/detail_restaurant_bloc.dart';
import 'package:restaurant_app/bloc/detail_restaurant_event.dart';
import 'package:restaurant_app/bloc/detail_restaurant_state.dart';
import 'package:restaurant_app/bloc/favorite_restaurant_bloc.dart';
import 'package:restaurant_app/bloc/favorite_restaurant_event.dart';
import 'package:restaurant_app/bloc/favorite_restaurant_state.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/res/colors.dart';
import 'package:restaurant_app/widgets/base_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/widgets/error.dart';
import 'package:restaurant_app/widgets/loading.dart';

class DetailRestaurant extends StatefulWidget {
  final Restaurant restaurant;

  const DetailRestaurant({this.restaurant}) : super();

  @override
  _DetailRestaurantState createState() => _DetailRestaurantState();
}

class _DetailRestaurantState extends State<DetailRestaurant> {
  DetailRestaurantBloc _detailRestaurantBloc;
  FavoriteRestaurantBloc _favoriteRestaurantBloc;

  @override
  void initState() {
    _detailRestaurantBloc = BlocProvider.of(this.context);
    _detailRestaurantBloc.add(FetchDetailRestaurant(widget.restaurant.id));

    _favoriteRestaurantBloc = BlocProvider.of(this.context);
    _favoriteRestaurantBloc.add(FetchFavoriteStatus(widget.restaurant));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BaseText(
                text: widget.restaurant.name,
                typographicScale: TypographicScale.Title,
                textColor: Colors.white,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.star,
                    size: 24,
                    color: RestaurantColors.WARNING_COLOR,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  BaseText(
                    text: widget.restaurant.rating.toString(),
                    textColor: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            ],
          ),
        ),
        body: BlocBuilder<DetailRestaurantBloc, DetailRestaurantState>(
          builder: (context, state) {
            if (state is RestaurantLoadSuccess) {
              return _buildRestaurant(
                context,
                state.restaurant,
              );
            } else if (state is RestaurantLoadFailure) {
              return Error(
                onTap: () => _detailRestaurantBloc
                    .add(FetchDetailRestaurant(widget.restaurant.id)),
              );
            }
            return LoadingWidget();
          },
        ));
  }

  SingleChildScrollView _buildRestaurant(
      BuildContext context, Restaurant restaurant) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 220.0,
            margin: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildIconFavorite(restaurant),
              ],
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      "${ApiService.baseUrlImage}medium/${restaurant.pictureId}")),
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              color: RestaurantColors.GREY_COLOR_3,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.location_city,
                  size: 24,
                  color: RestaurantColors.ACCENT_COLOR,
                ),
                SizedBox(
                  width: 4,
                ),
                BaseText(
                  text: "${restaurant.city} - ${restaurant.address}",
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: BaseText(
              text: restaurant.description,
              textAlign: TextAlign.justify,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 0, 0),
            child: BaseText(
              text: "Category",
              typographicScale: TypographicScale.Title,
              textSize: 16,
            ),
          ),
          Container(
            height: 50,
            child: ListView.builder(
                itemCount: restaurant.category.length,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.zero,
                itemBuilder: (
                  context,
                  index,
                ) {
                  return Container(
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      color: RestaurantColors.GREY_COLOR_2,
                    ),
                    child: Center(
                      child: BaseText(
                        textColor: Colors.black54,
                        text: restaurant.category[index].name,
                        typographicScale: TypographicScale.Caption,
                      ),
                    ),
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 0, 0),
            child: BaseText(
              text: "Makanan",
              typographicScale: TypographicScale.Title,
              textSize: 16,
            ),
          ),
          Container(
            height: 50,
            child: ListView.builder(
                itemCount: restaurant.menu.listFood.length,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.zero,
                itemBuilder: (
                  context,
                  index,
                ) {
                  return Container(
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      color: RestaurantColors.GREY_COLOR_2,
                    ),
                    child: Center(
                      child: BaseText(
                        textColor: Colors.black54,
                        text: restaurant.menu.listFood[index].name,
                        typographicScale: TypographicScale.Caption,
                      ),
                    ),
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 0, 0),
            child: BaseText(
              text: "Minuman",
              typographicScale: TypographicScale.Title,
              textSize: 16,
            ),
          ),
          Container(
            height: 50,
            child: ListView.builder(
                itemCount: restaurant.menu.listDrink.length,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.zero,
                itemBuilder: (
                  context,
                  index,
                ) {
                  return Container(
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      color: RestaurantColors.GREY_COLOR_2,
                    ),
                    child: Center(
                      child: BaseText(
                        textColor: Colors.black54,
                        text: restaurant.menu.listDrink[index].name,
                        typographicScale: TypographicScale.Caption,
                      ),
                    ),
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 0, 0),
            child: BaseText(
              text: "Review",
              typographicScale: TypographicScale.Title,
              textSize: 16,
            ),
          ),
          Container(
            child: ListView.builder(
                itemCount: restaurant.customerReview.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemBuilder: (
                  context,
                  index,
                ) {
                  return Card(
                    margin: EdgeInsets.all(8),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          BaseText(
                            textColor: Colors.black87,
                            text: restaurant.customerReview[index].name,
                          ),
                          BaseText(
                            textColor: Colors.black54,
                            text: restaurant.customerReview[index].review,
                            typographicScale: TypographicScale.Caption,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          BaseText(
                            textColor: Colors.black54,
                            text: restaurant.customerReview[index].date,
                            typographicScale: TypographicScale.Caption,
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }

  Widget _buildIconFavorite(Restaurant restaurant) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(8),
          bottomLeft: Radius.circular(8),
        ),
        color: RestaurantColors.GREY_COLOR_1,
      ),
      child: BlocBuilder<FavoriteRestaurantBloc, FavoriteRestaurantState>(
        builder: (context, state) {
          if (state is LoadData) {
            if (state.isFavorite) {
              return IconButton(
                icon: Icon(
                  Icons.favorite,
                  color: Colors.white,
                ),
                onPressed: () {
                  _favoriteRestaurantBloc.add(DeleteFavorite(restaurant));
                },
              );
            } else {
              return IconButton(
                icon: Icon(
                  Icons.favorite_border,
                  color: Colors.white,
                ),
                onPressed: () {
                  _favoriteRestaurantBloc.add(AddFavorite(restaurant));
                },
              );
            }
          }
          return Container();
        },
      ),
    );
  }
}
