import 'package:flutter/material.dart';

class Error extends StatelessWidget {
  final Function() onTap;

  Error({this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.refresh,
            size: 32,
            color: Colors.black54,
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            "Tap untuk memuat ulang.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black54),
          ),
        ],
      )),
    );
  }
}
