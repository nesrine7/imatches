
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:i_matches/Route/routes.dart'as route;
import 'package:http/http.dart' as http;

import 'model_manager.dart';




class MyDrawer extends StatefulWidget {
  const MyDrawer({ Key? key }) : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();

}

class _MyDrawerState extends State<MyDrawer> {
   SharedPreferences? prefs;


  @override
 void initsate(){
    super.initState();
 }



   checkLoginStatus() async {
     prefs = await SharedPreferences.getInstance();
     if(prefs?.getString("token") == null) {
       Navigator.of(context).pushNamed(route.login);
     }
   }

  @override
  Widget build(BuildContext context) {
  //  final Manager args = ModalRoute.of(context).settings.arguments;
    return Container(
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.all(0.0),
          children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text(""),
                accountEmail: Text(""),

                decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/appbarbackground.jpg"),
                     fit: BoxFit.cover)
              ),),

             ListTile(
                title: Text('Profile'),
                leading: Icon(Icons.person),
                onLongPress: (){},
                ),
              ListTile(
                title: Text('Logout'),
                leading: Icon(Icons.close),
                onTap: (){
                prefs?.clear();
                prefs?.commit();
                Navigator.pushNamed(context, route.login);
                }
                ),
          ]
        ),
      ),


      
    );  
  }
}

