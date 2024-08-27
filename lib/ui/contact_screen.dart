import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/contact_bloc.dart';
import '../bloc/contact_state.dart';
import '../models/contact.dart';
import '../theme/my_theme.dart';
import 'components/contact_header.dart';
import 'components/alphabetical_contact_list.dart';

class ContactScreen extends StatelessWidget {
  final bool isDarkMode;

  const ContactScreen({required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    final theme = isDarkMode ? MyTheme.darkTheme : MyTheme.lightTheme;

    return MaterialApp(
      theme: theme,
      home: SafeArea(
          child: Scaffold(
            body: BlocBuilder<ContactBloc, ContactState>(
              builder: (context, state) {
                final contacts = state.contacts;

                return Column(
                  children: [
                    ContactHeader(
                      profileName: 'Filip Mojicevic',
                      contactCount: contacts.length,
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          AlphabeticalContactList(),
                          // AlphabetIndex(), // Optional: Alphabetical index on the side
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          )
      ),
    );
  }
}
