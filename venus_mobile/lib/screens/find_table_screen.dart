import 'package:flutter/material.dart';
import 'package:thebags_mobile/helpers/auth_helper.dart';
import 'package:thebags_mobile/models/booking_table.dart';
import 'package:thebags_mobile/models/restaurant_table.dart';
import 'package:thebags_mobile/services/booking_service.dart';
import 'package:thebags_mobile/screens/payment_screen.dart';

class FindTableScreen extends StatefulWidget {
  final BookingTable bookingTable;
  final List<RestaurantTable> tables;

  FindTableScreen({
    required this.bookingTable,
    required this.tables,
  });

  @override
  _FindTableScreenState createState() => _FindTableScreenState();
}

class _FindTableScreenState extends State<FindTableScreen> {
  int? selectedTableId;
  final BookingTableService bookingTableService = BookingTableService();

  void _selectTable(int tableId) {
    setState(() {
      selectedTableId = tableId;
    });
  }

  void _proceedToPayment() async {
    if (selectedTableId != null) {
      widget.bookingTable.tableId = selectedTableId;

      // Tạo và lưu token ngẫu nhiên
      await AuthHelper.createAndSaveToken();

      // Sau đó, sử dụng token vừa tạo để thực hiện yêu cầu tạo đặt bàn
      bool bookingCreated =
          await bookingTableService.createBookingTable(widget.bookingTable);

      if (bookingCreated) {
        // Điều hướng đến màn hình thanh toán nếu tạo đặt bàn thành công
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PaymentScreen(
              tableId: selectedTableId!,
              totalAmount:
                  2, // Assuming you have a totalAmount field in bookingTable
            ),
          ),
        );
      } else {
        // Hiển thị SnackBar khi tạo đặt bàn thất bại
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to create booking. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Find Table'),
        backgroundColor: Colors.teal,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    'Booking Details',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  _buildDetailText('Name', widget.bookingTable.name),
                  _buildDetailText('Email', widget.bookingTable.email),
                  _buildDetailText(
                      'Phone Number', widget.bookingTable.phone_number),
                  _buildDetailText('Date', widget.bookingTable.date),
                  _buildDetailText(
                      'Start Time', widget.bookingTable.start_time),
                  _buildDetailText('End Time', widget.bookingTable.end_time),
                  _buildDetailText('Number of People',
                      widget.bookingTable.person_number.toString()),
                  SizedBox(height: 24.0),
                  Text(
                    'Available Tables (${widget.tables.length})',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: widget.tables.length,
                    itemBuilder: (context, index) {
                      final table = widget.tables[index];
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 4.0,
                        child: ListTile(
                          title: Text('Table ${table.tableNumber}'),
                          selected: selectedTableId == table.id,
                          selectedTileColor: Colors.teal.withOpacity(0.1),
                          onTap: () {
                            _selectTable(table.id);
                          },
                        ),
                      );
                    },
                  ),
                  SizedBox(
                      height:
                          80.0), // Add some space to prevent content hiding behind button
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 16.0,
            left: 16.0,
            right: 16.0,
            child: ElevatedButton(
              onPressed: selectedTableId != null ? _proceedToPayment : null,
              child: Text('Proceed to Confirm Booking'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: EdgeInsets.symmetric(vertical: 16.0),
                textStyle: TextStyle(fontSize: 18.0, color: Colors.white),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailText(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: RichText(
        text: TextSpan(
          text: '$label: ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 16,
          ),
          children: <TextSpan>[
            TextSpan(
              text: value,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.black54,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
