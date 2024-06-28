import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thebags_mobile/models/booking_table.dart';
import 'package:thebags_mobile/services/booking_service.dart';
import 'find_table_screen.dart';
import 'package:intl/intl.dart';

class BookingTableScreen extends StatefulWidget {
  @override
  _BookingTableScreenState createState() => _BookingTableScreenState();
}

class _BookingTableScreenState extends State<BookingTableScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  String? _selectedStartTime;
  String? _selectedEndTime;
  List<String> _timeOptions = [
    '09:00',
    '10:00',
    '11:00',
    '12:00',
    '13:00',
    '14:00',
    '15:00',
    '16:00',
    '17:00',
    '18:00',
    '19:00',
    '20:00',
    '21:00'
  ];
  int? _selectedPeopleNumber;
  List<int> _peopleNumberOptions = [2, 3, 4, 5, 6, 8];

  late BookingTableService _bookingTableService;

  @override
  void initState() {
    super.initState();
    _bookingTableService = BookingTableService();
    _loadSavedData();
  }

  Future<void> _loadSavedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _nameController.text = prefs.getString('name') ?? '';
      _emailController.text = prefs.getString('email') ?? '';
      _phoneController.text = prefs.getString('phone_number') ?? '';
      _dateController.text = prefs.getString('date') ?? '';
      _selectedStartTime = prefs.getString('start_time');
      _selectedEndTime = prefs.getString('end_time');
      _selectedPeopleNumber = prefs.getInt('person_number');
    });
  }

  Future<void> _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', _nameController.text);
    await prefs.setString('email', _emailController.text);
    await prefs.setString('phone_number', _phoneController.text);
    await prefs.setString('date', _dateController.text);
    await prefs.setString('start_time', _selectedStartTime ?? '');
    await prefs.setString('end_time', _selectedEndTime ?? '');
    await prefs.setInt('person_number', _selectedPeopleNumber ?? 0);
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _saveData().then((_) {
        final bookingTable = BookingTable(
          name: _nameController.text,
          email: _emailController.text,
          phone_number: _phoneController.text,
          date: _dateController.text,
          start_time: _selectedStartTime ?? '',
          end_time: _selectedEndTime ?? '',
          person_number: _selectedPeopleNumber ?? 0,
        );

        _bookingTableService
            .listTableByPerson(
          person_number: bookingTable.person_number,
          date: bookingTable.date,
          start_time: bookingTable.start_time,
          end_time: bookingTable.end_time,
        )
            .then((tables) {
          if (tables != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FindTableScreen(
                  bookingTable: bookingTable,
                  tables: tables,
                ),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text('No tables found for the specified criteria.')),
            );
          }
        }).catchError((error) {
          print('Error fetching tables: $error');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error fetching tables: $error')),
          );
        });
      }).catchError((error) {
        print('Error saving data: $error');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving data: $error')),
        );
      });
    }
  }

  Future<void> _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2200),
    );
    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      _dateController.text = formattedDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Table'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildTextField(
                    _nameController, 'Name', 'Please enter your name'),
                SizedBox(height: 16.0),
                _buildTextField(
                    _emailController, 'Email', 'Please enter your email',
                    email: true),
                SizedBox(height: 16.0),
                TextField(
                  controller: _dateController,
                  decoration: InputDecoration(
                    labelText: 'Date',
                    prefixIcon: Icon(Icons.calendar_today),
                    border: OutlineInputBorder(),
                  ),
                  readOnly: true,
                  onTap: _selectDate,
                ),
                SizedBox(height: 16.0),
                _buildTextField(_phoneController, 'Telephone Number',
                    'Please enter your phone number',
                    phone: true),
                SizedBox(height: 16.0),
                _buildDropdownField<String>(
                  value: _selectedStartTime,
                  items: _timeOptions,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedStartTime = newValue;
                    });
                  },
                  labelText: 'Start Time',
                ),
                SizedBox(height: 16.0),
                _buildDropdownField<String>(
                  value: _selectedEndTime,
                  items: _timeOptions,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedEndTime = newValue;
                    });
                  },
                  labelText: 'End Time',
                ),
                SizedBox(height: 16.0),
                _buildDropdownField<int>(
                  value: _selectedPeopleNumber,
                  items: _peopleNumberOptions,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedPeopleNumber = newValue;
                    });
                  },
                  labelText: 'Person Number',
                ),
                SizedBox(height: 24.0),
                ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    textStyle: TextStyle(fontSize: 18.0, color: Colors.white),
                  ),
                  child: Text('Find table'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String labelText, String errorText,
      {bool email = false, bool phone = false}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return errorText;
        }
        if (email &&
            !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
          return 'Please enter a valid email address';
        }
        if (phone && !RegExp(r'^0[0-9]{9}$').hasMatch(value)) {
          return 'Please enter a valid 10-digit phone number starting with 0';
        }
        return null;
      },
    );
  }

  Widget _buildDropdownField<T>(
      {T? value,
      List<T>? items,
      ValueChanged<T?>? onChanged,
      String? labelText}) {
    return DropdownButtonFormField<T>(
      value: value,
      items: items?.map((T value) {
        return DropdownMenuItem<T>(
          value: value,
          child: Text(value.toString()),
        );
      }).toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null) {
          return 'Please select $labelText';
        }
        return null;
      },
    );
  }
}
