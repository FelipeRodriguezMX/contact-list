import 'package:contacts/models/contacts_model.dart';
import 'package:contacts/provider/contacts_provider.dart';
import 'package:flutter/material.dart';

class ContactTile extends StatelessWidget {
  const ContactTile({
    Key? key,
    required this.contact,
    required this.provider,
    required this.index,
  }) : super(key: key);
  final Contacts contact;
  final ContactsProvider provider;
  final int index;
  @override
  Widget build(BuildContext context) {
    bool isSelected = false;
    for (var i = 0; i < provider.selectedElements.length; i++) {
      if (contact.id == provider.selectedElements[i]) isSelected = true;
    }

    return SizedBox(
      width: 370,
      child: Card(
        color: (isSelected == true) ? Colors.redAccent : Colors.grey[200],
        elevation: 0,
        child: ListTile(
          leading: iconContact(),
          title: Text('${contact.nombre} ${contact.apellido}'),
          subtitle: Text(contact.telefono),
          trailing: SizedBox(
            width: 200,
            child: actionTileContact(context),
          ),
        ),
      ),
    );
  }

  Widget actionTileContact(BuildContext context) {
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
