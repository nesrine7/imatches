

import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:i_matches/Route/routes.dart' as route;
import 'package:http/http.dart' as http;


import 'package:shared_preferences/shared_preferences.dart';

class MatchService {

  Future<bool> setMatchId(String value)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('matchid', value);
  }
  Future<bool> setNewVideoMatchName(String value) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('newVideoName', value);
  }
  Future<bool> setMatchName(String value)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('matchname', value);
  }
  Future<bool> setMatchTitle(String value)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('matchTitle', value);
  }
  Future<bool> setMatchvideo(String value)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('video', value);
  }
  Future<bool> setMatchvideoId(String value)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('videoId', value);
  }



  getTokenFromSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    return token;
  }
  getVideoIdFromSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? videoId = prefs.getString('videoId');
    return videoId;
  }
  getNewVideoName()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? newName = prefs.getString('newVideoName');
    return newName;
  }

  getClubFromSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? club = prefs.getString('clubid');
    return club;
  }

  getMatchFromSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? match = prefs.getString('matchid');
    return match;
  }
  getMatchNameFromSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? match = prefs.getString('matchname');
    return match;
  }



//fetch the list of videos of one match
  Future<List<String>> fetchMatchVideo() async {
    String token = await getTokenFromSF();
    String club = await getClubFromSF();
    String match = await getMatchFromSF();
    final response = await http.get(
      Uri.parse('https://stats.isporit.com/api/videos/match/$match?clubId=$club'),
      headers: {
        'accept': 'application/json',
        HttpHeaders.authorizationHeader: '$token',
      },
    );
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);

      List<String> listVid = [];
      data.forEach((element) {
        Map obj = element;
        String title = obj['title'];
        listVid.add(title);
      });
      return listVid;
    }
    else {
      throw Exception("Fail to fetch data ");
    }
  }

   getMatchId(String title)async{
    String token = await getTokenFromSF();
    String club = await getClubFromSF();
    final response = await http.get(
      Uri.parse('https://stats.isporit.com/api/matches/?clubId=$club'),
      headers: {
        'accept': 'application/json',
        HttpHeaders.authorizationHeader: '$token',
      },
    );
    var data = jsonDecode(response.body) ;
    String matchVideo="";
    for (var i=0; i<data.length;i++){
      if(data[i]['title']==title){
        matchVideo=data[i]['_id'];
        setMatchId(matchVideo);
      }
    }
  }



//fetch a video of a match
  Future<List<String>> fetchVideo() async {
    String token = await getTokenFromSF();
    String club = await getClubFromSF();
    String match = await getMatchFromSF();

    final response = await http.get(
      Uri.parse('https://stats.isporit.com/api/videos/match/$match?clubId=$club'),
      headers: {
        'accept': 'application/json',
        HttpHeaders.authorizationHeader: '$token',
      },
    );
    if (response.statusCode == 200) {
      List data2 = jsonDecode(response.body);
      List<String> list2 = [];
      data2.forEach((i) {
        Map obj = i;
        String v = obj['logs']['video'];
        list2.add(v);
      });
      return list2;
    }
    else {
      throw Exception("Fail to fetch data ");
    }
  }

//fetch the matches
  Future<List<String>> fetchManager() async {
    String token = await MatchService().getTokenFromSF();
    String club = await MatchService().getClubFromSF();
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
//fetch the scores of matches

  Future<List<String>> fetchScore() async {
    String token = await MatchService().getTokenFromSF();
    String club = await MatchService().getClubFromSF();
    final response = await http.get(
      Uri.parse('https://stats.isporit.com/api/matches/?clubId=$club'),
      headers: {
        'accept': 'application/json',
        HttpHeaders.authorizationHeader: '$token',
      },
    );
    if (response.statusCode == 200) {
      List s = jsonDecode(response.body);
      var ListScore;
      List<String> Lscore = [];
      s.forEach((element) {
        Map obj = element;
        List score = obj['score'];
        ListScore= score.join("");
        Lscore.add(ListScore);
      });
      return Lscore;
    }
    else {
      throw Exception("Fail to fetch data ");
    }
  }





}

