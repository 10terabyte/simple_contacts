
# Simple Contacts Management App

This is a Flutter-based Contacts Management application designed to mimic the functionality and style of a native Android Contacts app. The application is built using modern Flutter state management (Bloc), routing (GoRouter), and persistence with ObjectBox. The app includes features such as search functionality, logging, and dynamic forms for adding, editing, and deleting contacts.

## Features

- **State Management:** Managed using Flutter Bloc for predictable state changes.
- **Routing:** Implemented with GoRouter for smooth navigation between screens.
- **Database:** Uses ObjectBox for fast and efficient local database storage.
- **Logging:** Integrated Logger package for detailed logging of user actions.
- **Multiple Addresses and Phone Numbers:** Each contact can have multiple phone numbers and addresses.
- **Search Functionality:** Search contacts by name.
- **Dynamic Forms:** Add or remove phone numbers and addresses dynamically while creating or editing contacts.
- **Interactive UI:** Icons for calling, messaging, and viewing addresses directly from the contact list or detail view.

## File Structure

```
lib/
├── bloc/
│   ├── contact_bloc.dart        # Bloc for managing contact states and events
│   ├── contact_event.dart       # Events for contact Bloc
│   └── contact_state.dart       # States for contact Bloc
│
├── models/
│   ├── address.dart             # Address model
│   └── contact.dart             # Contact model with multiple phone numbers and addresses
│
├── repository/
│   └── contact_repository.dart  # Repository for managing data operations
│
├── router/
│   └── router.dart              # GoRouter configuration for navigation
│
├── theme/
│   └── my_theme.dart            # Theme configurations for light and dark modes
│
├── ui/
│   ├── components/
│   │   ├── alphabetical_contact_list.dart # Component for displaying contacts in alphabetical order
│   │   ├── contact_header.dart   # Component for the header with search and profile info
│   │   └── ...
│   ├── add_contact_screen.dart   # Screen for adding a new contact
│   ├── contact_detail_screen.dart # Screen displaying detailed information about a contact
│   ├── contact_form.dart         # Form widget for creating and editing contacts
│   ├── contact_screen.dart       # Main screen showing the list of contacts
│   └── edit_contact_screen.dart  # Screen for editing an existing contact
│
├── utils/
│   ├── json_loader.dart          # Utility for loading initial contacts from JSON
│   ├── url_launcher_util.dart    # Utility class for handling URL actions like calls, messages, and maps
│
├── main.dart                     # Main entry point of the application
├── objectbox.g.dart              # Generated ObjectBox code
└── objectbox-model.json          # ObjectBox model configuration
```

## Getting Started

### Prerequisites

- **Flutter SDK:** Ensure you have the Flutter SDK installed. You can download it from [Flutter's official website](https://flutter.dev/docs/get-started/install).
- **Dart SDK:** Included with Flutter, so it will be installed automatically.

### Installation

1. **Clone the repository:**

   ```bash
   git clone https://github.com/10terabyte/simple_contacts.git
   cd simple_contacts
   ```

2. **Install dependencies:**

   Run the following command to install the required dependencies:

   ```bash
   flutter pub get
   ```

3. **Generate ObjectBox model:**

   ObjectBox requires code generation for the database models. Run the following command:

   ```bash
   flutter pub run build_runner build
   ```

4. **Run the app:**

   Start the app on your emulator or physical device:

   ```bash
   flutter run
   ```

## JSON Format

The app initially loads contacts from a JSON file. The JSON structure should look like this:

```json
[
  {
    "id": 1,
    "firstName": "John",
    "lastName": "Doe",
    "phoneNumbers": ["123-456-7890", "098-765-4321"],
    "addresses": [
      {
        "streetAddress1": "123 Main St",
        "streetAddress2": "Apt 4B",
        "city": "New York",
        "state": "NY",
        "zipCode": "10001"
      }
    ]
  }
  // Add more contacts as needed
]
```

## Key Classes and Files

- **Contact Model (`contact.dart`):** Defines the structure of a contact, including multiple phone numbers and addresses.
- **Address Model (`address.dart`):** Represents the structured address for a contact.
- **ContactForm (`contact_form.dart`):** A dynamic form for adding or editing contacts.
- **ContactBloc (`contact_bloc.dart`):** Handles the business logic and state management for contacts.
- **UrlLauncherUtil (`url_launcher_util.dart`):** Handles external actions such as making a phone call, sending a message, or viewing an address in a map.

## Logging

The app uses the Logger package to log important actions:

- **Phone Call:** Logs attempts to make a phone call.
- **Message:** Logs attempts to send a message.
- **View Address:** Logs attempts to view an address in Google Maps.

Logs can be found in the console output when running the app.

## ObjectBox

The app uses ObjectBox for local data persistence. Ensure that you have run the `build_runner` to generate the necessary ObjectBox code before running the app.

## Contributions

Contributions are welcome! Please fork the repository and submit a pull request with your changes.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Repository

You can find the repository on GitHub: [simple_contacts](https://github.com/10terabyte/simple_contacts.git)
