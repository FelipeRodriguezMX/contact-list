import 'package:contacts/provider/contacts_provider.dart';
import 'package:contacts/widgets/contacts_list.dart';
import 'package:contacts/widgets/simple_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SimplePageWithFloatingButton(
      title: 'Contactos',
      child: body(),
    );
  }

  Widget body() {
    final contactsProvider =
        Provider.of<ContactsProvider>(context, listen: true);
    if (contactsProvider.isEmpty()) {
      return const Center(
        child: Text('No hay contactos'),
      );
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: const ContactsList(isFavorite: false),
    );
  }
}
