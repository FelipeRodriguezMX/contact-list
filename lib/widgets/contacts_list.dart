import 'package:contacts/models/contacts_model.dart';
import 'package:contacts/provider/contacts_provider.dart';
import 'package:contacts/widgets/contact_tile.dart';
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
    final contactsFavorites = contactsProvider.getFavorites();
    final contactsNotFavorites = contactsProvider.getNotFavorites();
    final contacts = contactsProvider.contactos;
    return Column(
      children: [
        // if (contactsFavorites.isNotEmpty)
        SizedBox(
          height: 80,
          child: ContactListContent(
            contacts: contactsFavorites,
            scrollDirection: Axis.horizontal,
            contactsProvider: contactsProvider,
          ),
        ),
        const Padding(padding: EdgeInsets.symmetric(vertical: 20)),
        ContactListContent(
          contacts: contactsNotFavorites,
          scrollDirection: Axis.vertical,
          contactsProvider: contactsProvider,
        )
      ],
    );
  }
}

class ContactListContent extends StatelessWidget {
  const ContactListContent({
    Key? key,
    required this.contacts,
    required this.scrollDirection,
    required this.contactsProvider,
  }) : super(key: key);
  final List<Contacts> contacts;
  final Axis scrollDirection;
  final ContactsProvider contactsProvider;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: contacts.length,
      scrollDirection: scrollDirection,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onDoubleTap: () => contactsProvider.selectFavorite(contacts[index]),
          onLongPress: () =>
              contactsProvider.selectContactsOnLongPress(contacts[index]),
          onTap: () => contactsProvider.selectContactsOnTap(contacts[index]),
          child: ContactTile(
              index: index,
              provider: contactsProvider,
              contact: contacts[index]),
          // child: const Text('data'),
        );
      },
    );
  }
}
