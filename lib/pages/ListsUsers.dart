import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/helpers/interceptor.dart';
import 'package:flutter_app/models/users.dart';
import 'package:flutter_app/pages/userpage.dart';
import 'package:flutter_app/services/userService.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http_interceptor/http_interceptor.dart';

// ignore: camel_case_types
class listUsers extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _listUsers();
  }
}
  // ignore: camel_case_types
  class _listUsers extends State<listUsers>{

    @override
    void initState() {
      // TODO: implement initState
      super.initState();
      this.getusers();
    }

var userService =new UserService()
    ;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Les utilisateurs"),
      ),
      body: Container(
        child: FutureBuilder(
          future: getusers(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if(snapshot.data==null){
              return Container(
                child: Center(
                  child: Text('Chargement.....'),
                ),
              );
            }else{
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context ,int id){
                    return ListTile(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ProfilePage(snapshot.data[id]) ),
                        );
                      },
                      leading: CircleAvatar(
                        radius: 20,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child:(snapshot.data[id].image!= null)? Image.memory(base64.decode(snapshot.data[id].image),height: 100,width: 100,fit: BoxFit.cover,) : Image.asset("assets/depot.png"))
                      ),
                      title: Text(snapshot.data[id].prenom+" "+snapshot.data[id].nom,
                          style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600))),
                      subtitle: Text(snapshot.data[id].roles,
                          style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600))),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,

                          children:[
                            Switch(
                              value:snapshot.data[id].isActive ,
                              onChanged: (val){

                                bloquer(snapshot.data[id].id, val);
                                setState(() {
                                  snapshot.data[id].isActive=val;
                                });
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content:Text("Vous avez changé le status de "+snapshot.data[id].prenom,
                                      style: GoogleFonts.openSans(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600))),
                                  backgroundColor: Colors.redAccent,
                                ));
                              },
                              activeColor: Colors.blue,
                              inactiveThumbColor: Colors.red,
                            ),
                            SizedBox(
                              width: 10,
                            )
                          ]
                      ),
                    );
                  });
            }

          },
        ),

      ),

    );
  }

  getusers() async {
  return this.userService.getUsers();


  }
    void get() async {

      String url = "http://10.0.2.2:8000/api/users";

      var res = await HttpWithInterceptor.build(
          interceptors: [ Interceptor() ])
          .get(url);

      print(res.body);
      var role = json.decode(res.body);
      print(role["hydra:member"]);



    }
    void bloquer(id,status){
    var body={
      "isActive": status
    };
    this.userService.bloquer(id, body);

    }

  }

