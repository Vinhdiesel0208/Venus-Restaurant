import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thebags_mobile/constants/theme.dart';
import 'package:thebags_mobile/services/auth_service.dart';
import 'package:thebags_mobile/widgets/input.dart';
import 'package:thebags_mobile/widgets/navbar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final authService = AuthService();
  String? emailError;
  String? passwordError;

  @override
  void initState() {
    super.initState();
    _loadSavedCredentials();
  }

  Future<void> _loadSavedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString('savedEmail');
    final savedPassword = prefs.getString('savedPassword');
    if (savedEmail != null) {
      setState(() {
        emailTextController.text = savedEmail;
      });
    }
    if (savedPassword != null) {
      setState(() {
        passwordTextController.text = savedPassword;
      });
    }
  }

  Future<void> signWithEmail() async {
    if (!_validateInputs()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login Failed, please try again'),
          backgroundColor: Colors.redAccent, // Set the background color to red
        ),
      );
      return; // Stop further execution if validation fails
    }

    try {
      String role = await authService.loginWebAccount(
          emailTextController.text, passwordTextController.text);
      if (role.isNotEmpty) {
        if (role == 'CHEF') {
          GoRouter.of(context).go('/chef');
        } else {
          GoRouter.of(context).go('/home');
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login failed, please try again'),
            backgroundColor:
                Colors.redAccent, // Red background for error message
          ),
        );
      }
    } catch (exception) {
      print('Login exception: $exception');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Wrong Email or Password, please try again'),
          backgroundColor: Colors.redAccent, // Red background for exceptions
        ),
      );
    }
  }

  bool _validateInputs() {
    bool isValid = true;
    if (emailTextController.text.isEmpty ||
        !emailTextController.text.contains('@')) {
      emailError = 'Please enter a valid email';
      isValid = false;
    } else {
      emailError = null;
    }

    if (passwordTextController.text.isEmpty) {
      passwordError = 'Please enter your password';
      isValid = false;
    } else {
      passwordError = null;
    }

    setState(() {}); // Update the UI with errors
    return isValid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Navbar(transparent: true, title: 'Login', backButton: true),
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/imgs/register-bg.png'),
                        fit: BoxFit.cover))),
            SafeArea(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        Text('Welcome to Venus Restaurant',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        SizedBox(height: 10),
                        Image.asset('assets/imgs/venus-logo.png', height: 150),
                        Card(
                          elevation: 5,
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Input(
                                  controller: emailTextController,
                                  placeholder: 'Email',
                                  prefixIcon: Icon(Icons.email),
                                  errorText: emailError,
                                ),
                                Input(
                                  controller: passwordTextController,
                                  placeholder: 'Password',
                                  prefixIcon: Icon(Icons.lock),
                                  obscureText: true,
                                  errorText: passwordError,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 16),
                                  child: Center(
                                    child: ElevatedButton(
                                      onPressed: signWithEmail,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12, horizontal: 20),
                                        child: Text('SIGN IN',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16.0)),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
