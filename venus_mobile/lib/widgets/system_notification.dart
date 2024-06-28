import 'package:flutter/material.dart';
import 'package:thebags_mobile/constants/theme.dart';
import 'package:thebags_mobile/data/notificationscard.dart';

class SystemNotifications extends StatelessWidget {
  const SystemNotifications({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            color: ArgonColors.white,
            margin: EdgeInsets.only(top: 32.0),
            // height: 400,
            child: Column(
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text('Unread notifications',
                          style: TextStyle(
                              fontSize: 18.0,
                              color: ArgonColors.text,
                              fontWeight: FontWeight.w600)),
                    )),
                Divider(
                  thickness: 1,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 5,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                      itemCount:
                          systemNotificationsList['Unread notifications']!
                              .length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              top: 16.0, left: 8, right: 8, bottom: 24.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: CircleAvatar(
                                  radius: 15,
                                  backgroundColor: ArgonColors.success,
                                  child: Icon(Icons.chat_bubble,
                                      size: 16, color: ArgonColors.white),
                                ),
                              ),
                              Flexible(
                                flex: 5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          flex: 2,
                                          child: Text(
                                              systemNotificationsList[
                                                      'Unread notifications']![
                                                  index]['title']!,
                                              style: TextStyle(
                                                  color: ArgonColors.muted,
                                                  fontWeight: FontWeight.w400)),
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.timelapse,
                                                size: 14.0,
                                                color: ArgonColors.muted),
                                            SizedBox(
                                              width: 3,
                                            ),
                                            Text(
                                                systemNotificationsList[
                                                        'Unread notifications']![
                                                    index]['time']!,
                                                style: TextStyle(
                                                    color: ArgonColors.muted)),
                                          ],
                                        )
                                      ],
                                    ),
                                    Text(
                                        systemNotificationsList[
                                                'Unread notifications']![index]
                                            ['description']!,
                                        style: TextStyle(
                                            color: ArgonColors.text,
                                            fontWeight: FontWeight.w600))
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      }),
                )
              ],
            ),
          ),
          Container(
            color: ArgonColors.white,
            margin: EdgeInsets.only(top: 32.0),
            // height: 400,
            child: Column(
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text('Read notifications',
                          style: TextStyle(
                              fontSize: 18.0,
                              color: ArgonColors.text,
                              fontWeight: FontWeight.w600)),
                    )),
                Divider(
                  thickness: 1,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 4,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                      itemCount:
                          systemNotificationsList['Read notifications']!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              top: 16.0, left: 8, right: 8, bottom: 24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: CircleAvatar(
                                  radius: 15,
                                  backgroundColor: ArgonColors.error,
                                  child: Icon(Icons.chat_bubble,
                                      size: 16, color: ArgonColors.white),
                                ),
                              ),
                              Flexible(
                                flex: 5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          flex: 2,
                                          child: Text(
                                              systemNotificationsList[
                                                      'Read notifications']![
                                                  index]['title']!,
                                              style: TextStyle(
                                                  color: ArgonColors.muted,
                                                  fontWeight: FontWeight.w400)),
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.timelapse,
                                                size: 14.0,
                                                color: ArgonColors.muted),
                                            SizedBox(
                                              width: 3,
                                            ),
                                            Text(
                                                systemNotificationsList[
                                                        'Read notifications']![
                                                    index]['time']!,
                                                style: TextStyle(
                                                    color: ArgonColors.muted)),
                                          ],
                                        )
                                      ],
                                    ),
                                    Text(
                                        systemNotificationsList[
                                                'Read notifications']![index]
                                            ['description']!,
                                        style: TextStyle(
                                            color: ArgonColors.text,
                                            fontWeight: FontWeight.w600))
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      }),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
