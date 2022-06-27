import 'package:flutter/material.dart';
import 'package:new_proj/services/auth.dart';
import 'package:new_proj/shared/constants.dart';
import 'package:new_proj/shared/loading.dart';
class SignIn extends StatefulWidget {

  final Function toggleview;
  SignIn({required this.toggleview});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();

  //text field state
  String email = "";
  String password = "";
  String error = "";
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text("Sign in to brew crew"),
        actions: [
          TextButton.icon(
          onPressed: (){
            widget.toggleview();
          },
              icon: const Icon(Icons.person,color: Colors.black,),
              label: Text("Register",style: TextStyle(color: Colors.black),)
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              SizedBox(height: 20,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Email'),
                onChanged: (val){
                  setState(() => email = val);
                },
                validator: (val) => val!.isEmpty ? "Enter an email" : null,

              ),
              SizedBox(height: 20,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
                obscureText: true,
                onChanged: (val){
                  setState(() => password = val);
                },
                validator: (val) => val!.length < 6 ? "Enter more than 6 characters" : null,
              ),
              SizedBox(height: 20,),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.brown[400],
                  ),
                  onPressed: () async {
                    if(_formkey.currentState!.validate()){
                      setState(() => loading = true);
                      dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                      if(result == null){
                        setState(() {
                          error = 'Could not sign in with those credentials';
                          loading = false;
                        });
                      }
                    }
                  },
                  child: Text("Sign in",style: TextStyle(color: Colors.white),)),
              SizedBox(height: 20,),
              Text(error,style: TextStyle(color: Colors.red),),
            ],
          ),
        ),
      ),
    );
  }
}

//anonymous signin button
// ElevatedButton(
// child: Text("Sign in anon"),
// onPressed: () async{
// dynamic result = await _auth.signInAnon();
// if(result == null){
// print("error signing in");
// } else {
// print("signed in");
// print(result.uid);
// }
// },
// ),
