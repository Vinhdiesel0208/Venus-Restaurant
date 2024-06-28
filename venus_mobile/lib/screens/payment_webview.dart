import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:go_router/go_router.dart';
import '../apis/cartline_api.dart';
import 'payment_success_screen.dart';
import 'payment_failure_screen.dart';

class PaymentWebView extends StatefulWidget {
  final String url;
  final int tableId;
  final double amount;
  final int points;
  final String email;
  final String fullName;
  final VoidCallback onSuccess;

  PaymentWebView({
    required this.url,
    required this.tableId,
    required this.amount,
    required this.points,
    required this.email,
    required this.fullName,
    required this.onSuccess,
  });

  @override
  _PaymentWebViewState createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {
  late final WebViewController _controller;
  final CartLineApi _cartLineApi = CartLineApi();

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..loadRequest(Uri.parse(widget.url))
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onPageFinished: (String url) async {
          if (url.contains('/payment/paypal/success') ||
              url.contains('/payment/vnpay-return')) {
            bool success = await _cartLineApi.checkoutTable(widget.tableId);
            if (success) {
              widget.onSuccess();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => PaymentSuccessScreen(
                    amount: widget.amount,
                    points: widget.points,
                    email: widget.email,
                    fullName: widget.fullName,
                  ),
                ),
              );
            } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => PaymentFailureScreen()),
              );
            }
          } else if (url.contains('/payment/paypal/cancel') ||
              url.contains('failure-url')) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => PaymentFailureScreen()),
            );
          }
        },
      ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
