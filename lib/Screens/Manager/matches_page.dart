import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:i_matches/Route/routes.dart' as route;
import 'package:i_matches/Screens/Manager/RenameDialog.dart';
import 'package:i_matches/Screens/Manager/deleteDialog.dart';
import 'package:i_matches/Screens/Manager/match_service.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Constants{
  static const String Rename = 'Rename';
  static const String Delete = 'Delete';

  static const List<String> choices = <String>[
    Rename,
    Delete,];
}

class MatchesPage extends StatefulWidget {
  const MatchesPage({ Key? key }) : super(key: key);

  @override
  _MatchesPageState createState() => _MatchesPageState();
}


class _MatchesPageState extends State<MatchesPage> {




  String title='';
  String name='';

  choiceAction(String choice){
    if(choice == Constants.Rename){
      showDialog(
          context: context,
          builder: (BuildContext dialogContext) {
            return RenameDialog2(title: name, );
          }
      );
      }
    else if(choice == Constants.Delete){
      showDialog(
          context: context,
          builder: (BuildContext dialogContext) {
           return DeleteDialog(title: name,);
          }
      );
   }
    }

 getMatchTitleFromSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? match = prefs.getString('matchTitle');

    setState(() {
      title=match!;

    });
    return match;
  }
getnewMatchVideoName()async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? videoname = prefs.getString('newVideoName');
  setState(() {
    name=videoname!;
  });
}

  @override
  void initState() {
    super.initState();
    getMatchTitleFromSF();
  }
  @override
  Widget build(BuildContext context) {
    return
      StreamBuilder(
        stream: MatchService().fetchMatchVideo().asStream(),
          builder:
              (BuildContext context,
                 AsyncSnapshot<List<String>> projectSnap) {
                if (projectSnap.connectionState == ConnectionState.none ||
                    !projectSnap.hasData) {
                  return Scaffold(
                      body:Center(
                      child:SizedBox(
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
          flexibleSpace: FlexibleSpaceBar(
            title: new Text(
              title,
            ),
          ),
          centerTitle: false,
          backgroundColor: Colors.white,
          elevation: 10,),
        body: GridView.builder(
          itemCount: projectSnap.data!.length,
          itemBuilder: (context,index){
            return Row(
            children: [
          Container(
          width:180 ,
          height: 270,padding: const EdgeInsets.all(10.0),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          elevation: 5,
          child: InkWell(
            onTap: (){

         /*     MatchService().getMatchId(projectSnap.data![index]);
              Navigator.pushNamed(context, route.video );*/
                 },
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),),
                   PopupMenuButton<String>(
                     onSelected: choiceAction,
                     itemBuilder: (BuildContext context){
                       return Constants.choices.map((String choice){
                         name=projectSnap.data![index];

                         return PopupMenuItem<String>(
                           value: choice,
                           child: Text(choice),
                     );
              }).toList();
            },
          ),
                Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    Image.asset('assets/match1.png',
                    height: 100,

                    ),
                  ],
                ),
          Container(
              child : Padding(
                  padding: const EdgeInsets.all(1),
                  child : Text(
                    projectSnap.data![index],
                    style: TextStyle(
                      fontSize: 20
                    ),
                    textAlign: TextAlign.center,
                  )
              )
          )
        ],
        ),
        )
        )
           )
            ]);
            },
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 130 / 200,
            crossAxisCount: 2,),
                    )
                );
        });
  }
}

