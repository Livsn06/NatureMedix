import 'package:flutter/material.dart';

class NeoBox extends StatelessWidget {
  const NeoBox({Key? key, this.child});
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height * 0.02,
        horizontal: MediaQuery.of(context).size.width * 0.02,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade500,
            blurRadius: 5,
            offset: const Offset(3, 3),
          ),
          const BoxShadow(
            color: Colors.white38,
            blurRadius: 7,
            offset: Offset(-3, -3),
          ),
        ],
      ),
      child: child,
    );
  }
}
