import 'package:flutter/material.dart';
import 'package:i_matches/Screens/Login/login_page.dart';
import 'package:i_matches/Screens/Manager/manager_dashboard.dart';
import 'package:i_matches/Screens/Manager/matches_page.dart';
import 'package:i_matches/Screens/Manager/video.dart';
import 'package:i_matches/Screens/Manager/my_team.dart';


  const String login = '/Login';
  const String manager = '/Manager'; 
  const String member = '/Member';
  const String match ='/Match';
  const String video='/video';
  const String myTeam='/my_team';

  Route<dynamic> controller(RouteSettings settings){
    switch(settings.name){
      case login:
        return MaterialPageRoute(builder: (context) => LoginPage());
      case manager:
        return MaterialPageRoute(builder: (context) => ManagerDashboard());
      //case member:
        //return MaterialPageRoute(builder: (context) => MemberDashboard());
      case match: 
        return MaterialPageRoute(builder: (context) => MatchesPage() );
      case video:
        return MaterialPageRoute(builder: (context) => VideoPage()  );
      case myTeam:
        return MaterialPageRoute(builder: (context) => MyTeam()  );
      default:
        throw('this route name does not exist');
  }

}