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
      appBar: AppBar(
        title: Text('${contact.firstName} ${contact.lastName}'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              _showDeleteConfirmationDialog(context, contact);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Phone: ${contact.phoneNumber}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Address: ${contact.streetAddress1}', style: TextStyle(fontSize: 18)),
            if (contact.streetAddress2.isNotEmpty)
              Text('Address Line 2: ${contact.streetAddress2}', style: TextStyle(fontSize: 18)),
            Text('City: ${contact.city}', style: TextStyle(fontSize: 18)),
            Text('State: ${contact.state}', style: TextStyle(fontSize: 18)),
            Text('Zip Code: ${contact.zipCode}', style: TextStyle(fontSize: 18)),
          ],
        ),
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
