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
    );
  }
}
