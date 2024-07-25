import 'package:flutter/material.dart';
import 'package:naturemedix/themes/text_styles.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData systemTheme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("NatureMedix"),
      ),
      body: Text(
        "Hello world!",
        style: ApplicationTextStyle.displayLarge(context: context),
      ),
    );
  }
}
