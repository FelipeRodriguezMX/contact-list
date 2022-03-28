import 'package:contacts/models/contacts_model.dart';
import 'package:contacts/screens/contacts_screen.dart';
import 'package:flutter/material.dart';

class ContactsProvider with ChangeNotifier {
  List<Contacts>? _contactos;
  bool isSelectMode = false;
  List<int> selectedElements = [];
  ContactsProvider() {
    _contactos = null;
  }

  List<Contacts> get contactos => _contactos!;

  bool isEmpty() => _contactos == null;

  void notify() => notifyListeners();

  void addContact(BuildContext context, Contacts contact) {
    (_contactos == null) ? _contactos = [contact] : _contactos!.add(contact);
    notifyListeners();
    Navigator.of(context).pop();
  }

  void deleteContacts() {
    for (var i = 0; i < selectedElements.length; i++) {
      _contactos!
          .removeWhere((element) => element.id == selectedElements[i] + 1);
    }
    selectedElements = [];
    isSelectMode = false;
    notifyListeners();
  }

  void editarContacto(BuildContext context, Contacts contact) {
    final index = _contactos!.indexWhere((i) => i.id == contact.id);
    _contactos![index] = contact;
    notifyListeners();
    Navigator.of(context).pop();
  }

  void selectContactsOnLongPress(int index) {
    if (isSelectMode == false) {
      isSelectMode = true;
      selectedElements.add(index);
    }
    notifyListeners();
  }

  void selectContactsOnTap(int index) {
    if (isSelectMode == true && selectedElements.contains(index) == false) {
      selectedElements.add(index);
    } else {
      selectedElements.removeWhere((element) => element == index);
    }
    notifyListeners();
  }

  void moveToContactScreenOnPress(
      BuildContext context, String title, int? index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ContactsScreen(
          title: title,
          index: index,
        ),
      ),
    );
  }
}
