import 'package:flutter/material.dart';
import '../models/contact.dart';
import '../models/address.dart';

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
  late List<TextEditingController> _phoneControllers;
  late List<_AddressFormController> _addressControllers;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.contact?.firstName ?? '');
    _lastNameController = TextEditingController(text: widget.contact?.lastName ?? '');
    _phoneControllers = (widget.contact?.phoneNumbers ?? ['']).map((phone) => TextEditingController(text: phone)).toList();

    _addressControllers = widget.contact?.addresses.map(
            (address) => _AddressFormController.fromAddress(address)
    ).toList() ?? [_AddressFormController()];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
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
            SizedBox(height: 20),
            Text('Phone Numbers', style: TextStyle(fontWeight: FontWeight.bold)),
            ..._buildPhoneNumberFields(),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: () {
                  setState(() {
                    _phoneControllers.add(TextEditingController());
                  });
                },
                icon: Icon(Icons.add),
                label: Text('Add Phone'),
              ),
            ),
            SizedBox(height: 20),
            Text('Addresses', style: TextStyle(fontWeight: FontWeight.bold)),
            ..._buildAddressFields(),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: () {
                  setState(() {
                    _addressControllers.add(_AddressFormController());
                  });
                },
                icon: Icon(Icons.add),
                label: Text('Add Address'),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final contact = Contact(
                    id: widget.contact?.id ?? 0,
                    firstName: _firstNameController.text,
                    lastName: _lastNameController.text,
                    phoneNumbers: _phoneControllers.map((controller) => controller.text).toList(),
                  );

                  // Update or create new addresses
                  contact.addresses.clear();
                  for (var controller in _addressControllers) {
                    final address = controller.toAddress();
                    address.contact.target = contact; // set the backlink
                    contact.addresses.add(address);
                  }

                  widget.onSave(contact);
                }
              },
              child: Text(widget.contact == null ? 'Create Contact' : 'Save Changes'),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildPhoneNumberFields() {
    return List.generate(_phoneControllers.length, (index) {
      return Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: _phoneControllers[index],
              decoration: InputDecoration(labelText: 'Phone Number ${index + 1}'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the phone number';
                }
                return null;
              },
            ),
          ),
          if (_phoneControllers.length > 1) // Only show remove button if there are multiple fields
            IconButton(
              icon: Icon(Icons.remove_circle),
              onPressed: () {
                setState(() {
                  _phoneControllers.removeAt(index);
                });
              },
            ),
        ],
      );
    });
  }

  List<Widget> _buildAddressFields() {
    return List.generate(_addressControllers.length, (index) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _addressControllers[index].streetAddress1Controller,
            decoration: InputDecoration(labelText: 'Street Address 1'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the street address';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _addressControllers[index].streetAddress2Controller,
            decoration: InputDecoration(labelText: 'Street Address 2'),
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _addressControllers[index].cityController,
                  decoration: InputDecoration(labelText: 'City'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the city';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  controller: _addressControllers[index].stateController,
                  decoration: InputDecoration(labelText: 'State'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the state';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  controller: _addressControllers[index].zipCodeController,
                  decoration: InputDecoration(labelText: 'Zip Code'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the zip code';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          if (_addressControllers.length > 1) // Only show remove button if there are multiple fields
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: Icon(Icons.remove_circle),
                onPressed: () {
                  setState(() {
                    _addressControllers.removeAt(index);
                  });
                },
              ),
            ),
          Divider(),
        ],
      );
    });
  }
}

class _AddressFormController {
  TextEditingController streetAddress1Controller;
  TextEditingController streetAddress2Controller;
  TextEditingController cityController;
  TextEditingController stateController;
  TextEditingController zipCodeController;

  _AddressFormController({
    String streetAddress1 = '',
    String streetAddress2 = '',
    String city = '',
    String state = '',
    String zipCode = '',
  })  : streetAddress1Controller = TextEditingController(text: streetAddress1),
        streetAddress2Controller = TextEditingController(text: streetAddress2),
        cityController = TextEditingController(text: city),
        stateController = TextEditingController(text: state),
        zipCodeController = TextEditingController(text: zipCode);

  factory _AddressFormController.fromAddress(Address address) {
    return _AddressFormController(
      streetAddress1: address.streetAddress1,
      streetAddress2: address.streetAddress2,
      city: address.city,
      state: address.state,
      zipCode: address.zipCode,
    );
  }

  Address toAddress() {
    return Address(
      streetAddress1: streetAddress1Controller.text,
      streetAddress2: streetAddress2Controller.text,
      city: cityController.text,
      state: stateController.text,
      zipCode: zipCodeController.text,
    );
  }
}
