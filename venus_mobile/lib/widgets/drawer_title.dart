import 'package:flutter/material.dart';
import 'package:thebags_mobile/constants/theme.dart';

class DrawerTitle extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function()? onTap;
  final bool isSelected;
  final Color iconColor;

  const DrawerTitle(
      {super.key,
      required this.title,
      required this.icon,
      this.onTap,
      required this.isSelected,
      required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: isSelected ? ArgonColors.primary : ArgonColors.white,
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Row(
            children: [
              Icon(icon,
                  size: 20, color: isSelected ? ArgonColors.white : iconColor),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(title,
                    style: TextStyle(
                        letterSpacing: .3,
                        fontSize: 15,
                        fontWeight: FontWeight.w200,
                        color: isSelected
                            ? ArgonColors.white
                            : Color.fromRGBO(0, 0, 0, 0.7))),
              )
            ],
          )),
    );
  }
}
