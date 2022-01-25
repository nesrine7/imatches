
import 'dart:convert';

class Manager{
  String? title;
  String? token;
  User? user;

  Manager({this.token,this.title,this.user});

   factory Manager.fromJson(Map<String,dynamic> parsedJson){
     return Manager(
         token: parsedJson['token'],
         user: User.fromJson(parsedJson['user']),
         title: parsedJson['title']
     );
  }
}

class Game{
  String? matchId;
  Game({this.matchId});
  factory Game.fromJson(Map<String,dynamic> json){
    return
      Game(
          matchId: json['_id']
      );
  }
}

class User{
  String? clubId;
  Game? game;
  User({this.clubId,this.game});
  factory User.fromJson(Map<String,dynamic>parsedJson){
    return User(
        clubId: parsedJson['club'],
        game: Game.fromJson(parsedJson['games'])
    );
  }
}



