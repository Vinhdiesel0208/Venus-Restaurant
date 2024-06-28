import 'package:flutter/material.dart';
import 'package:thebags_mobile/constants/theme.dart';

class CardCategory extends StatelessWidget {
  final String img;
  final Function()? tap;
  final String title;

  const CardCategory(
      {super.key, required this.img, this.tap, required this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 252,
        width: null,
        child: GestureDetector(
          onTap: tap,
          child: Card(
              elevation: 0.4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(6.0))),
              child: Stack(children: [
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(6.0)),
                        image: DecorationImage(
                          image: NetworkImage(img),
                          fit: BoxFit.cover,
                        ))),
                Container(
                    decoration: BoxDecoration(
                        color: Colors.black45,
                        borderRadius: BorderRadius.all(Radius.circular(6.0)))),
                Center(
                  child: Text(title,
                      style: TextStyle(
                          color: ArgonColors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 18.0)),
                )
              ])),
        ));
  }
}
