import 'package:flutter/material.dart';
import 'package:i_matches/Route/routes.dart' as route;
import 'package:google_fonts/google_fonts.dart';

class Constants{
  static const String Rename = 'Rename';
  static const String Delete = 'Delete';
  

  static const List<String> choices = <String>[
    Rename,
    Delete,
    
  ];
}

class MatchesPage extends StatefulWidget {
  const MatchesPage({ Key? key }) : super(key: key);

  @override
  _MatchesPageState createState() => _MatchesPageState();
}

class _MatchesPageState extends State<MatchesPage> {

  void choiceAction(String choice){
    if(choice == Constants.Rename){
        print('Settings');}
    else if(choice == Constants.Delete){
      print('Subscribe');}
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          flexibleSpace: FlexibleSpaceBar(
            title: Text("Manchester United VS Chelsea"),
          ),
          centerTitle: false,
          backgroundColor: Colors.white,
          elevation: 10,),
        
        body: Row(
        children: [
          Container(
          width:180 ,
          height: 270,padding: const EdgeInsets.all(10.0),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          elevation: 5,
          child: InkWell(
            onTap: (){
               Navigator.pushNamed(context, route.video );

                 },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(1),),
                   PopupMenuButton<String>(
                     onSelected: choiceAction,
                     itemBuilder: (BuildContext context){
                       return Constants.choices.map((String choice){
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
                    height: 130,

                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.all(1)),
                  Text(
                    'Chelsea vs Manchester United - Mitemps 1 ',
                    style: GoogleFonts.oswald() ,
                    textAlign: TextAlign.center,
                    ),       
        ], 
        ),
        )
        )
           )
           
            ]
            )
                    );

                    }

                    }