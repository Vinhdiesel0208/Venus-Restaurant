import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PaymentSuccessScreen extends StatelessWidget {
  final double amount;
  final int points;
  final String email;
  final String fullName;

  PaymentSuccessScreen({
    required this.amount,
    required this.points,
    required this.email,
    required this.fullName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Success'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 100),
            SizedBox(height: 20),
            Text('Payment Successful!', style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            Text('Amount Paid: \$${amount.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            if (email.isNotEmpty)
              Column(
                children: [
                  Text('Customer Name: $fullName',
                      style: TextStyle(fontSize: 18)),
                  Text('Please check your invoice by: $email',
                      style: TextStyle(fontSize: 18)),
                ],
              ),
            SizedBox(height: 20),
            Text('Thank you for your purchase!',
                style: TextStyle(fontSize: 18)),
            Text('See you again!', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.go('/tables');
              },
              child: Text('Return to Tables'),
            ),
          ],
        ),
      ),
    );
  }
}
