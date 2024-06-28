import 'package:flutter/material.dart';
import '../models/contact.dart';

class ContactItem extends StatelessWidget {
  final Contact contact;

  ContactItem({required this.contact});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(contact.fullName),
      subtitle: Text(contact.message),
      leading: Icon(Icons.contact_phone),
      onTap: () {
        // Xử lý khi người dùng chọn một mục liên hệ
      },
    );
  }
}
