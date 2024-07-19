import 'package:flutter/material.dart';
import 'package:naturemedix/providers/sample.dart';

import 'package:provider/provider.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<SampleProvider>(
        builder: (context, value, child) => Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Splashscreen"),
              ElevatedButton(
                onPressed: () => value.printme(),
                child: const Text('click me'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
