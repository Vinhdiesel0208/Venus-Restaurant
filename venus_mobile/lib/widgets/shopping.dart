import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../constants/theme.dart';
import '../widgets/dropdown.dart';

class Shopping extends StatelessWidget {
  final String body;
  final bool stock;
  final String price;
  final String img;
  final Function deleteOnPress;

  const Shopping(
      {super.key,
      required this.body,
      required this.stock,
      required this.price,
      required this.img,
      required this.deleteOnPress});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 135,
      // margin: EdgeInsets.only(top: 64),
      width: double.infinity,
      decoration: BoxDecoration(
        color: ArgonColors.white,
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Expanded(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      height: 65,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(3.0)),
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(4.0),
                          child: Image.network(img))),
                  TextButton(
                    style: TextButton.styleFrom(
                        foregroundColor: ArgonColors.white,
                        backgroundColor: ArgonColors.primary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4))),
                    onPressed: () {
                      context.pushReplacement('/home');
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 8),
                      child: Dropdown(),
                    ),
                  ),
                ]),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(body,
                        style: TextStyle(
                            color: ArgonColors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w400)),
                    Expanded(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 1.0),
                            child: Text(
                                stock == true ? 'In Stock' : 'Not In Stock',
                                style: TextStyle(
                                    color: stock == true
                                        ? ArgonColors.success
                                        : ArgonColors.error,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Text('\$$price',
                                style: TextStyle(
                                    color: ArgonColors.primary,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500)),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          style: TextButton.styleFrom(
                              foregroundColor: ArgonColors.white,
                              backgroundColor: ArgonColors.initial,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4))),
                          onPressed: () {
                            context.pushReplacement('/home');
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 6, horizontal: 8),
                            child: const Text(
                              'DELETE',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 11),
                            ),
                          ),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                              foregroundColor: ArgonColors.white,
                              backgroundColor: ArgonColors.initial,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4))),
                          onPressed: () {
                            context.pushReplacement('/home');
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 6, horizontal: 8),
                            child: const Text('SAVE FOR LATER',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 11)),
                          ),
                        )
                      ],
                    )
                  ]),
            ),
          )
        ]),
      ),
    );
  }
}
