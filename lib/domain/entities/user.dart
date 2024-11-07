
class User {
    final String id;
    final String email;
    final String fullName;
    final String companyName;
    final String nif;
    final String telefono;
    final String sector;
    final bool isActive;
    final bool aceptaTerminos;
    final bool aceptaComunicaciones;
    final List<String> roles;
    final String token;

    User({
        required this.id,
        required this.email,
        required this.fullName,
        required this.companyName,
        required this.nif,
        required this.telefono,
        required this.sector,
        required this.isActive,
        required this.aceptaTerminos,
        required this.aceptaComunicaciones,
        required this.roles,
        required this.token,
    });

  bool get isAdmin{
    return roles.contains('admin');
  }


}
