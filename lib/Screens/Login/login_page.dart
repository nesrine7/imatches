
import 'package:flutter/material.dart';
import 'auth.dart';

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
          resizeToAvoidBottomInset: false ,
            appBar: AppBar(
              title: Image.asset('assets/logoindexpage.png'),
              centerTitle: true,
              backgroundColor: Colors.white,
              elevation: 0,
              bottom: const TabBar(
                  unselectedLabelColor: Colors.black,
                  indicatorSize: TabBarIndicatorSize.tab,
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
            body: const TabBarView(children: [
              Login(),
              Login(),
            ],
            
            
            ),
          ),
       );

    } 
  }