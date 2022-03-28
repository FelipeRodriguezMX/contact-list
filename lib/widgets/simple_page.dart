import 'package:contacts/provider/contacts_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SimplePage extends StatelessWidget {
  const SimplePage({Key? key, required this.title, required this.child})
      : super(key: key);
  final String title;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SafeArea(
        child: child,
      ),
    );
  }
}

class SimplePageWithFloatingButton extends StatelessWidget {
  const SimplePageWithFloatingButton({
    Key? key,
    required this.title,
    required this.child,
  }) : super(key: key);
  final String title;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    final contactsProvider =
        Provider.of<ContactsProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          if (contactsProvider.isSelectMode != false)
            deleteIconButton(contactsProvider)
        ],
      ),
      body: SafeArea(
        child: child,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Provider.of<ContactsProvider>(context, listen: false)
            .moveToContactScreenOnPress(context, 'Agregar', -1),
        elevation: 0,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget deleteIconButton(ContactsProvider contactsProvider) {
    return Padding(
      padding: const EdgeInsets.only(right: 25.0),
      child: GestureDetector(
        onTap: () => contactsProvider.deleteContacts(),
        child: const Icon(
          Icons.delete_outlined,
          color: Colors.redAccent,
          size: 30,
        ),
      ),
    );
  }
}
