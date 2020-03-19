import 'package:flutter/material.dart';
import 'package:flutter_app/models/partenaire.dart';
import 'package:flutter_app/models/depot.dart';

class StepperView extends StatefulWidget {
  StepperView() : super();

  final String title = "Stepper Demo";

  @override
  StepperViewState createState() => StepperViewState();
}

class StepperViewState extends State<StepperView> {


  //
  int current_step = 0;


 static Partner partner=new Partner();
 static Depot depot =new Depot();
  List<Step> steps = [
    Step(
      title: Text('Infos Partenaire'),
      content: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(
                labelText: "Ninea",
                icon: Icon(Icons.radio_button_unchecked,color: Colors.blue),
              ),
              onChanged: (val){
                partner.ninea=val;
                print(partner.ninea);
              },
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(
                labelText: "Registre de Commerce",
                icon: Icon(Icons.nature,color: Colors.blue),
              ),
              onChanged: (va){
               partner.rc=va;
              },

            ),
          ),
        ],
      ),
      isActive: true,
    ),
    Step(
      title: Text('Infos User'),
      content:  Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(
                labelText: "Prenom",
                icon: Icon(Icons.account_box,color: Colors.blue),
              ),
                onChanged: (va){
                  partner.users.prenom=va;
                }
              ,

            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(
                labelText: "Nom",
                icon: Icon(Icons.bubble_chart,color: Colors.blue),
              ),
                onChanged: (va){
                  partner.users.nom=va;
                }
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(
                labelText: "Email",
                icon: Icon(Icons.mail,color: Colors.blue),
              ),
                onChanged: (va){
                  partner.users.email=va;
                }
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(
                labelText: "Username",
                icon: Icon(Icons.account_circle,color: Colors.blue),
              ),
                onChanged: (va){
                  partner.users.username=va;
                }
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(
                labelText: "Password",
                icon: Icon(Icons.lock,color: Colors.blue),
              ),
                onChanged: (va){
                  partner.users.password=va;
                }
            ),
          ),
        ],
      ),
      isActive: true,
    ),
    Step(
      title: Text('Faire depot'),
      content: Container(
        margin: EdgeInsets.all(10),
        child: TextField(
          decoration: InputDecoration(
            labelText: "Montant depot",
            icon: Icon(Icons.account_balance_wallet,color: Colors.blue),
          ),
          keyboardType: TextInputType.number,
          onChanged: (va){
            depot.montant = va;
          },

        ),
      ),
      state: StepState.complete,
      isActive: true,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Appbar
      appBar: AppBar(
        // Title
        title: Text("Création de Comptes"),
      ),
      // Body
      body: Container(
        child: Stepper(
          currentStep: this.current_step,
          steps: steps,
          type: StepperType.horizontal ,
          onStepTapped: (step) {
            setState(() {
              current_step = step;
            });
          },
          onStepContinue: () {
            setState(() {
              if (current_step < steps.length - 1) {
                current_step = current_step + 1;
              } else {
                current_step = 0;
              }
            });
          },
          onStepCancel: () {
            setState(() {
              if (current_step > 0) {
                current_step = current_step - 1;
              } else {
                current_step = 0;
              }
            });
          },
        ),
      ),
    );
  }
}
