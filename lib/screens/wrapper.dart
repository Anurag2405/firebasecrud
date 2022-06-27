import 'package:flutter/material.dart';
import 'package:new_proj/screens/authenticate/authenticate.dart';
import 'package:new_proj/screens/home/home.dart';
import 'package:provider/provider.dart';
import 'package:new_proj/models/user.dart';


class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<myUser?>(context);

    //return either home or auth screens
    if(user == null){
      return Authenticate();
    } else{
      return Home();
    }
  }
}
