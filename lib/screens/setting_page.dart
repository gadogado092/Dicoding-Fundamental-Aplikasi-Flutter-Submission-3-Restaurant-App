import 'package:flutter/material.dart';
import 'package:restaurant_app/widgets/base_text.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
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
              
              Switch(
                  activeTrackColor: Colors.blueAccent,
                  activeColor: Colors.white,
                  value: true,
                  onChanged: (value) async {}),
            ],
          ),
        ),
      ),
    );
  }
}
