import 'package:logger/logger.dart';
import 'package:objectbox/objectbox.dart';
import 'package:simple_contacts/utils/json_loader.dart';
import '../models/contact.dart';
import '../objectbox.g.dart'; // Created after running build_runner

class ContactRepository {
  late final Store _store;
  late final Box<Contact> _contactBox;
  final Logger _logger = Logger();
  ContactRepository._create(this._store) {
    _contactBox = _store.box<Contact>();
  }

  static Future<ContactRepository> create() async {
    final store = await openStore();
    final repository = ContactRepository._create(store);
    await repository._initializeContacts();
    return repository;
  }
  Future<void> _initializeContacts() async {
    if (_contactBox.isEmpty()) {
      final contacts = await loadContactsFromJson();
      _contactBox.putMany(contacts);
    }
  }
  void addContact(Contact contact) {
    _contactBox.put(contact);
    _logger.i('Contact added: ${contact.firstName} ${contact.lastName}');
  }

  void updateContact(Contact contact) {
    _contactBox.put(contact);
    _logger.i('Contact updated: ${contact.firstName} ${contact.lastName}');
  }

  void deleteContact(int id) {
    _contactBox.remove(id);
    _logger.i('Contact deleted with ID: $id');
  }

  List<Contact> getAllContacts() {
    return _contactBox.getAll();
  }
}
