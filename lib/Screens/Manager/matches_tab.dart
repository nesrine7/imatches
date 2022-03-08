import 'package:google_fonts/google_fonts.dart';
import 'package:i_matches/Screens/Manager/match_service.dart';
import 'package:i_matches/Route/routes.dart'as route;
import 'package:flutter/material.dart';


class Matches extends StatefulWidget {
  const Matches({ Key? key }) : super(key: key);
  @override
  _MatchesState createState() => _MatchesState();
}

class _MatchesState extends State<Matches> {

  @override
  void initState() {
    super.initState();
  }

  late List<String> listMatch;
  void getStringListMatch() async {
    var L= await MatchService().fetchManager();
    listMatch = L;
  }
  late List<String> listScore;
  void getStringListScore() async {
    var L= await MatchService().fetchScore();
    listScore = L;
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: MatchService().fetchManager(),
        builder:
            (BuildContext context,
            AsyncSnapshot<List<String>> projectSnap) {
          if (projectSnap.connectionState == ConnectionState.none ||
              !projectSnap.hasData) {
            return const Text("You still have no matches yet");
          }
          return Scaffold(
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
                         MatchService().getMatchId(projectSnap.data![index]);
                          Navigator.pushNamed(context, route.match);
                          MatchService().setMatchTitle(projectSnap.data![index]);

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

                          Wrap(
                              children: [
                                Image.asset(
                                  'assets/equipe2.png',
                                  width: 40,
                                  height: 40,
                                ),
                                FutureBuilder(
                                  future:MatchService().fetchScore(),
                                  builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
                                    if (snapshot.connectionState == ConnectionState.none ||
                                        !snapshot.hasData) {
                                      return const Text("not defined");
                                    }
                                    return
                                    Container(
                                      child : Padding(
                                          padding: const EdgeInsets.all(10.0),
                                    child : Text(
                                    snapshot.data![index][0]+'-'+snapshot.data![index][1],
                                    style: GoogleFonts.oswald() ,
                                    textAlign: TextAlign.center,
                                    )
                                    )
                                    );
                                 },
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
            )
              );
        });
  }
}








