import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thebags_mobile/constants/theme.dart';
import 'package:thebags_mobile/widgets/input.dart';

class Navbar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final String categoryOne;
  final String categoryTwo;
  final bool searchBar;
  final bool backButton;
  final bool transparent;
  final bool rightOptions;
  final Function? getCurrentPage;
  final bool isOnSearch;
  final TextEditingController? searchController;
  final Function(String)? searchOnChanged;
  final bool searchAutofocus;
  final bool noShadow;
  final Color bgColor;
  final double _preferredHeight = 180.0;
  final List<String>? tags;

  const Navbar({
    super.key,
    this.title = 'Home',
    this.categoryOne = '',
    this.categoryTwo = '',
    this.transparent = false,
    this.rightOptions = true,
    this.getCurrentPage,
    this.searchController,
    this.isOnSearch = false,
    this.searchOnChanged,
    this.searchAutofocus = false,
    this.backButton = false,
    this.noShadow = false,
    this.bgColor = ArgonColors.white,
    this.searchBar = false,
    this.tags,
  });

  @override
  State<Navbar> createState() => _NavbarState();

  @override
  Size get preferredSize => Size.fromHeight(_preferredHeight);
}

class _NavbarState extends State<Navbar> {
  // Add a method for logging out
  void _logout() async {
    // Perform the logout logic, e.g., clear shared preferences, invalidate tokens, etc.
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // This removes all data from shared preferences
    GoRouter.of(context).go(
        '/signin'); // Navigate to the sign-in screen, adjust the route as needed
  }

  @override
  Widget build(BuildContext context) {
    final bool categories =
        widget.categoryOne.isNotEmpty && widget.categoryTwo.isNotEmpty;
    return Container(
      height: widget.searchBar
          ? (!categories ? 178.0 : 210.0)
          : (!categories ? 102.0 : 150.0),
      decoration: BoxDecoration(
        color: !widget.transparent ? widget.bgColor : Colors.transparent,
        boxShadow: [
          BoxShadow(
            color: !widget.transparent && !widget.noShadow
                ? ArgonColors.initial
                : Colors.transparent,
            spreadRadius: -10,
            blurRadius: 12,
            offset: Offset(0, 5),
          )
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          widget.backButton ? Icons.arrow_back_ios : Icons.menu,
                          color: !widget.transparent
                              ? (widget.bgColor == ArgonColors.white
                                  ? ArgonColors.initial
                                  : ArgonColors.white)
                              : ArgonColors.white,
                          size: 24.0,
                        ),
                        onPressed: () {
                          if (widget.backButton) {
                            if (Navigator.canPop(context)) {
                              Navigator.pop(context);
                            } else {
                              Scaffold.of(context).openDrawer();
                            }
                          } else {
                            Scaffold.of(context).openDrawer();
                          }
                        },
                      ),
                      Text(
                        widget.title,
                        style: TextStyle(
                          color: !widget.transparent
                              ? (widget.bgColor == ArgonColors.white
                                  ? ArgonColors.initial
                                  : ArgonColors.white)
                              : ArgonColors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                  if (widget.rightOptions)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          child: IconButton(
                            icon: Icon(
                              Icons.shopping_cart,
                              color: !widget.transparent
                                  ? (widget.bgColor == ArgonColors.white
                                      ? ArgonColors.initial
                                      : ArgonColors.white)
                                  : ArgonColors.white,
                              size: 22.0,
                            ),
                            onPressed: null,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.article,
                            color: !widget.transparent
                                ? (widget.bgColor == ArgonColors.white
                                    ? ArgonColors.initial
                                    : ArgonColors.white)
                                : ArgonColors.white,
                            size: 22.0,
                          ),
                          onPressed: () {
                            context.push('/post'); // Chuyển đến màn hình Post
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.contact_phone,
                            color: !widget.transparent
                                ? (widget.bgColor == ArgonColors.white
                                    ? ArgonColors.initial
                                    : ArgonColors.white)
                                : ArgonColors.white,
                            size: 22.0,
                          ),
                          onPressed: () {
                            context.push(
                                '/contact'); // Chuyển đến màn hình Contact
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.chair,
                            color: !widget.transparent
                                ? (widget.bgColor == ArgonColors.white
                                    ? ArgonColors.initial
                                    : ArgonColors.white)
                                : ArgonColors.white,
                            size: 22.0,
                          ),
                          onPressed: () {
                            context.push(
                                '/bookingtable'); // Chuyển đến màn hình Contact
                          },
                        ),
                      ],
                    ),
                ],
              ),
              if (widget.searchBar)
                Padding(
                  padding: const EdgeInsets.only(
                      top: 8, bottom: 4, left: 15, right: 15),
                  child: Input(
                    placeholder: 'What are you looking for?',
                    controller: widget.searchController,
                    onChanged: widget.searchOnChanged,
                    autofocus: widget.searchAutofocus,
                    suffixIcon: Icon(Icons.zoom_in, color: ArgonColors.muted),
                    onTap: () {
                      //TO DO:
                    },
                    borderColor: ArgonColors.border,
                  ),
                ),
              SizedBox(
                height: 10.0,
              ),
              if (categories)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        //TO DO NAV
                      },
                      child: Row(
                        children: [
                          Icon(Icons.park,
                              color: ArgonColors.initial, size: 22.0),
                          SizedBox(width: 10),
                          Text(
                            widget.categoryOne,
                            style: TextStyle(
                                color: ArgonColors.initial, fontSize: 16.0),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 30),
                    Container(
                      color: ArgonColors.initial,
                      height: 25,
                      width: 1,
                    ),
                    SizedBox(width: 30),
                    GestureDetector(
                      onTap: () {
                        //TO DO NAV
                      },
                      child: Row(
                        children: [
                          Icon(Icons.shopping_basket,
                              color: ArgonColors.initial, size: 22.0),
                          SizedBox(width: 10),
                          Text(
                            widget.categoryTwo,
                            style: TextStyle(
                                color: ArgonColors.initial, fontSize: 16.0),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
