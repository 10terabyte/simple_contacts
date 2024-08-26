import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_contacts/ui/edit_contact_screen.dart';
import '../ui/contact_list_screen.dart';
import '../ui/contact_detail_screen.dart';
import '../ui/add_contact_screen.dart';
import '../ui/edit_contact_screen.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (context, state) => ContactListScreen(),
      routes: <RouteBase>[
        GoRoute(
          path: 'contact/:id',
          builder: (context, state) {
            final id = state.pathParameters['id'];
            return ContactDetailScreen(contactId: int.parse(id!));
          },
        ),
        GoRoute(
          path: 'add-contact',
          builder: (context, state) => AddContactScreen(),
        ),
        GoRoute(
          path: 'edit-contact/:id',
          builder: (context, state) {
            final id = state.pathParameters['id'];
            return EditContactScreen(contactId: int.parse(id!));
          },
        ),
      ]
    ),
  ],
);
