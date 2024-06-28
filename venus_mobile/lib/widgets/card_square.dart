import 'package:flutter/material.dart';
import 'package:thebags_mobile/constants/theme.dart';

class CardSquare extends StatelessWidget {
  final String cta;
  final String img;
  final Function()? tap;
  final String title;

  const CardSquare(
      {super.key,
      required this.cta,
      required this.img,
      this.tap,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 250,
        width: null,
        child: GestureDetector(
          onTap: tap,
          child: Card(
              elevation: 0.4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                      flex: 3,
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(6.0),
                                  topRight: Radius.circular(6.0)),
                              image: DecorationImage(
                                image: NetworkImage(img),
                                fit: BoxFit.cover,
                              )))),
                  Flexible(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, bottom: 8.0, left: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(title,
                                style: TextStyle(
                                    color: ArgonColors.header, fontSize: 13)),
                            Text(cta,
                                style: TextStyle(
                                    color: ArgonColors.primary,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600))
                          ],
                        ),
                      ))
                ],
              )),
        ));
  }
}
