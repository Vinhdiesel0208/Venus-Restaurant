// lib/services/contact_service.dart

import '../apis/contact_api.dart';
import '../models/contact.dart';

class ContactService {
  final ContactApi _contactApi = ContactApi();

  Future<bool> createContact(Contact contact) async {
    try {
      await _contactApi.createContact(contact);
      return true;
    } catch (e) {
      // In a real app, you might want to handle this error more gracefully
      print('Error creating contact: $e');
      return false;
    }
  }
}
