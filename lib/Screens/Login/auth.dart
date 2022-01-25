
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:i_matches/Route/routes.dart'as route;
import 'package:i_matches/Screens/Manager/model_manager.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;




class Login extends StatefulWidget {
  const Login({ Key? key }) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late SharedPreferences prefs;
  late bool _isLoading ;
  final _formKey=GlobalKey<FormState>();


  @override
  void initState(){
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  Future<bool> setToken(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('token', value);
  }

  Future<bool> setClub(String value)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('clubid', value);
  }

  login(String email,password) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final body =  {
      "env":"prod",
      "email" : email,
      "password": password};
      var response = await http.post(Uri.parse('https://stats.isporit.com/api/auth/login'),
        headers:{ "content-Type" : "application/json",
        "accept" : "application/json"},
        body: jsonEncode(body),
    );
    if (response.statusCode==200){
      var token = Manager.fromJson(json.decode(response.body)).token;
      var club = Manager.fromJson(json.decode(response.body)).user?.clubId;
      setToken(token!);
      setClub(club!);
      setState(() {
        _isLoading=false;
        Navigator.pushNamed(context, route.manager );
      });
      SnackBar sucess = SnackBar(
          content: Text("Welcome Back "),
        behavior: SnackBarBehavior.floating,
      );
      ScaffoldMessenger.of(context).showSnackBar(sucess);
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
        body: Stack(
            children: [
        SingleChildScrollView(
        child: Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
          bottom: TabBar(
              unselectedLabelColor: Colors.black,
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.purple, Colors.blue]),
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.blueGrey
              ),
              tabs: [
                Tab(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text("Managers"),
                  ),
                ),
                Tab(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text("Members"),
                  ),
                ),
              ]),
        ),
        body: TabBarView(children: [
          Login(),
          Login(),
        ]),
      ),
    );

  }
}