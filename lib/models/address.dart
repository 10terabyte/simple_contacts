import 'package:objectbox/objectbox.dart';

import 'contact.dart';

@Entity()
class Address {
  @Id(assignable: true)
  int id;

  String streetAddress1;
  String streetAddress2;
  String city;
  String state;
  String zipCode;
  final contact = ToOne<Contact>();
  Address({
    this.id = 0,
    required this.streetAddress1,
    required this.streetAddress2,
    required this.city,
    required this.state,
    required this.zipCode,
  });

  @override
  String toString() {
    return '$streetAddress1, $streetAddress2, $city, $state, $zipCode';
  }
}
