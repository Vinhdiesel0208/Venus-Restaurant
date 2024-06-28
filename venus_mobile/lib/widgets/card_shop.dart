import 'package:flutter/material.dart';
import 'package:thebags_mobile/constants/theme.dart';

class CardShop extends StatelessWidget {
  final String image;
  final String title;

  const CardShop({super.key, required this.image, required this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 230,
        width: 180,
        child: GestureDetector(
          child: Card(
              elevation: 0.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              child: Container(
                decoration: BoxDecoration(
                  color: ArgonColors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: Offset(0, 2), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                        flex: 2,
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(6.0),
                                    topRight: Radius.circular(6.0)),
                                image: DecorationImage(
                                  image: NetworkImage(image),
                                  fit: BoxFit.cover,
                                )))),
                    Flexible(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, bottom: 8.0, left: 8.0, right: 8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(title,
                                  style: TextStyle(
                                      color: ArgonColors.black, fontSize: 14)),
                            ],
                          ),
                        ))
                  ],
                ),
              )),
        ));
  }
}
