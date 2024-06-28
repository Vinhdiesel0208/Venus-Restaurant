import 'package:flutter/material.dart';
import 'package:thebags_mobile/constants/theme.dart';
import 'package:thebags_mobile/widgets/card_small.dart';
import 'package:thebags_mobile/widgets/navbar.dart';
import 'package:thebags_mobile/widgets/product_sider.dart';

class CategoryScreen extends StatefulWidget {
  final String screenTitle;
  final List<Map<String, String>> imgArray;
  final List<Map<String, dynamic>> suggestionsArray;

  const CategoryScreen(
      {super.key,
      required this.imgArray,
      required this.suggestionsArray,
      this.screenTitle = 'Category'});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Navbar(
          title: widget.screenTitle,
          backButton: true,
        ),
        backgroundColor: ArgonColors.bgColorScreen,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                // height: 700,
                padding: EdgeInsets.only(top: 16.0),
                child: ProductCarousel(imgArray: widget.imgArray),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Flexible(
                      child: CardSmall(
                          img: widget.suggestionsArray[0]['img']!,
                          title: widget.suggestionsArray[0]['title']!,
                          tap: () {}),
                    ),
                    Flexible(
                      child: CardSmall(
                          img: widget.suggestionsArray[1]['img']!,
                          title: widget.suggestionsArray[1]['title']!,
                          tap: () {}),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
