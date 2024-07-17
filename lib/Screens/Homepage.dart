import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../Components/LabelText.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: LabelText(
        label: 'NatureMedix',
        fontSize: 25,
        letterSpace: 5,
      )),
    );
  }
}
