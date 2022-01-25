import 'package:flutter/material.dart';
import 'drawer.dart';
import 'matches_tab.dart';

class ManagerDashboard extends StatelessWidget {
  const ManagerDashboard({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
         appBar: AppBar(
            elevation: 20,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/appbarbackground.jpg'),
                  fit: BoxFit.cover,
                ), 
              ),
            ),
            bottom: TabBar(
              unselectedLabelColor: Colors.black,
              indicatorSize: TabBarIndicatorSize.tab,       
              tabs: [
                Tab(
                  child: Align(                        
                    alignment: Alignment.center,
                    child: Text(
                      "Matches",
                      style: TextStyle(color: Colors.white),
                      ),
                      ),
                    ),
                Tab(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Highlights",
                      style: TextStyle(color: Colors.white),
                      ),
                  ),
                ),
              ],
 ),      
      ),
                drawer: MyDrawer(),
                body: TabBarView(children: [
              Matches(),
              Matches(),
              ]
            ),
     
    ),
    );
  }
}