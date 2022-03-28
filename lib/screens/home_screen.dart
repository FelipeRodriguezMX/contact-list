import 'package:contacts/provider/contacts_provider.dart';
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
      child: const ContactsList(),
    );
  }
}

class ContactsList extends StatefulWidget {
  const ContactsList({Key? key}) : super(key: key);

  @override
  State<ContactsList> createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  @override
  Widget build(BuildContext context) {
    final contactsProvider =
        Provider.of<ContactsProvider>(context, listen: true);
    if (contactsProvider.selectedElements.isEmpty) {
      contactsProvider.isSelectMode = false;
    }
    return SizedBox(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: contactsProvider.contactos.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onLongPress: () =>
                  contactsProvider.selectContactsOnLongPress(index),
              onTap: () => contactsProvider.selectContactsOnTap(index),
              child: contactsTile(index, contactsProvider),
            );
          }),
    );
  }

  Widget contactsTile(int index, ContactsProvider provider) {
    final contact = provider.contactos[index];
    return Card(
      color: (provider.selectedElements.contains(index) == true)
          ? Colors.redAccent
          : Colors.grey[200],
      elevation: 0,
      child: ListTile(
        leading: iconContact(),
        title: Text('${contact.nombre} ${contact.apellido}'),
        subtitle: Text(contact.telefono),
        trailing: actionTileContact(provider, index),
      ),
    );
  }

  Widget actionTileContact(ContactsProvider provider, index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            onPressed: () =>
                provider.moveToContactScreenOnPress(context, 'Editar', index),
            icon: const Icon(Icons.arrow_forward_ios)),
      ],
    );
  }

  Widget iconContact() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Container(
            padding: const EdgeInsets.all(5),
            color: Colors.white,
            child: const Icon(
              Icons.person,
              size: 40,
            ),
          ),
        )
      ],
    );
  }
}
