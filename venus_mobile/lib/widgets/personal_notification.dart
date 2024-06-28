import 'package:flutter/material.dart';
import 'package:thebags_mobile/constants/theme.dart';
import 'package:thebags_mobile/data/notificationscard.dart';

class PersonalNotifications extends StatelessWidget {
  const PersonalNotifications({super.key});

  _personalCardBgColor(int index) {
    switch (personalNotificationsList[index]['color']) {
      case 'primary':
        {
          return ArgonColors.primary;
        }
      case 'info':
        {
          return ArgonColors.info;
        }
      case 'error':
        {
          return ArgonColors.error;
        }
      case 'success':
        {
          return ArgonColors.success;
        }
      default:
        {
          return ArgonColors.primary;
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: personalNotificationsList.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
              margin: EdgeInsets.only(top: 16.0, bottom: 0.0),
              elevation: 1,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 10.0, right: 10.0, top: 36, bottom: 36),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: ArgonColors.muted.withOpacity(.15),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 15,
                                spreadRadius: 5,
                                color: ArgonColors.muted.withOpacity(.25),
                              )
                            ]),
                        child: CircleAvatar(
                            radius: 24,
                            backgroundColor: _personalCardBgColor(index),
                            child: Icon(Icons.local_shipping,
                                color: ArgonColors.white, size: 24.0)),
                      ),
                      Flexible(
                          child: Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                        child: Text(personalNotificationsList[index]['text']!,
                            style: TextStyle(color: ArgonColors.text)),
                      )),
                      Row(
                        children: [
                          Icon(Icons.timelapse,
                              size: 14.0, color: ArgonColors.muted),
                          SizedBox(
                            width: 3,
                          ),
                          Text(personalNotificationsList[index]['time']!,
                              style: TextStyle(color: ArgonColors.muted)),
                        ],
                      )
                    ]),
              ));
        });
  }
}
