import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:i_matches/Screens/Manager/match_service.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:i_matches/Screens/Manager/model_manager.dart';
import 'package:i_matches/Route/routes.dart' as route;

class DeleteDialog extends StatefulWidget {
  final String? title;

  DeleteDialog({Key? key,this.title}): super();
  @override
  _DeleteDialogState createState() => _DeleteDialogState();
}

class _DeleteDialogState extends State<DeleteDialog> {

  late TextEditingController newName;
  final _formKey=GlobalKey<FormState>();
  late String newname;


  Future<String> getMatchVideoId(String matchvideoname) async {
    String token = await MatchService().getTokenFromSF();
    String club = await MatchService().getClubFromSF();
    String match = await MatchService().getMatchFromSF();
    String id='';
    final response = await http.get(
      Uri.parse('https://stats.isporit.com/api/videos/match/$match?clubId=$club'),
      headers: {
        'accept': 'application/json',
        HttpHeaders.authorizationHeader: '$token',
      },
    );
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      for (var i=0; i<data.length;i++){
        if(data[i]['title']==matchvideoname){
          id=data[i]['_id'];
        }
      }
     MatchService().setMatchvideoId(id);
      return id;
    }
    else {
      throw Exception("Fail to fetch data ");
    }

  }
delete()async{
    String token = await MatchService().getTokenFromSF();
    String club  =  await MatchService().getClubFromSF();
    String id    =    await MatchService().getVideoIdFromSF();
    final body={
        "_id": id
      };
    final response = await http.delete(
      Uri.parse('https://stats.isporit.com/api/videos/?clubId=$club'),
      body: jsonEncode(body),
      headers: {
        'Content-Type': 'application/json',
        'accept': 'application/json',
        HttpHeaders.authorizationHeader: '$token'
      },
    );
    if(response.statusCode==200){
      SnackBar sucess = SnackBar(
        content: Text(" video deleted successfully  "),
        behavior: SnackBarBehavior.floating,
      );
      ScaffoldMessenger.of(context).showSnackBar(sucess);
      //Navigator.pushNamed(context, route.match);
    }
}

  @override
  void initState(){
    newName = TextEditingController(text: widget.title);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content:
      Container(
        height: 150,
        width: 400,
        child: Form(
          key: _formKey,
          child: Column(
              children: [
                Text(
                  'Are you sure you want to delete this video '
                ),
                Actions(
                  actions: {},
                  child: Row(
                    children:[

                    FlatButton(
                      textColor: Colors.white,
                      onPressed: () {
                        delete();
                  //      getMatchVideoId(widget.title.toString());
                        Navigator.pushNamed(context, route.match);
                      },
                      child: Text('DELETE'),
                      color: Colors.lightGreen,
                    ),
                    FlatButton(
                      textColor: Colors.white,
                      onPressed: () {
                        Navigator.pushNamed(context, route.match);
                      },
                      child: Text('Cancel'),
                      color: Colors.lightGreen,
                    ),
                  ],
                ),
                )]
                ),
        ),

      ),




    );
  }
}


