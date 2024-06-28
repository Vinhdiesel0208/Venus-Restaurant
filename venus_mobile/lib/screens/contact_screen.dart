import 'package:flutter/material.dart';
import '../models/contact.dart';
import '../services/contact_service.dart';
import 'package:flutter/services.dart';

class ContactScreen extends StatefulWidget {
  static const String routeName = '/contact';

  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final ContactService _contactService = ContactService();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  bool _isSubmitting = false;

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSubmitting = true;
      });

      Contact newContact = Contact(
        fullName: _nameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        message: _messageController.text,
        createdTime: DateTime.now(),
      );

      bool isSuccess = await _contactService.createContact(newContact);
      if (isSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Contact submitted successfully')));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Failed to submit contact')));
      }

      setState(() {
        _isSubmitting = false;
      });
    }
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
      return 'Phone number must be 10 digits';
    }
    return null;
  }

  String? validateMessage(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your message';
    }

    // Danh sách các từ ngữ nhạy cảm cần kiểm tra
    List<String> sensitiveWords = [
      'bad',
      'terrible',
      'awful',
      'horrible',
      'disgusting',
      'sex',
      'crazy',
      'stupid',
      'qua do',
      'fuck'
    ];

    // Kiểm tra xem tin nhắn có chứa từ ngữ nhạy cảm không
    for (var word in sensitiveWords) {
      if (value.toLowerCase().contains(word)) {
        return 'Your message contains sensitive words. Please revise it.';
      }
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: Text(
                  'Welcome to Venus Restaurant!',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 20.0), // Add spacing between header and inputs
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Full Name',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 10.0), // Add spacing between inputs
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                  validator: validateEmail,
                ),
              ),
              SizedBox(height: 10.0), // Add spacing between inputs
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    labelText: 'Phone',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.phone),
                  ),
                  keyboardType: TextInputType.phone,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: validatePhone,
                ),
              ),
              SizedBox(height: 10.0), // Add spacing between inputs
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: TextFormField(
                  controller: _messageController,
                  decoration: InputDecoration(
                    labelText: 'Message',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.message),
                  ),
                  maxLines: 3,
                  validator: validateMessage,
                ),
              ),
              SizedBox(height: 20.0), // Add spacing between inputs and button
              Container(
                padding: EdgeInsets.all(20.0),
                child: ElevatedButton(
                  onPressed: _submitForm,
                  child: Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
