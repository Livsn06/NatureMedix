import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:naturemedix/utils/responsive.dart';

import '../utils/NeoBox.dart';

// ignore: must_be_immutable
class CardList extends StatelessWidget {
  Widget? requestImage;
  Widget? requestTitle;
  Widget? subRequestTitle;
  final Function(BuildContext)? settingsTapped;
  final Function(BuildContext)? deleteTapped;

  CardList({
    super.key,
    required this.requestImage,
    required this.requestTitle,
    required this.subRequestTitle,
    required this.settingsTapped,
    required this.deleteTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: setResponsiveSize(context, baseSize: 5),
      ),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            // settings option
            SlidableAction(
              onPressed: settingsTapped,
              backgroundColor: Colors.grey.shade800,
              icon: Icons.settings,
              borderRadius: BorderRadius.circular(
                  setResponsiveSize(context, baseSize: 12)),
            ),

            // delete option
            SlidableAction(
              onPressed: deleteTapped,
              backgroundColor: Colors.red.shade400,
              icon: Icons.delete,
              borderRadius: BorderRadius.circular(
                  setResponsiveSize(context, baseSize: 12)),
            ),
          ],
        ),
        child: NeoBox(
          borderRadius: BorderRadius.circular(
            setResponsiveSize(context, baseSize: 5),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: setResponsiveSize(context, baseSize: 5)),
            child: ListTile(
                leading: requestImage,
                title: requestTitle,
                subtitle: subRequestTitle),
          ),
        ),
      ),
    );
  }
}
