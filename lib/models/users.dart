
class User{

  String prenom;
  String nom;
  String email;
  String password;
  String username="";
  String roles;
  bool isActive;
  int id;
  var image;

  User(this.prenom,this.nom,this.email,this.password,this.username,this.roles,this.image,this.isActive,this.id);
}