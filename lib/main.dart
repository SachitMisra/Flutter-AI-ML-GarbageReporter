import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gdgbloc/bloc.dart';
import 'package:gdgbloc/picture.dart';
import 'package:camera/camera.dart';
import 'package:flutter/painting.dart';
import 'package:path_provider/path_provider.dart';
void main() { 
  runApp(MyApp());}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
class Data
{
  TextEditingController txcontroller;
  Data(this.txcontroller);
}
final data = Data(myController);
var myController = TextEditingController();
class HomePage extends StatelessWidget {
  
  changeThePage(BuildContext context) async{
    WidgetsFlutterBinding.ensureInitialized();
  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  final firstCamera = cameras.first;
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => TakePictureScreen(camera: firstCamera,)));

  }
  @override
  Widget build(BuildContext context) {
    final bloc = Bloc();
    return Scaffold(
      //backgroundColor: Colors.white70,
      body: Center(
        child: Container(
         decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/mapsrev1.jpg"),
            fit: BoxFit.cover,
          ),
          ),
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              StreamBuilder<String>(
                stream: bloc.email,
                builder: (context, snapshot) => TextField(
                  controller: myController,
                      onChanged: bloc.emailChanged,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 2, color: Colors.indigo),
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 2, color: Colors.indigo),
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ), 
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: 2, color: Colors.indigo),
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          
                          hintText: "Enter email",
                          labelText: "Email",
                          errorText: snapshot.error),
                    ),
              ),
              SizedBox(
                height: 20.0,
              ),
              /*StreamBuilder<String>(
                stream: bloc.password,
                builder: (context, snapshot) => TextField(
                      onChanged: bloc.passwordChanged,
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 2, color: Colors.indigo),
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 2, color: Colors.indigo),
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ), 
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: 2, color: Colors.indigo),
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          hintText: "Enter password",
                          labelText: "Password",
                          errorText: snapshot.error),
                    ),
              ),*/
              SizedBox(
                height: 20.0,
              ),
              StreamBuilder<bool>(
                stream: bloc.submitCheck,
                builder: (context, snapshot) {
                  return FloatingActionButton.extended(
                    label: Text("Login"),
                    icon: Icon(Icons.delete),
                    onPressed: 
                           () => changeThePage(context)
                          
                  );
                  /*return RaisedButton(
                      color: Colors.blueAccent,
                      onPressed: snapshot.hasData
                          ? () => changeThePage(context)
                          : null,
                      child: Text("Login"),
                    );*/
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
