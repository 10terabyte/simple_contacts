import "package:objectbox/objectbox.dart";
@Entity()
@Entity()
class Contact {
  @Id(assignable: true)
  int id;
  String firstName;
  String lastName;
  String phoneNumber;
  String streetAddress1;
  String streetAddress2;
  String city;
  String state;
  String zipCode;

  Contact({
    this.id = 0,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.streetAddress1,
    this.streetAddress2 = '',
    required this.city,
    required this.state,
    required this.zipCode,
  });
}
