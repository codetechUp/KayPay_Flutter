import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_app/helpers/interceptor.dart';

import 'package:flutter_app/models/users.dart';

import 'package:flutter_app/services/userService.dart';

import 'package:http_interceptor/http_interceptor.dart';

class AddUserPage extends StatefulWidget {
  @override
  _AddUserPageState createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {


 UserService userService=new UserService();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController prenomController = TextEditingController();
  TextEditingController nomController = TextEditingController();
  TextEditingController emailController = TextEditingController();
var selected;

List  roles;
User user;

  String token;

  @override
  void initState() {
    // TODO: implement initState
    this.getRoles();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
        appBar: AppBar(
          title: Text('Creations de users')
        ),
        body: Padding(
            padding: EdgeInsets.all(8),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(8),
                    child: Text(
                      'KAYPAY',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )),
                Container(
                  padding: EdgeInsets.all(8),
                  child: TextField(
                    controller: prenomController,

                    decoration: InputDecoration(
                     icon: Icon(Icons.account_circle,color: Colors.blue),
                      hintText: 'Prenom',
                      labelText: 'Prenom'

                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  child: TextField(
                    controller: nomController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.bubble_chart,color: Colors.blue),
                      labelText: 'Nom',
                      hintText: 'Nom'
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  child: TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.account_circle,color: Colors.blue),
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
                      icon: Icon(Icons.lock,color: Colors.blue),
                      labelText: 'Password',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  child: TextField(
                    obscureText: true,
                    controller: emailController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.mail,color: Colors.blue),
                      labelText: 'email',
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
               Center(
                 child:  Container(
                     padding: EdgeInsets.all(8),
                     child:DropdownButton(
                       items: (roles != null)? roles.map((value)=>DropdownMenuItem(
                         child: Text(value['libelle']),
                         value : value['id'],
                       )).toList() : null,
                       onChanged: (e){
                         setState(() {
                           selected = e;
                           print(selected);
                         });

                       },
                       value: selected,
                       hint: Text("Choisir son role"),
                     )
                 ),
               ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: Text('Créer l\'utilisateur'),
                      onPressed: () {
                        setState(() {
                          createUsers();
                        });
                        // Navigator.push(
                        // context,
                        //   MaterialPageRoute(builder: (context) => Home()),
                        // );

                      },
                    )),
              ],
            )));

  }
 void getRoles() async {

    String url = "http://10.0.2.2:8000/api/roles";

    var res = await HttpWithInterceptor.build(
        interceptors: [ Interceptor() ])
        .get(url);

    print(res.body);
    var role = json.decode(res.body);
    print(role["hydra:member"]);


    setState(() {
      this.roles=role["hydra:member"];

    });

  }

  void createUsers() async {
   var  user={
      "prenom":prenomController.text,
      "nom":nomController.text,
      "username":usernameController.text,
      "password":passwordController.text,
      "email":emailController.text,
      "role":"api/roles/"+selected.toString()
    };
   print(user);
  var res= this.userService.createUser(json.encode(user));

   print(res);
  }


}

