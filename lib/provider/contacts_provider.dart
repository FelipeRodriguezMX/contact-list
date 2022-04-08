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

  int findContactIndex(int id) => _contactos!.indexWhere((i) => i.id == id);

  List<Contacts> getFavorites() =>
      _contactos!.where((i) => i.isFavorite == true).toList();

  List<Contacts> getNotFavorites() =>
      _contactos!.where((i) => i.isFavorite == false).toList();

  void addContact(BuildContext context, Contacts contact) {
    (_contactos == null) ? _contactos = [contact] : _contactos!.add(contact);
    notifyListeners();
    Navigator.of(context).pop();
  }

  void deleteContacts() {
    for (var i = 0; i < selectedElements.length; i++) {
      _contactos!.removeWhere((element) => element.id == selectedElements[i]);
    }
    selectedElements = [];
    isSelectMode = false;
    notifyListeners();
  }

  void editarContacto(BuildContext context, Contacts contact) {
    final index = findContactIndex(contact.id);
    _contactos![index] = contact;
    notifyListeners();
    Navigator.of(context).pop();
  }

  void selectFavorite(Contacts contact) {
    final index = findContactIndex(contact.id);
    if (_contactos![index].isFavorite == false) {
      _contactos![index].isFavorite = true;
      notifyListeners();
      return;
    }
    if (_contactos![index].isFavorite == true) {
      _contactos![index].isFavorite = false;
      notifyListeners();
      return;
    }
  }

  void selectContactsOnLongPress(Contacts contact) {
    if (isSelectMode == false) {
      isSelectMode = true;
      selectedElements.add(contact.id);
    }
    notifyListeners();
  }

  void selectContactsOnTap(Contacts contact) {
    if (isSelectMode == true &&
        selectedElements.contains(contact.id) == false) {
      selectedElements.add(contact.id);
    } else {
      selectedElements.removeWhere((element) => element == contact.id);
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
