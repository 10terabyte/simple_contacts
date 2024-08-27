import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/contact_bloc.dart';
import '../bloc/contact_event.dart';
import '../models/contact.dart';
import 'contact_form.dart';

class AddContactScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Contact'),
      ),
      body: ContactForm(
        onSave: (contact) {
          context.read<ContactBloc>().add(AddContact(contact));
          Navigator.pop(context);
        },
      ),
    );
  }
}
