import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:thebags_mobile/constants/theme.dart';
import 'package:thebags_mobile/widgets/drawer.dart';
import 'package:thebags_mobile/widgets/input.dart';
import 'package:thebags_mobile/widgets/navbar.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _checkboxValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Navbar(transparent: true, title: ''),
        extendBodyBehindAppBar: true,
        drawer: ArgonDrawer(currentPage: 'Register'),
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/imgs/register-bg.png'),
                      fit: BoxFit.cover)),
            ),
            SafeArea(
              child: ListView(children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 16, left: 24.0, right: 24.0, bottom: 32),
                  child: Card(
                      elevation: 5,
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Column(
                        children: [
                          Container(
                              height: MediaQuery.of(context).size.height * 0.15,
                              decoration: BoxDecoration(
                                  color: ArgonColors.white,
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 0.5,
                                          color: ArgonColors.muted))),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Center(
                                      child: Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text('Sign up with',
                                        style: TextStyle(
                                            color: ArgonColors.text,
                                            fontSize: 16.0)),
                                  )),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        SizedBox(
                                          // width: 0,
                                          height: 36,
                                          child: ElevatedButton(
                                              style: TextButton.styleFrom(
                                                  foregroundColor:
                                                      ArgonColors.white,
                                                  backgroundColor:
                                                      ArgonColors.primary,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4))),
                                              onPressed: () {},
                                              child: Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 10,
                                                      top: 10,
                                                      left: 14,
                                                      right: 14),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Icon(
                                                          FontAwesomeIcons
                                                              .google,
                                                          size: 13),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text('GOOGLE',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 13))
                                                    ],
                                                  ))),
                                        ),
                                        SizedBox(
                                          // width: 0,
                                          height: 36,
                                          child: ElevatedButton(
                                              style: TextButton.styleFrom(
                                                  foregroundColor:
                                                      ArgonColors.white,
                                                  backgroundColor:
                                                      ArgonColors.primary,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4))),
                                              onPressed: () {},
                                              child: Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 10,
                                                      top: 10,
                                                      left: 8,
                                                      right: 8),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Icon(
                                                          FontAwesomeIcons
                                                              .facebook,
                                                          size: 13),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text('FACEBOOK',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 13))
                                                    ],
                                                  ))),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Divider()
                                ],
                              )),
                          Container(
                              height: MediaQuery.of(context).size.height * 0.63,
                              color: Color.fromRGBO(244, 245, 247, 1),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 24.0, bottom: 24.0),
                                        child: Center(
                                          child: Text(
                                              'Or sign up with The Bags',
                                              style: TextStyle(
                                                  color: ArgonColors.text,
                                                  fontWeight: FontWeight.w200,
                                                  fontSize: 16)),
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Input(
                                              placeholder: 'Name',
                                              prefixIcon: Icon(Icons.school),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Input(
                                                placeholder: 'Email',
                                                prefixIcon: Icon(Icons.email)),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Input(
                                                placeholder: 'Password',
                                                prefixIcon: Icon(Icons.lock)),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 24.0),
                                            child: RichText(
                                                text: TextSpan(
                                                    text: 'password strength: ',
                                                    style: TextStyle(
                                                        color:
                                                            ArgonColors.muted),
                                                    children: [
                                                  TextSpan(
                                                      text: 'strong',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: ArgonColors
                                                              .success))
                                                ])),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, top: 0, bottom: 16),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Checkbox(
                                                activeColor:
                                                    ArgonColors.primary,
                                                onChanged: (value) {},
                                                value: _checkboxValue),
                                            Text('I agree with the',
                                                style: TextStyle(
                                                    color: ArgonColors.muted,
                                                    fontWeight:
                                                        FontWeight.w200)),
                                            GestureDetector(
                                                onTap: () {},
                                                child: Container(
                                                  margin:
                                                      EdgeInsets.only(left: 5),
                                                  child: Text('Privacy Policy',
                                                      style: TextStyle(
                                                          color: ArgonColors
                                                              .primary)),
                                                )),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 16),
                                        child: Center(
                                          child: TextButton(
                                            style: TextButton.styleFrom(
                                                foregroundColor:
                                                    ArgonColors.white,
                                                backgroundColor:
                                                    ArgonColors.info,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4))),
                                            onPressed: () {
                                              context.pushReplacement('/home');
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 6,
                                                      horizontal: 8),
                                              child: const Text('REGISTER',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 16.0)),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ))
                        ],
                      )),
                ),
              ]),
            )
          ],
        ));
  }
}
