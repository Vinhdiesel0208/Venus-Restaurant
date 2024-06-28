import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:thebags_mobile/constants/theme.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: <Widget>[
      Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/imgs/onboard-background.png'),
                  fit: BoxFit.cover))),
      Padding(
        padding:
            const EdgeInsets.only(top: 71, left: 32, right: 32, bottom: 16),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(children: <Widget>[
                Image.asset(
                  'assets/imgs/logo-thebags.png',
                  scale: 1.5,
                ),
                Container(
                    padding: EdgeInsets.all(2.0),
                    // margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        color: Color.fromRGBO(17, 205, 239, 1)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 0, bottom: 0, left: 4, right: 4),
                      child: Text('SHOP',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          )),
                    ))
              ]),
              Image.asset('assets/imgs/logo-hive.png', scale: 1),
              Text(
                  'Take advantage of all the featured products. Easy to choice your style.',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400)),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    style: TextButton.styleFrom(
                        foregroundColor: ArgonColors.white,
                        backgroundColor: ArgonColors.info,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4))),
                    onPressed: () {
                      context.pushReplacement('/signin');
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 8),
                      child: const Text('GET STARTED',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16.0)),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      )
    ]));
  }
}
