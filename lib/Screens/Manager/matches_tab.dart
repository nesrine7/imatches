import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:i_matches/Route/routes.dart'as route;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'model_manager.dart';

class Matches extends StatefulWidget {
  const Matches({ Key? key }) : super(key: key);
  @override
  _MatchesState createState() => _MatchesState();
}

class _MatchesState extends State<Matches> {
  String? nomMatch;
  Future<List<Match>>? futureMatch;
  List<Match> listMatch = [];
  String url = "https://stats.isporit.com/api/matches";

  getTokenFromSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    return token;
  }

  getClubFromSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? club = prefs.getString('clubid');
    return club;
  }

  Future<List<String>> fetchManager() async {
    String token = await getTokenFromSF();
    String club = await getClubFromSF();
    final response = await http.get(
      Uri.parse('https://stats.isporit.com/api/matches/?clubId=$club'),
      headers: {
        'accept': 'application/json',
        HttpHeaders.authorizationHeader: '$token',
      },
    );
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      List<String> listMatch = [];
      data.forEach((element) {
        Map obj = element;
        String title = obj['title'];
        listMatch.add(title);
      });
      return listMatch;
    }
    else {
      throw Exception("Fail to fetch data ");
    }
  }

  Future<List<String>> fetchGame() async {
    String token = await getTokenFromSF();
    String club = await getClubFromSF();
    final response = await http.get(
      Uri.parse('https://stats.isporit.com/api/matches/?clubId=$club'),
      headers: {
        'accept': 'application/json',
        HttpHeaders.authorizationHeader: '$token',
      },
    );
    if (response.statusCode == 200) {
      var Matchlist = User.fromJson(json.decode(response.body)).game?.matchId;
      //List<String> dataMatch = List<String>.from(Matchlist);
      print(Matchlist);
      List data = jsonDecode(response.body);
      List<String> listMatch = [];
      data.forEach((element) {
        Map obj = element;
        String title = obj['title'];
        listMatch.add(title);
      });
      return listMatch;
    }
    else {
      throw Exception("Fail to fetch data ");
    }
  }



  @override
  void initState() {
    super.initState();
    //futureMatch = fetchManager()   ;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchManager(),
        builder:
            (BuildContext context,
            AsyncSnapshot<List<String>> projectSnap) {
          if (projectSnap.connectionState == ConnectionState.none ||
              !projectSnap.hasData) {
            return const Text("NO DATA");
          }
          return Scaffold(
            appBar: AppBar(
            ),
            floatingActionButton: FloatingActionButton(onPressed: () { fetchGame(); },

            ) ,
            body: GridView.builder(
                itemCount: projectSnap.data!.length,
                itemBuilder: (context, index) {
                  return Row(
                  children:[
                    Container(
                    width: 180,
                    height: 280, padding: const EdgeInsets.all(5.0),
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                      elevation: 8,
                      child: InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, route.match );
                         },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Stack(
                           alignment: Alignment.centerRight,
                            children: [
                              Image.asset('assets/match1.png',
                                height: 120,
                          ),
                       ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0)),
                        Text(projectSnap.data![index],
                        style: TextStyle(
                            //fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: Colors.black
                        ),
                        ),
                          Text(
                            '2021 Liga ',
                            //style: GoogleFonts.oswald() ,
                            textAlign: TextAlign.center,

                          ),
                          Wrap(
                              children: [
                                Image.asset(
                                  'assets/equipe2.png',
                                  width: 40,
                                  height: 40,
                                ),
                                Container(
                                  margin: EdgeInsets.all(15),
                                  child:  Text(' 2 - 0 '),
                                ),
                                Image.asset(
                                  'assets/equipe1.png',
                                  height: 40,
                                  width: 40,
                                ),
                              ]
                          )
                        ],
                      ),
                    ),
                  )
                  )
                    ]);
                },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 130 / 200,
                                  crossAxisCount: 2,),
            //drawer: const MonDrawer(),

            )
              );
        });
  }
}






