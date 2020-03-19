import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'pages/login.dart';


void main()=> runApp(MyApp());


class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title:"KAYPAY TRANSFERT",
      home: LoginPage(),
    );
  }


}

