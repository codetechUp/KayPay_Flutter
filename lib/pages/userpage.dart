import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/models/users.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
 final  user;
  ProfilePage(this.user);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Widget _greenColors() {
    return Positioned(
      top: 0,
      child: Container(
        color: Colors.blue,
        height: 150,
        width: MediaQuery.of(context).size.width,
      ),
    );
  }

  Widget _getInfo() {
    return Positioned(
      top: 37,
      child: Container(

        margin: const EdgeInsets.all(20),
        height: 300,
        width: MediaQuery.of(context).size.width * 0.90,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12),
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              Container(
                  padding: EdgeInsets.only(top:20),
                  alignment: Alignment.center,
                  child: Center(
                    child:CircleAvatar(
                        radius: 45,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(45),
                            child:(this.widget.user.image!= null)? Image.memory(base64.decode(this.widget.user.image),height: 92,width: 92,fit: BoxFit.cover,) : null)),

                  )),
              Container(
                  alignment: Alignment.center,
                  child: Center(
                      child:Container(

                          child:SizedBox(
                            height: 20,
                          )))),

              Container(
                  alignment: Alignment.center,
                  child: Center(
                      child:Container(

                        child: Text('${this.widget.user.prenom} ${ this.widget.user.nom}' ,
                          style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600))
                  )),),),
              Container(
                  alignment: Alignment.center,
                  child: Center(
                      child:Container(

                          child:SizedBox(
                            height: 20,
                          )))),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Username:",
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.w600))),
                  SizedBox(
                    width: 20,
                  ),
                  Text('${this.widget.user.username}' ,
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600)),)
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Role:",
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.w600))),
                  SizedBox(
                    width: 20,
                  ),
                  Text('${this.widget.user.roles}' ,
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600)),)
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("IsActive:",
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.w600))),
                  SizedBox(
                    width: 20,
                  ),
                  (this.widget.user.isActive==true)?
                  Text('${this.widget.user.isActive}' ,
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            color: Colors.green,
                            fontSize: 16,
                            fontWeight: FontWeight.w600)),):
                  Text('${this.widget.user.isActive}' ,
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                            fontWeight: FontWeight.w600)),)
                ],
              ),


          ],
          ),
        ),
      ),
    );
  }

  Widget _userAdress() {
    return Positioned(
      top: 380,
      child: Container(
        margin: EdgeInsets.all(20),
        height: 200,
        width: MediaQuery.of(context).size.width * 0.90,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "User Address:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Village:"),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Nongnioa village"),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("District:"),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Sikhottabong district"),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Province:"),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Vietiane capital"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        title: Text(
          this.widget.user.username,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: Colors.blue,
        centerTitle: true
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
            _greenColors(),
            _getInfo(),
          ],
        ),
      ),
    );
  }
}