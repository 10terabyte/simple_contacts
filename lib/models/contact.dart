import 'package:objectbox/objectbox.dart';
import 'address.dart';  // Import the Address entity

@Entity()
class Contact {
  @Id(assignable: true)
  int id;

  String firstName;
  String lastName;

  @Backlink('contact')
  final addresses = ToMany<Address>();

  List<String> phoneNumbers;


  Contact({
    this.id = 0,
    required this.firstName,
    required this.lastName,
    required this.phoneNumbers,
  });

}
