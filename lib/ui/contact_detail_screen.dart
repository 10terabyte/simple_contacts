import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../bloc/contact_bloc.dart';
import '../models/contact.dart';
import 'dart:io' show Platform;

class ContactDetailScreen extends StatelessWidget {
  final int contactId;

  const ContactDetailScreen({super.key, required this.contactId});

  @override
  Widget build(BuildContext context) {
    final contactBloc = context.read<ContactBloc>();
    final contact = contactBloc.state.contacts.firstWhere((c) => c.id == contactId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              context.go('/edit-contact/$contactId');
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
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
            Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  child: Text(contact.firstName[0]),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${contact.firstName} ${contact.lastName}',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text(contact.phoneNumber, style: TextStyle(fontSize: 16)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.phone),
              title: const Text('Call'),
              onTap: () async {
                final phoneNumberUri = Uri(scheme: 'tel', path: contact.phoneNumber);
                if (!await launchUrl(phoneNumberUri, mode: LaunchMode.externalApplication)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Could not launch the phone application')),
                  );
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.message),
              title: const Text('Message'),
              onTap: () async{
                final phoneNumberUri = Uri(scheme: 'sms', path: contact.phoneNumber);
                if (!await launchUrl(phoneNumberUri, mode: LaunchMode.externalApplication)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Could not launch the message application')),
                  );
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.email),
              title: const Text('Email'),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Coming Soon!!!')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.location_on),
              title: const Text('Address'),
              subtitle: Text('${contact.streetAddress1}, ${contact.city}, ${contact.state}, ${contact.zipCode}'),
              onTap: () async{
                final queryString = '${contact.streetAddress1}, ${contact.city}, ${contact.state}, ${contact.zipCode}';
                final googleMapsUrl = Uri(scheme: 'https', host: 'www.google.com', path: 'maps/search/?api=1&query=$queryString');
                final appleMapsUrl = Uri(scheme: 'https', host: 'maps.apple.com', path: '?q=$queryString');

                if(Platform.isAndroid){
                  print(googleMapsUrl);
                  if (!await launchUrl(googleMapsUrl, mode: LaunchMode.externalNonBrowserApplication)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Could not launch the maps application')),
                    );
                  }
                }
                else if(Platform.isIOS){
                  if (!await launchUrl(appleMapsUrl, mode: LaunchMode.externalApplication)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Could not launch the maps application')),
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, Contact contact) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Contact'),
        content: const Text('Are you sure you want to delete this contact?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<ContactBloc>().add(DeleteContact(contact.id));
              Navigator.of(context).pop(); // Close the dialog
              Navigator.of(context).pop(); // Go back to the previous screen
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
