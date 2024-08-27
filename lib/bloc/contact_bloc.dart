import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/contact.dart';
import '../repository/contact_repository.dart';
import 'contact_event.dart';
import 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final ContactRepository repository;
  List<Contact> _allContacts = [];
  ContactBloc(this.repository) : super(ContactState([])) {
    on<LoadContacts>((event, emit) {
      _allContacts = repository.getAllContacts();
      emit(ContactState(_allContacts));
    });

    on<AddContact>((event, emit) {
      repository.addContact(event.contact);
      add(LoadContacts());
    });

    on<UpdateContact>((event, emit) {
      repository.updateContact(event.contact);
      add(LoadContacts());
    });

    on<DeleteContact>((event, emit) {
      repository.deleteContact(event.id);
      add(LoadContacts());
    });
    on<SearchContacts>((event, emit) {
      final query = event.query.toLowerCase();
      final filteredContacts = _allContacts.where((contact) {
        return contact.firstName.toLowerCase().contains(query) ||
            contact.lastName.toLowerCase().contains(query);
      }).toList();
      emit(ContactState(filteredContacts));
    });
  }
}
