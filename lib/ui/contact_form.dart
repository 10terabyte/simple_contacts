import 'package:flutter/material.dart';
import '../models/contact.dart';

class ContactForm extends StatefulWidget {
  final Contact? contact;
  final Function(Contact) onSave;

  ContactForm({this.contact, required this.onSave});

  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _streetAddress1Controller;
  late TextEditingController _streetAddress2Controller;
  late TextEditingController _cityController;
  late TextEditingController _stateController;
  late TextEditingController _zipCodeController;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.contact?.firstName ?? '');
    _lastNameController = TextEditingController(text: widget.contact?.lastName ?? '');
    _phoneNumberController = TextEditingController(text: widget.contact?.phoneNumber ?? '');
    _streetAddress1Controller = TextEditingController(text: widget.contact?.streetAddress1 ?? '');
    _streetAddress2Controller = TextEditingController(text: widget.contact?.streetAddress2 ?? '');
    _cityController = TextEditingController(text: widget.contact?.city ?? '');
    _stateController = TextEditingController(text: widget.contact?.state ?? '');
    _zipCodeController = TextEditingController(text: widget.contact?.zipCode ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          TextFormField(
            controller: _firstNameController,
            decoration: InputDecoration(labelText: 'First Name'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the first name';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _lastNameController,
            decoration: InputDecoration(labelText: 'Last Name'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the last name';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _phoneNumberController,
            decoration: InputDecoration(labelText: 'Phone Number'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the phone number';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _streetAddress1Controller,
            decoration: InputDecoration(labelText: 'Street Address 1'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the street address';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _streetAddress2Controller,
            decoration: InputDecoration(labelText: 'Street Address 2'),
          ),
          TextFormField(
            controller: _cityController,
            decoration: InputDecoration(labelText: 'City'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the city';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _stateController,
            decoration: InputDecoration(labelText: 'State'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the state';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _zipCodeController,
            decoration: InputDecoration(labelText: 'Zip Code'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the zip code';
              }
              return null;
            },
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                final contact = Contact(
                  id: widget.contact?.id ?? 0,  // Use the existing id if editing, otherwise 0 for a new contact
                  firstName: _firstNameController.text,
                  lastName: _lastNameController.text,
                  phoneNumber: _phoneNumberController.text,
                  streetAddress1: _streetAddress1Controller.text,
                  streetAddress2: _streetAddress2Controller.text,
                  city: _cityController.text,
                  state: _stateController.text,
                  zipCode: _zipCodeController.text,
                );
                widget.onSave(contact);
              }
            },
            child: Text(widget.contact == null ? 'Create Contact' : 'Save Changes'),
          ),
        ],
      ),
    );
  }
}
