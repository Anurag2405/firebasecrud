import 'package:firebase_auth/firebase_auth.dart';
import 'package:new_proj/models/user.dart';
import 'package:new_proj/services/database.dart';
class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;

//  create user object based on firebase user
  myUser? _userFromFirebase(User user){
    return user != null ? myUser(uid: user.uid) : null;
  }

//  auth change user stream
  Stream<myUser?> get user {
    return _auth.authStateChanges()
        .map((User? user) => _userFromFirebase(user!));
  }


//  sign in anon
  Future signInAnon() async{
    try{
      UserCredential result =  await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebase(user!);
    } catch(e){
      print(e.toString());
      return null;
    }
  }


//sign in email pass
  Future signInWithEmailAndPassword(String email,String password) async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromFirebase(user!);
    } catch(e){
      print(e.toString());
      return null;
    }
  }


//register with email and password

  Future registerWithEmailAndPassword(String email,String password) async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      //create a new document for the user with the uid
      await DatabaseService(uid: user!.uid).updateUSerDate('0', 'Anu', 100);
      return _userFromFirebase(user);
    } catch(e){
      print(e.toString());
      return null;
    }
  }

//signout

  Future Signout() async {
    try{
      return _auth.signOut();
    } catch(e){
      print(e.toString());
      return null;
    }
  }

}
