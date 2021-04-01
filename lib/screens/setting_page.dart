import 'dart:io';

import 'package:flutter/material.dart';
import 'package:restaurant_app/bloc/setting_bloc.dart';
import 'package:restaurant_app/bloc/setting_event.dart';
import 'package:restaurant_app/bloc/setting_state.dart';
import 'package:restaurant_app/widgets/base_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/widgets/custom_dialog.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  SettingBloc _settingBloc;

  @override
  void initState() {
    _settingBloc = BlocProvider.of(this.context);
    _settingBloc.add(GetValue());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BaseText(
          text: "Setting",
          typographicScale: TypographicScale.Title,
          textColor: Colors.white,
        ),
      ),
      body: Card(
        margin: EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BaseText(
                text: "Restaurant Notification",
                typographicScale: TypographicScale.Title,
                fontWeight: FontWeight.w500,
              ),
              BlocBuilder<SettingBloc, SettingState>(builder: (context, state) {
                if (state is LoadData) {
                  return Switch(
                      activeTrackColor: Colors.blueAccent,
                      activeColor: Colors.white,
                      value: state.isActive,
                      onChanged: (value) async {
                        if (Platform.isIOS) {
                          customDialog(context);
                        } else {
                          _settingBloc.add(SetValue(value));
                        }
                      });
                }
                return Container();
              }),
            ],
          ),
        ),
      ),
    );
  }
}
