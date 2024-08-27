import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/contact_bloc.dart';
import '../bloc/contact_event.dart';
import '../models/contact.dart';
import 'contact_form.dart';

class EditContactScreen extends StatelessWidget {
  final int contactId;

  EditContactScreen({required this.contactId});

  @override
  Widget build(BuildContext context) {
    final contactBloc = context.read<ContactBloc>();
    final contact = contactBloc.state.contacts.firstWhere((c) => c.id == contactId);

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Contact'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              _showDeleteConfirmationDialog(context, contact);
            },
          ),
        ],
      ),
      body: ContactForm(
        contact: contact,
        onSave: (updatedContact) {
          context.read<ContactBloc>().add(UpdateContact(updatedContact));
          Navigator.pop(context);
        },
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, Contact contact) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Contact'),
        content: Text('Are you sure you want to delete this contact?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<ContactBloc>().add(DeleteContact(contact.id));
              Navigator.of(context).pop(); // Close the dialog
              Navigator.of(context).pop(); // Go back to the previous screen
            },
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }
}
