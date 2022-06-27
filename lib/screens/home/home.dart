import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_proj/models/brew.dart';
import 'package:new_proj/screens/home/settings_form.dart';
import 'package:new_proj/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:new_proj/services/database.dart';
import 'brew_list.dart';

class Home extends StatelessWidget {
  // const Home({Key? key}) : super(key: key);

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20,horizontal: 60),
          child: SettingsForm(),
        );
      });
    }

    return StreamProvider<List<Brew>?>.value(
      value: DatabaseService(uid: ' ').brews,
      initialData: null,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text("Brew Crew"),
          backgroundColor: Colors.brown[400],
          elevation: 0,
          actions: [
            TextButton.icon(
                onPressed: (){
                  _showSettingsPanel();
                },
                icon: const Icon(Icons.settings,color: Colors.black,),
                label: Text("Settings",style: TextStyle(color: Colors.black),)
            ),
            TextButton.icon(
                onPressed: ()async {
                  await _auth.Signout();
                },
                icon: const Icon(Icons.logout_rounded,color: Colors.black,),
                label: Text("Logout",style: TextStyle(color: Colors.black),)
            ),

          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/coffee_bg.png'),
              fit: BoxFit.cover,
            )
          ),
            child: BrewList()
        ),
      ),
    );
  }
}
