import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/contact_bloc.dart';
import '../models/contact.dart';

class ContactListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Contacts')),
      body: BlocBuilder<ContactBloc, ContactState>(
        builder: (context, state) {
          final contacts = state.contacts;
          return ListView.builder(
            itemCount: contacts.length,
            itemBuilder: (context, index) {
              final contact = contacts[index];
              return ListTile(
                title: Text('${contact.firstName} ${contact.lastName}'),
                onTap: () {
                  context.go('/contact/${contact.id}');
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // Handle add new contact
        },
      ),
    );
  }
}
