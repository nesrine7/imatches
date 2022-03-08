
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:i_matches/Route/routes.dart'as route;
import 'package:i_matches/Screens/Manager/model_manager.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;




class LoginPageMemeber extends StatefulWidget {
  const LoginPageMemeber({ Key? key }) : super(key: key);

  @override
  _LoginPageMemeberState createState() => _LoginPageMemeberState();
}

class _LoginPageMemeberState extends State<LoginPageMemeber> {

  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late SharedPreferences prefs;
  late bool _isLoading ;
  final _formKey=GlobalKey<FormState>();




  @override
  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  List data = [];
  String? ClubName;
  Future<String>fetchClub() async {
    final response = await http.get(
      Uri.parse('https://dev.isporit.com/api/clubs/all?hasWebsite=true'),
      headers: {
        'accept': 'application/json',
      },
    );
      var body = jsonDecode(response.body);
      setState(() {
        data=body;
      });
      return "sucess";
    }
  @override
  void initState(){
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
    this.fetchClub();
  }
  Future<bool> setToken(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('token', value);
  }

  login(String email,password) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final body =  {
      "env":"prod",
      "email" : email,
      "password": password};
    var response = await http.post(Uri.parse('https://stats.isporit.com/api/auth/login'),
      headers:{
      "content-Type" : "application/json",
        "accept" : "application/json"},
      body: jsonEncode(body),
    );
    if (response.statusCode==200){
      var token = Manager.fromJson(json.decode(response.body)).token;
      setToken(token!);
      setState(() {
        _isLoading=false;
        SnackBar sucess = SnackBar(
          content: Text("Welcome Back "),
          behavior: SnackBarBehavior.floating,
        );
        ScaffoldMessenger.of(context).showSnackBar(sucess);

      });

    }
    else {
      SnackBar error = SnackBar(content: Text("Wrong Email or password"));
      ScaffoldMessenger.of(context).showSnackBar(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/Login.png'), fit: BoxFit.cover),
        ),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            floatingActionButton: FloatingActionButton(onPressed: (){ fetchClub();

    },),

            body: Stack(
                children: [

                  SingleChildScrollView(
                    child: Container(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.20),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DropdownButton(
                                 hint: Text("select your club"),
                                items: data.map((item) {
                                  var urlI= item['logo'].toString();
                                  return  DropdownMenuItem(
                                    child: Row(
                                    children:[
                                      Image.network("https://stats.isporit.com/api/isporit"+ urlI+"?env=prod",
                                        errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                          return Icon(Icons.error);
                                        },
                                        height: 40,
                                        width: 40,
                                      ),
                                  Text(item['title']),

                                    ] ,

                                    ),
                                    value: item['_id'].toString(),
                                  );
                                }).toList(),
                                onChanged: (String? newVal) {
                                  setState(() {
                                    ClubName = newVal ;
                                  });
                                },
                                value: ClubName,
                              ),
                              Container(

                                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      children: [
                                        SizedBox(height: 30),
                                        TextFormField(
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return 'Please enter some text';
                                            }
                                            return null;
                                          },
                                          controller: _emailController,
                                          decoration: InputDecoration(
                                              prefixIcon: Icon(Icons.mail),
                                              hintText: "Email",
                                              border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(10)
                                              )
                                          ),
                                        ),
                                        SizedBox(height: 30),
                                        TextFormField(
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return 'Please enter some text';
                                            }
                                            return null;
                                          },
                                          obscureText: true,
                                          controller: _passwordController,
                                          decoration: InputDecoration(
                                              prefixIcon: Icon(Icons.vpn_key),
                                              hintText: "Password",
                                              border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(10)
                                              )
                                          ),
                                        ),
                                        SizedBox(height: 30),
                                        MaterialButton(
                                          onPressed: () {
                                            if(_formKey.currentState!.validate()) {
                                              setState(() {
                                                _isLoading = true;
                                              });
                                              login(_emailController.text, _passwordController.text);
                                            }
                                          },
                                          height: 60,
                                          minWidth: double.infinity,
                                          color: Theme.of(context).primaryColor,
                                          textColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: Text(
                                              "Login ",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold
                                              )
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                              )
                            ])
                    ),
                  )
                ])
        )
    );
  }
}
class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
              mainAxisAlignment:MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/logoindexpage.png',
                  fit: BoxFit.contain,
                  height: 30,
                ),
              ]
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
      ),
    );

  }
}