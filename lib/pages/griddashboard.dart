import 'package:flutter/material.dart';
import 'package:flutter_app/pages/addUser.dart';
import 'package:flutter_app/pages/createAccount.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_app/pages/ListsUsers.dart';

class GridDashboard extends StatefulWidget {

  final role;
  GridDashboard(this.role);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return GridState();
  }

}
class GridState extends State<GridDashboard>{


  List<Items> myList=[];
  final Items item1 = new Items(
      title: "Creation de users",
      subtitle: "Creer vos utilisateurs",
      event: "",
      img: "assets/adduser.png",
      route : AddUserPage())
  ;

  final Items item2 = new Items(
      title: "Gestion users",
      subtitle: "Listez ,Bloquer ou modifier vos users",
      event: "",
      img: "assets/modiuser.png",
      route : listUsers()
  );
  final Items item3 = new Items(
      title: "Creer Compte ",
      subtitle: "creer comptes partenaire",
      event: "",
      img: "assets/partner.png",
      route: StepperView()
  );
  final Items item4 = new Items(
    title: "Faire Dépot",
    subtitle: "Déposer de l'argent pour un compte",
    event: "",
    img: "assets/depot.png",
  );
  final  Items item5 = new Items(
    title: "Affectation Comptes",
    subtitle: "Affecter vos Comptes à vos user",
    event: "",
    img: "assets/todo.png",
  );
  final Items item6 = new Items(
    title: "Transaction",
    subtitle: "Envoyer de l'argent ou retirer",
    event: "",
    img: "assets/setting.png",
  );
  getItems(){
    if(this.widget.role=="ROLE_ADMIN_SYST" || this.widget.role=="ROLE_ADMIN"){
      myList = [item1, item2, item3, item4];
    }if(this.widget.role=="ROLE_CAISSIER"){
      myList = [item4];
    }if(this.widget.role=="ROLE_PARTENAIRE" || this.widget.role=="ROLE_PADMIN"){
      myList = [item5,item6];
    }if(this.widget.role=="ROLE_PUSER"){
      myList = [item6];
    }
  }
@override
void initState() {
    // TODO: implement initState
    super.initState();
    getItems();
  }


  @override
  Widget build(BuildContext context) {


    var color = 0xff453658;

    return Flexible(
      child:
      (myList!=[])?
      GridView.count(
          childAspectRatio: 1.0,
          padding: EdgeInsets.only(left: 16, right: 16),
          crossAxisCount: 2,
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
          children:
          myList.map((data) {
            return new GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => data.route ),
                  );
                },
                child:
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white60, borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black12)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        data.img,
                        width: 60,
                      ),
                      SizedBox(
                        height: 14,
                      ),
                      Text(
                        data.title,
                        style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                                color: Colors.blue,
                                fontSize: 16,
                                fontWeight: FontWeight.w600)),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        data.subtitle,
                        style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                                color: Colors.black38,
                                fontSize: 10,
                                fontWeight: FontWeight.w600)),
                      ),
                      SizedBox(
                        height: 14,
                      ),
                      Text(
                        data.event,
                        style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                                color: Colors.black38,
                                fontSize: 11,
                                fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                ));
          }).toList())
            :null );
  }
}

class Items {
  String title;
  String subtitle;
  String event;
  String img;
  var route ;
  Items({this.title, this.subtitle, this.event, this.img,this.route});
}
