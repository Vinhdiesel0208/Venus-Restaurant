import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thebags_mobile/models/cart_line.dart';
import 'package:thebags_mobile/models/customer_vinh.dart';
import '../apis/payment_api.dart';
import '../apis/cartline_api.dart';
import '../apis/customer_api.dart';
import 'payment_webview.dart';
import 'payment_success_screen.dart'; // Import PaymentSuccessScreen
import 'package:fluttertoast/fluttertoast.dart';
import 'receipt_detail_screen.dart';

class PaymentScreen extends StatefulWidget {
  final int tableId;
  final double totalAmount;

  PaymentScreen({required this.tableId, required this.totalAmount});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final PaymentApi _paymentApi = PaymentApi();
  final CartLineApi _cartLineApi = CartLineApi();
  final CustomerApi _customerApi = CustomerApi();

  final TextEditingController _emailController = TextEditingController();
  Customer? _customer;
  bool _isMember = false;
  bool _usePoints = false;
  double _finalAmount = 0.0;
  double _discountAmount = 0.0;

  @override
  void initState() {
    super.initState();
    _fetchCartLinesForTable();
  }

  void _fetchCartLinesForTable() async {
    List<CartLine> cartLines =
        await _cartLineApi.fetchCartLinesForTable(widget.tableId);
    double subtotal =
        cartLines.fold(0, (sum, item) => sum + item.price * item.quantity);
    double tax = subtotal * 0.10;
    double total = subtotal + tax;
    setState(() {
      _finalAmount = total;
    });
  }

