import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_contacts/router/router.dart';
import '../../bloc/contact_bloc.dart';
import '../../bloc/contact_state.dart';
import '../../models/contact.dart';

class AlphabeticalContactList extends StatefulWidget {
  @override
  _AlphabeticalContactListState createState() => _AlphabeticalContactListState();
}

class _AlphabeticalContactListState extends State<AlphabeticalContactList> {
  final ScrollController _scrollController = ScrollController();
  final Map<String, double> _sectionOffsets = {};

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactBloc, ContactState>(
      builder: (context, state) {
        final groupedContacts = _groupContactsByAlphabet(state.contacts);
        _calculateSectionOffsets(groupedContacts);

        return Stack(
          children: [
            ListView.builder(
              controller: _scrollController,
              itemCount: groupedContacts.length,
              itemBuilder: (context, index) {
                String alphabet = groupedContacts.keys.elementAt(index);
                List<Contact> contacts = groupedContacts[alphabet]!;

                return _buildAlphabetGroup(alphabet, contacts);
              },
            ),
            _buildAlphabetIndex(context, groupedContacts.keys.toList()),
          ],
        );
      },
    );
  }

  Map<String, List<Contact>> _groupContactsByAlphabet(List<Contact> contacts) {
    contacts.sort((a, b) => a.firstName.toLowerCase().compareTo(b.firstName.toLowerCase()));

    Map<String, List<Contact>> groupedContacts = {};

    for (var contact in contacts) {
      String firstLetter = contact.firstName[0].toUpperCase();
      if (groupedContacts[firstLetter] == null) {
        groupedContacts[firstLetter] = [];
      }
      groupedContacts[firstLetter]!.add(contact);
    }

    return groupedContacts;
  }

  Widget _buildAlphabetGroup(String alphabet, List<Contact> contacts) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            alphabet,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        ...contacts.map((contact) {
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue, // You can customize the background color
              child: Text(
                contact.firstName.isNotEmpty ? contact.firstName[0] : '',
                style: TextStyle(
                  color: Colors.white, // Text color, you can customize this too
                  fontWeight: FontWeight.bold, // Make the letter bold
                  fontSize: 20.0, // Adjust the font size as needed
                ),
              ),
              radius: 24,
            ),
            title: Text('${contact.firstName} ${contact.lastName}'),
            subtitle: _buildSubTitle(contact.phoneNumbers),
            onTap: () {
              context.go('/contact/${contact.id}');
            },
          );
        }).toList(),
      ],
    );
  }
  Widget? _buildSubTitle(List<String> phoneNumbers) {
    if (phoneNumbers.isNotEmpty) {
      if (phoneNumbers.length == 1) {
        return Text(phoneNumbers.first);
      } else {
        return Text('${phoneNumbers.first} (+${phoneNumbers.length - 1} more...)');
      }
    } else {
      return null;
    }
  }

  void _calculateSectionOffsets(Map<String, List<Contact>> groupedContacts) {
    double offset = 0.0;
    _sectionOffsets.clear();

    groupedContacts.forEach((alphabet, contacts) {
      _sectionOffsets[alphabet] = offset;
      offset += 50.0 + (contacts.length * 72.0); // Header height + contact item height
    });
  }

  Widget _buildAlphabetIndex(BuildContext context, List<String> alphabet) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: alphabet.map((letter) {
            return GestureDetector(
              onTap: () {
                _scrollToAlphabet(letter);
              },
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  letter,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  void _scrollToAlphabet(String letter) {
    if (_sectionOffsets.containsKey(letter)) {
      _scrollController.animateTo(
        _sectionOffsets[letter]!,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }
}
