class BookingTable {
  final String? id;
  final String name;
  final String email;
  final String phone_number;
  final String date;
  final String start_time;
  final String end_time;
  final int person_number;
  int? tableId; // Remove final

  BookingTable({
    this.id,
    required this.name,
    required this.email,
    required this.phone_number,
    required this.date,
    required this.start_time,
    required this.end_time,
    required this.person_number,
    this.tableId,
  });

  factory BookingTable.fromJson(Map<String, dynamic> json) {
    return BookingTable(
      id: json['id'] as String?,
      name: json['name'] as String,
      email: json['email'] as String,
      phone_number: json['phone_number'] as String,
      date: json['date'] as String,
      start_time: json['start_time'] as String,
      end_time: json['end_time'] as String,
      person_number: json['person_number'] as int,
      tableId: json['tableId'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone_number': phone_number,
      'date': date,
      'start_time': start_time,
      'end_time': end_time,
      'person_number': person_number,
      'tableId': tableId,
    };
  }

  @override
  String toString() {
    return 'BookingTable{id: $id, name: $name, email: $email, phone_number: $phone_number, date: $date, start_time: $start_time, end_time: $end_time, person_number: $person_number, tableId: $tableId}';
  }
}
