import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/contact.dart';
import '../repository/contact_repository.dart';

class ContactEvent {}

class LoadContacts extends ContactEvent {}

class AddContact extends ContactEvent {
  final Contact contact;

  AddContact(this.contact);
}

class UpdateContact extends ContactEvent {
  final Contact contact;

  UpdateContact(this.contact);
}

class DeleteContact extends ContactEvent {
  final int id;

  DeleteContact(this.id);
}

class ContactState {
  final List<Contact> contacts;

  ContactState(this.contacts);
}

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final ContactRepository repository;

  ContactBloc(this.repository) : super(ContactState([])) {
    on<LoadContacts>((event, emit) {
      final contacts = repository.getAllContacts();
      emit(ContactState(contacts));
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
  }
}
