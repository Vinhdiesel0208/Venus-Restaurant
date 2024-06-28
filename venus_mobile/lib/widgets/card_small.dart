import 'package:flutter/material.dart';
import 'package:thebags_mobile/constants/theme.dart';

class CardSmall extends StatelessWidget {
  final String? cta;
  final String img;
  final Function()? tap;
  final String title;

  const CardSmall(
      {super.key, this.cta, required this.img, this.tap, required this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 130,
        child: GestureDetector(
          onTap: tap,
          child: Card(
            elevation: 0.6,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(6.0))),
            child: Row(
              children: [
                Flexible(
                  flex: 1,
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(6.0),
                              bottomLeft: Radius.circular(6.0)),
                          image: DecorationImage(
                            image: NetworkImage(img),
                            fit: BoxFit.cover,
                          ))),
                ),
                Flexible(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(title,
                              style: TextStyle(
                                  color: ArgonColors.header, fontSize: 13)),
                          if (cta != null)
                            Text(cta!,
                                style: TextStyle(
                                    color: ArgonColors.primary,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ));
  }
}
