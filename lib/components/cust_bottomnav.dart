import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:naturemedix/utils/_initApp.dart';
import '../../utils/responsive.dart';

class ButtomNav extends StatelessWidget with Application {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const ButtomNav({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: setResponsiveSize(context, baseSize: 80),
      decoration: BoxDecoration(
        color: color.white,
        borderRadius: BorderRadius.circular(
          setResponsiveSize(context, baseSize: 10),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(5, (index) {
                final isSelected = selectedIndex == index;
                return Expanded(
                  child: Container(
                    height: setResponsiveSize(context, baseSize: 8),
                    margin: EdgeInsets.symmetric(
                      horizontal: setResponsiveSize(context, baseSize: 5),
                    ),
                    decoration: isSelected
                        ? BoxDecoration(
                            color: color.primary,
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(
                                setResponsiveSize(context, baseSize: 8),
                              ),
                              bottomLeft: Radius.circular(
                                setResponsiveSize(context, baseSize: 8),
                              ),
                            ),
                          )
                        : null,
                  ),
                );
              }),
            ),
          ),
          // Container for the icons
          Positioned.fill(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(5, (index) {
                final isSelected = selectedIndex == index;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => onTap(index),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          isSelected
                              ? _getFillIcon(index)
                              : _getOutlineIcon(index),
                          color: isSelected ? color.primary : color.primarylow,
                          size: _getIconSize(index),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getOutlineIcon(int index) {
    return [
      Icons.home_outlined,
      FontAwesomeIcons.bookmark,
      Icons.qr_code_scanner,
      FontAwesomeIcons.squarePlus,
      FontAwesomeIcons.user,
    ][index];
  }

  IconData _getFillIcon(int index) {
    return [
      Icons.home_rounded,
      FontAwesomeIcons.solidBookmark,
      Icons.qr_code_scanner,
      FontAwesomeIcons.solidSquarePlus,
      FontAwesomeIcons.solidUser,
    ][index];
  }

  double _getIconSize(int index) {
    return [34.0, 22.0, 40.0, 27.0, 23.0][index];
  }
}
