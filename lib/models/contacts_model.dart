class Contacts {
  Contacts({
    required this.id,
    required this.nombre,
    required this.apellido,
    required this.correo,
    required this.telefono,
    required this.isFavorite,
  });
  int id;
  String nombre;
  String apellido;
  String correo;
  String telefono;
  bool? isFavorite;
}
