import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/contact.dart';

Future<List<Contact>> loadContactsFromJson() async {
  final String response = await rootBundle.loadString('assets/contacts.json');
  final List<dynamic> data = json.decode(response);
  return data.map((json) => Contact(
    firstName: json['firstName'],
    lastName: json['lastName'],
    phoneNumber: json['phoneNumber'],
    streetAddress1: json['streetAddress1'],
    streetAddress2: json['streetAddress2'] ?? '',
    city: json['city'],
    state: json['state'],
    zipCode: json['zipCode'],
  )).toList();
}
