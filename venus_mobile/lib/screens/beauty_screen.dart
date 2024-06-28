import 'package:flutter/material.dart';
import 'package:thebags_mobile/constants/theme.dart';
import 'package:thebags_mobile/data/beautycard.dart';
import 'package:thebags_mobile/screens/category_screen.dart';
import 'package:thebags_mobile/widgets/card_category.dart';
import 'package:thebags_mobile/widgets/navbar.dart';

class BeautyScreen extends StatefulWidget {
  const BeautyScreen({super.key});

  @override
  State<BeautyScreen> createState() => _BeautyScreenState();
}

class _BeautyScreenState extends State<BeautyScreen> {
  final List<String> tags = ['Music', 'Beauty', 'Fashion', 'Clothes'];
  static String currentTag = '';

  _getCurrentPage(activeTag) {
    setState(() {
      currentTag = activeTag;
      print('currentTag is $currentTag');
    });
  }

  @override
  void initState() {
    currentTag = tags[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Navbar(
          title: 'Beauty',
          tags: tags,
          getCurrentPage: _getCurrentPage,
          backButton: true,
        ),
        backgroundColor: ArgonColors.bgColorScreen,
        extendBodyBehindAppBar: true,
        body: Container(
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: CardCategory(
                        tap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CategoryScreen(
                                    screenTitle: beautyCards[currentTag]?[index]
                                        ['title'],
                                    suggestionsArray: beautyCards[currentTag]
                                        ?[index]['suggestions'],
                                    imgArray: beautyCards[currentTag]?[index]
                                        ['products']),
                              ));
                        },
                        title: beautyCards[currentTag]?[index]['title'],
                        img: beautyCards[currentTag]?[index]['image']),
                  );
                },
                itemCount: beautyCards[currentTag]?.length)));
  }
}
