import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_proj/models/user.dart';
import 'package:new_proj/services/database.dart';
import 'package:new_proj/shared/constants.dart';
import 'package:new_proj/shared/loading.dart';
import 'package:provider/provider.dart';


class SettingsForm extends StatefulWidget {
  const SettingsForm({Key? key}) : super(key: key);

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  // form values
  String? _currentName;
  String? _currentSugars;
  int? _currentStrength;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<myUser?>(context);
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user!.uid!).userData,
      builder: (context, snapshot) {

        if(snapshot.hasData){
          UserData userdata = snapshot.data!;

          return Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  'Update your brew settings.',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  initialValue: userdata.name,
                  decoration: textInputDecoration,
                  validator: (val) => val!.isEmpty ? 'Please enter a name' : null,
                  onChanged: (val) => setState(() => _currentName = val),
                ),
                SizedBox(height: 10.0),
                DropdownButtonFormField(
                  value: _currentSugars ?? userdata.sugars,
                  decoration: textInputDecoration,
                  items: sugars.map((sugar) {
                    return DropdownMenuItem(
                      value: sugar,
                      child: Text('$sugar sugars'),
                    );
                  }).toList(),
                  onChanged: (val) => setState(() => _currentSugars = val.toString() ),
                ),
                SizedBox(height: 10.0),
                Slider(
                    min: 100,
                    max: 900,
                    activeColor: Colors.brown[_currentStrength ?? userdata.strength!],
                    inactiveColor: Colors.brown[_currentStrength ?? userdata.strength!],

                    divisions: 8,
                    value: (_currentStrength ?? userdata.strength!).toDouble(),
                    onChanged: (val) => setState(() => _currentStrength =val.round())),
                ElevatedButton(
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.brown[800],),
                    onPressed: () async {
                      if(_formKey.currentState!.validate()){
                        await DatabaseService(uid: user.uid!).updateUSerDate(
                            _currentSugars ?? userdata.sugars!,
                            _currentName ??  userdata.name!,
                            _currentStrength ?? userdata.strength!
                        );
                        Navigator.pop(context);
                      }
                    }
                ),
              ],
            ),
          );
        } else{
          return Loading();
        }

      }
    );
  }
}
