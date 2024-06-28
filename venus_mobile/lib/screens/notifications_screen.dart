import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:thebags_mobile/constants/theme.dart';
import 'package:thebags_mobile/widgets/navbar.dart';
import 'package:thebags_mobile/widgets/personal_notification.dart';
import 'package:thebags_mobile/widgets/system_notification.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static List<Widget> _widgetOptions = <Widget>[
    Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: PersonalNotifications(),
    ),
    Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: SystemNotifications(),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Navbar(
          title: 'Notifications',
          backButton: true,
          rightOptions: false,
        ),
        backgroundColor: ArgonColors.bgColorScreen,
        bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: 'Personal'),
              BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.database, size: 16),
                  label: 'System')
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: ArgonColors.primary,
            onTap: _onItemTapped),
        body: Padding(
          padding: const EdgeInsets.only(left: 24.0, right: 24.0),
          child: _widgetOptions.elementAt(_selectedIndex),
        ));
  }
}
