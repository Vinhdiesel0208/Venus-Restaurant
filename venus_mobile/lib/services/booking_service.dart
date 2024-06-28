import 'package:http/http.dart' as http;
import 'package:thebags_mobile/apis/bookingtable_api.dart';
import 'package:thebags_mobile/models/booking_table.dart';
import 'package:thebags_mobile/models/restaurant_table.dart';

class BookingTableService {
  final BookingTableApi _bookingTableApi = BookingTableApi();

  Future<bool> createBookingTable(BookingTable bookingTable) async {
    try {
      print('Creating booking with data: ${bookingTable.toString()}');
      await _bookingTableApi.createBookingTable(bookingTable);
      return true;
    } catch (e) {
      print('Error creating booking table: $e');
      return false;
    }
  }

  Future<List<RestaurantTable>?> listTableByPerson({
    required int person_number,
    required String date,
    required String start_time,
    required String end_time,
  }) async {
    try {
      print(
          'Listing tables for person_number: $person_number, date: $date, start_time: $start_time, end_time: $end_time');
      List<RestaurantTable>? tables = await _bookingTableApi.listTableByPerson(
          person_number, date, start_time, end_time);
      return tables;
    } catch (e) {
      print('Error listing tables by person: $e');
      return null;
    }
  }
}
