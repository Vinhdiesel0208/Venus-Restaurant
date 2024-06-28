import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/theme.dart';
import '../widgets/drawer_title.dart';

class ArgonDrawer extends StatelessWidget {
  final String currentPage;

  const ArgonDrawer({super.key, required this.currentPage});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: ArgonColors.white,
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width * 0.85,
              child: SafeArea(
                bottom: false,
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 32),
                    child: Image.asset('assets/imgs/logo-thebags.png'),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: ListView(
                padding: EdgeInsets.only(top: 24, left: 16, right: 16),
                children: [
                  DrawerTitle(
                      icon: Icons.home,
                      onTap: () {
                        if (currentPage != 'Home') {
                          context.push('/home');
                        }
                      },
                      iconColor: ArgonColors.primary,
                      title: 'Home',
                      isSelected: currentPage == 'Home'),
                  DrawerTitle(
                      icon: Icons.article,
                      onTap: () {
                        if (currentPage != 'Post') {
                          context.push('/post');
                        }
                      },
                      iconColor: ArgonColors.primary,
                      title: 'Post',
                      isSelected: currentPage == 'Post'),
                  DrawerTitle(
                      icon: Icons.contact_mail,
                      onTap: () {
                        if (currentPage != 'Contact') {
                          context.push('/contact');
                        }
                      },
                      iconColor: ArgonColors.primary,
                      title: 'Contact',
                      isSelected: currentPage == 'Contact'),
                  DrawerTitle(
                      icon: Icons.list_alt,
                      onTap: () {
                        if (currentPage != 'Order Status') {
                          context.push('/staff-order-status');
                        }
                      },
                      iconColor: Color.fromARGB(255, 219, 14, 14),
                      title: 'Kitchen Status',
                      isSelected: currentPage == 'Order Status'),
                  DrawerTitle(
                    icon: Icons.person,
                    onTap: () {
                      if (currentPage != 'Customer Detail') {
                        context.push('/user_detail');
                      }
                    },
                    iconColor: Color.fromARGB(255, 220, 64, 251),
                    title: 'Customer Detail',
                    isSelected: currentPage == 'Customer Detail',
                  ),
                  DrawerTitle(
                      icon: Icons.kitchen,
                      onTap: () {
                        if (currentPage != 'Tables') {
                          context.push('/tables');
                        }
                      },
                      iconColor: ArgonColors.primary,
                      title: 'Tables',
                      isSelected: currentPage == 'Tables'),
                  ListTile(
                    leading: Icon(Icons.logout, color: ArgonColors.muted),
                    title: Text('Logout',
                        style: TextStyle(color: ArgonColors.initial)),
                    onTap: () async {
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.clear();
                      context.go('/signin');
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
