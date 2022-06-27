import 'package:flutter/material.dart';
import 'package:new_proj/screens/authenticate/register.dart';
import 'package:new_proj/screens/authenticate/sign_in.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignin = true;
  void toggleView(){
    setState(() => showSignin = !showSignin);
  }
  @override
  Widget build(BuildContext context) {
    if(showSignin == true){
      return SignIn(toggleview: toggleView);
    } else {
      return Register(toggleview: toggleView);
    }
  }
}
