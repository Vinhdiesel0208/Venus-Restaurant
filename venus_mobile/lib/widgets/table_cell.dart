import 'package:flutter/material.dart';
import 'package:thebags_mobile/constants/theme.dart';

class TableCellSettings extends StatelessWidget {
  final String title;
  final Function()? onTap;

  const TableCellSettings({super.key, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: TextStyle(color: ArgonColors.text)),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(Icons.arrow_forward_ios,
                  color: ArgonColors.text, size: 14),
            )
          ],
        ),
      ),
    );
  }
}
