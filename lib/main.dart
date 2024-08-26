import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/contact_bloc.dart';
import 'repository/contact_repository.dart';
import 'router/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final repository = await ContactRepository.create();
  runApp(MyApp(repository: repository));
}

class MyApp extends StatelessWidget {
  final ContactRepository repository;

  const MyApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactBloc(repository)..add(LoadContacts()),
      child: MaterialApp.router(
        title: 'Contacts App',
        routerConfig: router,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }
}
