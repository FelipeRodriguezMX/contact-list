import 'package:contacts/models/contacts_model.dart';
import 'package:contacts/provider/contacts_provider.dart';
import 'package:contacts/widgets/simple_page.dart';
import 'package:contacts/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({Key? key, required this.title, this.index})
      : super(key: key);
  final String title;
  final int? index;

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  final TextEditingController _nombre = TextEditingController();
  final TextEditingController _apellidos = TextEditingController();
  final TextEditingController _telefono = TextEditingController();
  final TextEditingController _correo = TextEditingController();
  int id = -1;
  bool? isFavorite;
  @override
  void initState() {
    super.initState();
    if (widget.index! >= 0) asignControllerValues();
  }

  @override
  void dispose() {
    super.dispose();
    _nombre.dispose;
    _apellidos.dispose;
    _telefono.dispose;
    _correo.dispose;
  }

  void asignControllerValues() {
    final contacto = Provider.of<ContactsProvider>(context, listen: false)
        .contactos[widget.index!];
    setState(() {
      _nombre.text = contacto.nombre;
      _apellidos.text = contacto.apellido;
      _telefono.text = contacto.telefono;
      _correo.text = contacto.correo;
      id = contacto.id;
      isFavorite = contacto.isFavorite!;
    });
  }

  void guardar() {
    final provider = Provider.of<ContactsProvider>(context, listen: false);
    final contacto = Contacts(
      id: (provider.isEmpty() == true) ? 1 : provider.contactos.length + 1,
      nombre: _nombre.text,
      apellido: _apellidos.text,
      correo: _correo.text,
      telefono: _telefono.text,
      isFavorite: false,
    );
    provider.addContact(context, contacto);
  }

  void editar() {
    final contacto = Contacts(
      id: id,
      nombre: _nombre.text,
      apellido: _apellidos.text,
      correo: _correo.text,
      telefono: _telefono.text,
      isFavorite: isFavorite,
    );
    Provider.of<ContactsProvider>(context, listen: false)
        .editarContacto(context, contacto);
  }

  void cancelar() => Navigator.of(context).pop();
  @override
  Widget build(BuildContext context) {
    return SimplePage(title: widget.title, child: body());
  }

  Widget body() {
    return Column(
      children: [
        CustomInput(
          label: 'Nombre',
          controller: _nombre,
          keyboardType: TextInputType.text,
        ),
        CustomInput(
          label: 'Apellidos',
          controller: _apellidos,
        ),
        CustomInput(
          label: 'Telefono',
          controller: _telefono,
          keyboardType: TextInputType.phone,
        ),
        CustomInput(
          controller: _correo,
          label: 'Correo',
        ),
        const Spacer(),
        actionButtons()
      ],
    );
  }

  Widget actionButtons() {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.redAccent),
              onPressed: () => cancelar(),
              child: const Text(
                'Cancelar',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.blue),
              onPressed: () => (widget.index! == -1) ? guardar() : editar(),
              child: const Text(
                'Guardar',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