  void _handlePayment(BuildContext context, String method) async {
    try {
      String url;
      if (method == 'Cash') {
        if (_isMember) {
          if (_usePoints) {
            await _updateCustomerPoints();
          } else {
            await _updatePointsWithoutRedeeming();
          }
        }
        bool success = await _cartLineApi.checkoutTable(widget.tableId);
        if (success) {
          _showSuccessToast(context);
          context.go('/payment-success', extra: {
            'amount': _finalAmount,
            'points': _isMember ? _customer!.points : 0,
            'email': _isMember ? _customer!.email : '',
            'fullName': _isMember ? _customer!.fullName : '',
          });
        } else {
          _showFailureToast(context);
        }
      } else if (method == 'VNPay' || method == 'PayPal') {
        url = method == 'VNPay'
            ? await _paymentApi.getVNPayUrl(
                _finalAmount, 'Payment for Table ${widget.tableId}')
            : await _paymentApi.getPayPalUrl(
                _finalAmount, 'Payment for Table ${widget.tableId}');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PaymentWebView(
              url: url,
              tableId: widget.tableId,
              amount: _finalAmount,
              points: _isMember ? _customer!.points : 0,
              email: _isMember ? _customer!.email : '',
              fullName: _isMember ? _customer!.fullName : '',
              onSuccess: () async {
                if (_isMember) {
                  if (_usePoints) {
                    await _updateCustomerPoints();
                  } else {
                    await _updatePointsWithoutRedeeming();
                  }
                }
                bool success = await _cartLineApi.checkoutTable(widget.tableId);
                if (success) {
                  _showSuccessToast(context);
                  context.go('/payment-success', extra: {
                    'amount': _finalAmount,
                    'points': _isMember ? _customer!.points : 0,
                    'email': _isMember ? _customer!.email : '',
                    'fullName': _isMember ? _customer!.fullName : '',
                  });
                } else {
                  _showFailureToast(context);
                }
              },
            ),
          ),
        );
      } else {
        throw Exception('Unknown payment method');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Payment failed: $e'),
      ));
    }
  }

  Future<void> _updateCustomerPoints() async {
    if (_isMember) {
      try {
        if (_usePoints) {
          await _customerApi.redeemPoints(
              _emailController.text,
              widget.totalAmount,
              widget.tableId.toString()); // Ensure tableId is passed
        } else {
          await _customerApi.updatePoints(
              _emailController.text,
              widget.totalAmount,
              widget.tableId.toString()); // Ensure tableId is passed
        }
      } catch (e) {
        Fluttertoast.showToast(
          msg: "Failed to update points: $e",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
      }
    }
  }

  Future<void> _updatePointsWithoutRedeeming() async {
    if (_isMember && !_usePoints) {
      await _customerApi.updatePoints(_emailController.text, widget.totalAmount,
          widget.tableId.toString()); // Ensure tableId is passed
    }
  }

  void _showSuccessToast(BuildContext context) {
    Fluttertoast.showToast(
      msg: "Payment successful!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
    );
  }

  void _showFailureToast(BuildContext context) {
    Fluttertoast.showToast(
      msg: "Payment failed!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
    );
  }

  void _fetchCustomer() async {
    try {
      final customer =
          await _customerApi.getCustomerByEmail(_emailController.text);
      setState(() {
        _customer = customer;
        _discountAmount = _customer!.points / 10.0;
        if (_usePoints) {
          _finalAmount = widget.totalAmount - _discountAmount;
        } else {
          _finalAmount = widget.totalAmount;
        }
        if (_finalAmount < 0) _finalAmount = 0;
      });
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Customer not found or Invalid email $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
  }

  void _toggleUsePoints(bool value) {
    setState(() {
      _usePoints = value;
      if (_customer != null && _usePoints) {
        _finalAmount = widget.totalAmount - _discountAmount;
      } else {
        _finalAmount = widget.totalAmount;
      }
      if (_finalAmount < 0) _finalAmount = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment for Table ${widget.tableId}'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/cart/${widget.tableId}');
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SwitchListTile(
                  title: Text('Already a member?'),
                  value: _isMember,
                  onChanged: (bool value) {
                    setState(() {
                      _isMember = value;
                      if (!_isMember) {
                        _emailController.clear();
                        _customer = null;
                        _discountAmount = 0.0;
                        _finalAmount = widget.totalAmount;
                        _usePoints = false;
                      }
                    });
                  },
                ),
                if (_isMember)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: _fetchCustomer,
                          child: Text('Search Customer'),
                        ),
                        if (_customer != null) ...[
                          SizedBox(height: 10),
                          Text('Customer: ${_customer!.fullName}'),
                          Text('Points: ${_customer!.points}'),
                          Text(
                              'Discount: \$${_discountAmount.toStringAsFixed(2)}'),
                          SwitchListTile(
                            title: Text('Use points for discount'),
                            value: _usePoints,
                            onChanged: _toggleUsePoints,
                          ),
                        ],
                      ],
                    ),
                  ),
                SizedBox(height: 20),
                Text(
                  'Total Amount: \$${widget.totalAmount.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Text(
                  'Final Amount: \$${_finalAmount.toStringAsFixed(2)}',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
                SizedBox(height: 30),
                _buildPaymentButton(context, 'Cash', 'assets/imgs/cash.png'),
                SizedBox(height: 20),
                _buildPaymentButton(context, 'VNPay', 'assets/imgs/vnpay.png'),
                SizedBox(height: 20),
                _buildPaymentButton(
                    context, 'PayPal', 'assets/imgs/paypal.png'),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReceiptDetailScreen(
                          tableId: widget.tableId,
                          customer: _customer,
                          discountAmount: _usePoints ? _discountAmount : 0.0,
                          finalAmount: _finalAmount,
                        ),
                      ),
                    );
                  },
                  child: Text('View Receipt Details'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    backgroundColor: Colors.white,
                    textStyle: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentButton(
      BuildContext context, String method, String assetPath) {
    return ElevatedButton.icon(
      onPressed: () => _handlePayment(context, method),
      icon: Image.asset(assetPath, height: 24, width: 24),
      label: Text('Pay with $method'),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        textStyle: TextStyle(fontSize: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        side: BorderSide(color: Colors.black),
        shadowColor: Colors.grey.withOpacity(0.5),
        elevation: 5,
      ),
    );
  }

  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text('Menu',
                style: TextStyle(color: Colors.white, fontSize: 24)),
          ),
          ListTile(
            leading: Icon(Icons.table_chart),
            title: Text('Tables'),
            onTap: () {
              Navigator.pop(context);
              context.go('/tables');
            },
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.pop(context);
              context.go('/home');
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.clear();
              context.go('/signin');
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
