import 'package:flutter/material.dart';
import '../../services/customer_service.dart';
import 'change_password_screen.dart'; // Import màn hình ChangePasswordScreen

class CustomerDetailScreen extends StatefulWidget {
  final int customerId;

  const CustomerDetailScreen({Key? key, required this.customerId})
      : super(key: key);

  @override
  _CustomerDetailScreenState createState() => _CustomerDetailScreenState();
}

class _CustomerDetailScreenState extends State<CustomerDetailScreen> {
  String fullName = '';
  String email = '';
  String phoneNumber = '';
  String role = '';
  String errorMessage = '';
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchUserDetails();
  }

  Future<void> _fetchUserDetails() async {
    try {
      final customerService = CustomerService();
      final userDetails = await customerService.getUserDetails();
      setState(() {
        fullName = userDetails['fullName'] ?? '';
        email = userDetails['email'] ?? '';
        phoneNumber = userDetails['phoneNumber'] ?? '';
        role = userDetails['role'] ?? '';
        fullNameController.text = fullName;
        phoneNumberController.text = phoneNumber;
      });
    } catch (e) {
      print('Error fetching user details: $e');
      setState(() {
        errorMessage = 'Error fetching user details: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Detail'),
        actions: [
          IconButton(
            onPressed: () {
              // Chuyển sang màn hình ChangePasswordScreen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChangePasswordScreen(),
                ),
              );
            },
            icon: Icon(Icons.lock), // Icon "Change Password"
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (errorMessage.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        errorMessage,
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  _buildEditableRow('Email', null),
                  _buildEditableRow('Full Name', fullNameController),
                  _buildEditableRow('Phone Number', phoneNumberController),
                  SizedBox(
                      height:
                          16), // Add space between editable fields and buttons
                  Row(
                    // Row for Save and Change Password buttons
                    mainAxisAlignment: MainAxisAlignment
                        .spaceBetween, // Align buttons horizontally
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Implement save functionality
                        },
                        child: Text('Save'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Chuyển sang màn hình ChangePasswordScreen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChangePasswordScreen(),
                            ),
                          );
                        },
                        child: Text('Change Password'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEditableRow(String label, TextEditingController? controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$label:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: controller != null
                ? TextFormField(
                    controller: controller,
                  )
                : Text(
                    label == 'Email' ? email : phoneNumber,
                    style: TextStyle(fontSize: 16),
                  ),
          ),
        ],
      ),
    );
  }
}
