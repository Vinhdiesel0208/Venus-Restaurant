import 'package:flutter/material.dart';
import 'package:thebags_mobile/constants/theme.dart';
import 'package:thebags_mobile/widgets/drawer.dart';
import 'package:thebags_mobile/widgets/navbar.dart';
import 'package:thebags_mobile/widgets/table_cell.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late bool switchValueOne;
  late bool switchValueTwo;

  @override
  void initState() {
    setState(() {
      switchValueOne = false;
      switchValueTwo = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Navbar(
          title: 'Settings',
        ),
        drawer: ArgonDrawer(currentPage: 'Settings'),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text('Recommended Settings',
                        style: TextStyle(
                            color: ArgonColors.text,
                            fontWeight: FontWeight.w600,
                            fontSize: 18)),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text('These are the most important settings',
                        style:
                            TextStyle(color: ArgonColors.text, fontSize: 14)),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Use FaceID to signin',
                        style: TextStyle(color: ArgonColors.text)),
                    Switch.adaptive(
                      value: switchValueOne,
                      onChanged: (bool newValue) =>
                          setState(() => switchValueOne = newValue),
                      activeColor: ArgonColors.primary,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Auto-Lock security',
                        style: TextStyle(color: ArgonColors.text)),
                    Switch.adaptive(
                      value: switchValueTwo,
                      onChanged: (bool newValue) =>
                          setState(() => switchValueTwo = newValue),
                      activeColor: ArgonColors.primary,
                    )
                  ],
                ),
                TableCellSettings(
                    title: 'Notifications',
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => NotificationsSettings()));
                    }),
                SizedBox(height: 36.0),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text('Payment Settings',
                        style: TextStyle(
                            color: ArgonColors.text,
                            fontWeight: FontWeight.w600,
                            fontSize: 18)),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text('These are also important settings',
                        style: TextStyle(color: ArgonColors.text)),
                  ),
                ),
                TableCellSettings(title: 'Manage Payment Options'),
                TableCellSettings(title: 'Manage Gift Cards'),
                SizedBox(
                  height: 36.0,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text('Privacy Settings',
                        style: TextStyle(
                            color: ArgonColors.text,
                            fontWeight: FontWeight.w600,
                            fontSize: 18)),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text('Third most important settings',
                        style: TextStyle(color: ArgonColors.text)),
                  ),
                ),
                TableCellSettings(title: 'User Agreement', onTap: () {}),
                TableCellSettings(title: 'Privacy', onTap: () {}),
                TableCellSettings(title: 'About', onTap: () {}),
              ],
            ),
          ),
        ));
  }
}
