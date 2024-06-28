import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PaymentFailureScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Failure'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error, color: Colors.red, size: 100),
            SizedBox(height: 20),
            Text('Payment Failed!', style: TextStyle(fontSize: 24)),
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
