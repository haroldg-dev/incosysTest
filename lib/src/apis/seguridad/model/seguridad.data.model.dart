class SeguridadData {
  final String nomEmpresa;
  final String token;
  final String lastName;
  final int uid;
  final String firstName;

  SeguridadData({
    required this.nomEmpresa,
    required this.token,
    required this.lastName,
    required this.uid,
    required this.firstName,
  });

  factory SeguridadData.fromJson(Map<String, dynamic> json) => SeguridadData(
        nomEmpresa: json["nom_empresa"],
        token: json["token"],
        lastName: json["last_name"],
        uid: json["uid"],
        firstName: json["first_name"],
      );

  Map<String, dynamic> toJson() => {
        "nom_empresa": nomEmpresa,
        "token": token,
        "last_name": lastName,
        "uid": uid,
        "first_name": firstName,
      };
}
