import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Settungs Screen',
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
