import 'package:contacts/models/contacts_model.dart';
import 'package:contacts/provider/contacts_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactsList extends StatefulWidget {
  const ContactsList({Key? key, required this.isFavorite}) : super(key: key);
  final bool isFavorite;
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
    final contacts = contactsProvider.contactos;
    return SizedBox(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: contacts.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onDoubleTap: () => contactsProvider.selectFavorite(index),
              onLongPress: () =>
                  contactsProvider.selectContactsOnLongPress(index),
              onTap: () => contactsProvider.selectContactsOnTap(index),
              child: contactsTile(index, contactsProvider, contacts[index]),
            );
          }),
    );
  }

  Widget contactsTile(int index, ContactsProvider provider, Contacts contact) {
    // final contact = provider.contactos[index];
    // final contact = c;
    return Card(
      color: (provider.selectedElements.contains(index) == true)
          ? Colors.redAccent
          : Colors.grey[200],
      elevation: 0,
      child: ListTile(
        leading: iconContact(),
        title: Text('${contact.nombre} ${contact.apellido}'),
        subtitle: Text(contact.telefono),
        trailing: SizedBox(
          width: 200,
          child: actionTileContact(provider, index, contact),
        ),
      ),
    );
  }

  Widget actionTileContact(ContactsProvider provider, index, Contacts contact) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (contact.isFavorite == true)
          Icon(
            Icons.star,
            color: Colors.yellow[800],
          ),
        IconButton(
          onPressed: () =>
              provider.moveToContactScreenOnPress(context, 'Editar', index),
          icon: const Icon(Icons.arrow_forward_ios),
        ),
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
