import 'package:flutter/material.dart';
import '../../services/customer_service.dart'; // Thay đổi import tùy theo cấu trúc của project

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  String _errorMessage = '';

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _currentPasswordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Current Password'),
            ),
            TextField(
              controller: _newPasswordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'New Password'),
            ),
            if (_errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  _errorMessage,
                  style: TextStyle(color: Colors.red),
                ),
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _changePassword();
              },
              child: Text('Change Password'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _changePassword() async {
    final String currentPassword = _currentPasswordController.text;
    final String newPassword = _newPasswordController.text;

    // Validate new password
    if (newPassword.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter new password';
      });
      return;
    }

    try {
      await CustomerService().changePassword(currentPassword, newPassword);
      // Password changed successfully, clear error message
      setState(() {
        _errorMessage = '';
      });
      // Show success snackbar or navigate back
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Password changed successfully'),
          duration: Duration(seconds: 2),
        ),
      );
      // Optionally, navigate back to previous screen after a delay
      Future.delayed(Duration(seconds: 2), () {
        Navigator.of(context).pop();
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to change password: $e';
      });
    }
  }
}
