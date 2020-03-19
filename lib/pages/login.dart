import 'dart:convert';
//Permet de convertir du json avec decode\encode
import 'package:flutter/material.dart';
//Permet,de faire le design
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

//Permet les requetes http
import 'package:http/http.dart' as http;

//Permet de stocker les infos du token comme localStorage
import 'package:shared_preferences/shared_preferences.dart';

//Permet de decoder le token
import 'package:jaguar_jwt/jaguar_jwt.dart';

import 'dash.dart';

class LoginPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _LoginPage();
  }

}

class _LoginPage extends State<LoginPage> {


  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String token;
String error;
  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
        appBar: AppBar(
          title: Text('Transfert Argent'),
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'KAYPAY',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )),
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child:(error==null)?  Text("Connectez-vous",
                        style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600))):
                    Text(error,
                        style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                                color: Colors.redAccent,
                                fontSize: 16,
                                fontWeight: FontWeight.w600))),),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: Text('Se connecter'),
                      onPressed: () {
                       // Navigator.push(
                         // context,
                       //   MaterialPageRoute(builder: (context) => Home()),
                       // );
                        login(nameController.text,passwordController.text);
                      },
                    )),
              ],
            )));
  }


  // ignore: missing_return
  void login(String username ,String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(nameController.text);
    print(passwordController.text);
    String url = "http://10.0.2.2:8000/api/login_check";
    var body =  {
      "username": username,
      "password": password
    };


  var res= await http.post(url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json"

        },
        body: json.encode(body)
    );
  if(res.statusCode>=200 && res.statusCode < 400 ){

      this.token=json.decode(res.body)['token'];
      prefs.setString('token', this.token);

      //DECODAGE DU TOKEN
      final String token =this.token;
      final parts = token.split('.');
      final payload = parts[1];
      final String decoded = B64urlEncRfc7515.decodeUtf8(payload);

      var tok =json.decode(decoded);
      prefs.setString('role', tok["roles"][0]);
      prefs.setInt('id', tok["id"] );
      //var id= tok['id'];
     Navigator.push(
      context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    }else{

    error=json.decode(res.body)['message'];
    print(error);

    if(error=="Invalid credentials."){
      setState(() {
        error="Identifiants Incorrects";
      });
    }else{
      setState(() {
        error=error;
      });
    }

  }

  }

}