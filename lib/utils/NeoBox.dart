import 'package:flutter/material.dart';
import 'package:naturemedix/utils/responsive.dart';

class NeoBox extends StatelessWidget {
  const NeoBox({Key? key, this.child, this.borderRadius});
  final Widget? child;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius ??
            BorderRadius.circular(setResponsiveSize(context, baseSize: 15)),
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
