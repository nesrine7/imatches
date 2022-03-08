import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:i_matches/Screens/Manager/alert_dialog.dart';
import 'package:i_matches/Screens/Manager/match_service.dart';
import 'package:i_matches/Screens/Manager/model_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyTeam extends StatefulWidget {
  const MyTeam({Key? key}) : super(key: key);

  @override
  _MyTeamState createState() => _MyTeamState();
}

class _MyTeamState extends State<MyTeam> {

  Future<Member> fetchTeamMembers() async {
    String token= await getTokenFromSF();
    final response = await http.get(
      Uri.parse('https://stats.isporit.com/api/clubs'),
      headers: {
        'accept': 'application/json',
        HttpHeaders.authorizationHeader: '$token',
      },
    );
    if (response.statusCode == 200) {
      List<Spot> list=[];
      Map<String, dynamic> map = json.decode(response.body);
      Member m ;
      List<dynamic> data = map["spots"];
      data.forEach((i) {
        Map obj=i;
        UserData u = new UserData(firstName:obj['userData']['firstName'].toString() ,lastName: obj['userData']['lastName'],profilePicture: obj['userData']['profilePicture'],phoneNumber: obj['userData']['phoneNumber'],date: obj['userData']['birthday']);
        String role=obj['role'].toString();
        String mail = obj['invitationEmail'].toString();
        Spot s = new Spot(role: role,userdata: u ,mail: mail);
        list.add(s);

      });
      m=new Member(spots:list);
      print(m);
      return m;
    }
    else {
      throw Exception("Fail to fetch data ");
    }
  }
  getTokenFromSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    return token;
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future:fetchTeamMembers(),
        builder:
            (BuildContext context,
            AsyncSnapshot<Member> projectSnap) {
              if (projectSnap.connectionState == ConnectionState.none ||
                  !projectSnap.hasData) {
                return Scaffold(

                    body: Center(
                        child: SizedBox(
                          child: CircularProgressIndicator(),
                          height: 50.0,
                          width: 50.0,
                        )
                    )
                );
              }

                return
                Scaffold(
                  appBar: AppBar(
                    title: Text("My Team ",style: TextStyle(color: Colors.black),),
                    elevation: 20,
                    flexibleSpace: Container(
                       decoration: BoxDecoration(
                        image: DecorationImage(
                           image: AssetImage('assets/appbarbackground.jpg'),
                           fit: BoxFit.cover,
                           ),
                 ),
              ),
                  ),
                  floatingActionButton: FloatingActionButton(onPressed: (){},
                    backgroundColor: Colors.lightGreen,
                    child: Icon(Icons.add,color: Colors.white,),
                  ),
                  body: ListView.builder(
                        itemCount: projectSnap.data!.spots!.length,
                        itemBuilder: (context, index ) {
                          String role = projectSnap.data!.spots![index].role.toString();
                          String fn=projectSnap.data!.spots![index].userdata!.firstName.toString();
                          String ln = projectSnap.data!.spots![index].userdata!.lastName.toString();
                          String phone = projectSnap.data!.spots![index].userdata!.phoneNumber.toString();
                          String mail= projectSnap.data!.spots![index].mail.toString();
                          String datejson = projectSnap.data!.spots![index].userdata!.date.toString();
                          String date = datejson;
                          return Column(children:[
                            ListTile(
                              onLongPress:()
                          {
                            showDialog(

                              context: context,
                              builder: (BuildContext dialogContext) {
                                return  MyAlertDialog(title: fn + ' '+ln, birth:'Date of Birth : '+date, mail: 'Email adress :' + mail,phone: 'Phone Number : '+phone,);
                              },);
                          },
                              title: Text(fn+' '+ln,
                            style: TextStyle(
                                color: Colors.black
                            ),
                          ),
                              subtitle: Text(role,
                            ),
                              leading: Icon(Icons.wallet_membership),
                            )]);
                        },
                  ),
                );
              }
            );

  }
}
