import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/contact.dart';
import '../models/address.dart';

Future<List<Contact>> loadContactsFromJson() async {
  final String response = await rootBundle.loadString('assets/contacts.json');
  final List<dynamic> data = json.decode(response);

  return data.map((json) {
    Contact contact = Contact(
      firstName: json['firstName'],
      lastName: json['lastName'],
      phoneNumbers: List<String>.from(json['phoneNumbers']),
    );

    List<Address> addresses = (json['addresses'] as List).map((addressJson) {
      return Address(
        streetAddress1: addressJson['streetAddress1'],
        streetAddress2: addressJson['streetAddress2'] ?? '',
        city: addressJson['city'],
        state: addressJson['state'],
        zipCode: addressJson['zipCode'],
      );
    }).toList();

    // Add addresses to contact
    contact.addresses.addAll(addresses);

    return contact;
  }).toList();
}
