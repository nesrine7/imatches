class Manager{
  List? score;
  String? token;
  User? user;
  Manager({this.token,this.user,this.score});

   factory Manager.fromJson(Map<String,dynamic> parsedJson){
     return Manager(
         token: parsedJson['token'],
         user: User.fromJson(parsedJson['user']),
         score: parsedJson['score'],

     );
  }
}
class Log{
  String? thumbnail;
  String? video;

  Log({this.video,this.thumbnail});
  factory Log.fromJson(Map<String,dynamic> json){
    return Log(
      video: json['video'],
      thumbnail: json['thumbnail'],
    );
  }
  }
  class Video{
  Log? l;
  String? title;
  Video({this.l,this.title});
  factory Video.fromJson(Map<String,dynamic> parsedJson){
    return Video(

        l: Log.fromJson(parsedJson['logs']),
      title: parsedJson['title'],
    );
  }
  }





class User{
  String? clubId;
  User({this.clubId});
  factory User.fromJson(Map<String,dynamic>json){
    return User(
        clubId: json['club'],
         );
  }
}

class Game{
  int? matchId;

  Game({this.matchId});
  factory Game.fromJson(Map<String,dynamic> json){
    return
      Game(
          matchId: json['_id'],
      );
  }
}
class Match{
  String? matchId;
  Match({this.matchId});
  factory Match.fromJson(Map<String,dynamic> json){
    return Match(
        matchId: json['_id']
    );
  }
}

class Member{
  List<Spot>? spots;
  Member({this.spots});
  factory Member.fromJson(Map<String,dynamic>parsedJson){
  var list= parsedJson['spots'] as List;
  List<Spot> spot= list.map((i)=>Spot.fromJson(i)).toList();
  return Member(
    spots:spot);

  }
}

class Spot{
 UserData? userdata;
  String? role;
  String? mail;
  Spot({this.role,this.userdata,this.mail});
  factory Spot.fromJson(Map<String,dynamic> parsedJson){
    return Spot(
      role: parsedJson['role'],
      mail: parsedJson['invitationEmail'],
      userdata: UserData.fromJson(parsedJson['userData'])
    );
  }
}

class UserData{
  String? profilePicture;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? date;
  UserData({this.firstName,this.lastName,this.profilePicture,this.phoneNumber,this.date});

  factory UserData.fromJson(Map<String,dynamic> json){
    return UserData(
      firstName: json['firstName'],
      lastName: json['lastName'],
      profilePicture: json['profilePicture'],
      phoneNumber: json['phoneNumber'],
      date: json['birthday'],

    );
  }
}



