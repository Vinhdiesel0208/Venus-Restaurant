import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailTextController = TextEditingController();
  String? emailError;

  Future<void> sendResetLink() async {
    if (!_validateInput()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a valid email address')),
      );
      return;
    }

    // Call your service to send the reset link here
    try {
      // Assume the function to send reset link is sendResetLinkToEmail(email)
      // await authService.sendResetLinkToEmail(emailTextController.text);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Reset link sent! Please check your email')),
      );
    } catch (exception) {
      print('Reset link exception: $exception');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error sending reset link: $exception')),
      );
    }
  }

  bool _validateInput() {
    if (emailTextController.text.isEmpty ||
        !emailTextController.text.contains('@')) {
      setState(() {
        emailError = 'Please enter a valid email address';
      });
      return false;
    } else {
      setState(() {
        emailError = null;
      });
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 400,
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Forgot Password',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Enter your email address below and we\'ll send you a link to reset your password.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w100),
              ),
              SizedBox(height: 20),
              TextField(
                controller: emailTextController,
                decoration: InputDecoration(
                  hintText: 'Email',
                  errorText: emailError,
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: sendResetLink,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 45),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                child: Text('Send Reset Link'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
