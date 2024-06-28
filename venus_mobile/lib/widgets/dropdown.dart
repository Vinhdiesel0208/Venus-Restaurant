import 'package:flutter/material.dart';
import '../constants/theme.dart';

class Dropdown extends StatefulWidget {
  const Dropdown({super.key});

  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  String dropdownValue = '1';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 14.0,
      child: DropdownButtonHideUnderline(
        child: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: ArgonColors.initial,
          ),
          child: DropdownButton<String>(
            value: dropdownValue,
            icon: Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Icon(
                Icons.keyboard_arrow_down,
                color: ArgonColors.white,
              ),
            ),
            iconSize: 20,
            elevation: 1,
            style: TextStyle(color: ArgonColors.white),
            items: <String>['1', '2', '3', '4']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value,
                    style: TextStyle(
                        color: ArgonColors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 12.0)),
              );
            }).toList(),
            onChanged: (String? value) {},
          ),
        ),
      ),
    );
  }
}
