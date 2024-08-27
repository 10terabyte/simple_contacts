import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/contact_bloc.dart';
import '../bloc/contact_event.dart';
import '../models/address.dart';
import '../models/contact.dart';
import '../utils/url_launcher_util.dart';

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
            icon: Icon(Icons.edit),
            onPressed: () {
              context.go('/edit-contact/$contactId');
            },
          ),
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
        child: ListView(
          children: [
            _buildHeader(contact),
            SizedBox(height: 20),
            _buildPhoneNumbers(contact.phoneNumbers),
            _buildAddresses(contact.addresses),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(Contact contact) {
    return Row(
      children: [
        CircleAvatar(
          radius: 40,
          child: Text(contact.firstName[0]),
        ),
        SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${contact.firstName} ${contact.lastName}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            if (contact.phoneNumbers.isNotEmpty)
              Text(contact.phoneNumbers[0], style: TextStyle(fontSize: 16)),
          ],
        ),
      ],
    );
  }

  Widget _buildPhoneNumbers(List<String> phoneNumbers) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: phoneNumbers.map((phone) {
        return ListTile(
          leading: Icon(Icons.phone),
          title: Text(phone),
          trailing: Wrap(
            spacing: 12,
            children: [
              IconButton(
                icon: Icon(Icons.call),
                onPressed: () {
                  UrlLauncherUtil.handlePhoneAction('Call', phone);
                },
              ),
              IconButton(
                icon: Icon(Icons.message),
                onPressed: () {
                  UrlLauncherUtil.handlePhoneAction('Message', phone);
                },
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildAddresses(List<Address> addresses) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: addresses.map((address) {
        return ListTile(
          leading: Icon(Icons.location_on),
          title: Text(address.toString()),
          trailing: IconButton(
            icon: Icon(Icons.map),
            onPressed: () {
              UrlLauncherUtil.handleAddressAction(address.toString());
            },
          ),
        );
      }).toList(),
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
