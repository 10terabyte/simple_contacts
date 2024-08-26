import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/contact_bloc.dart';
import '../models/contact.dart';

class ContactDetailScreen extends StatelessWidget {
  final int contactId;

  ContactDetailScreen({required this.contactId});

  @override
  Widget build(BuildContext context) {
    final contactBloc = context.read<ContactBloc>();
    final contact = contactBloc.state.contacts.firstWhere((c) => c.id == contactId);

    return Scaffold(
      appBar: AppBar(title: Text('Edit Contact')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              initialValue: contact.firstName,
              decoration: InputDecoration(labelText: 'First Name'),
              // Update the contact's first name
            ),
            // Add more fields for lastName, phoneNumber, etc.
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Save the updated contact
              },
              child: Text('Save'),
            ),
            ElevatedButton(
              onPressed: () {
                // Delete the contact
              },
              child: Text('Delete'),
            ),
          ],
        ),
      ),
    );
  }
}
