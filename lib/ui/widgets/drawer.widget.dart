import 'package:flutter/material.dart';
class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Colors.white,
                        Colors.blue
                      ]

                  )
              ),
              child: Center(
                child: CircleAvatar(
                  backgroundImage: AssetImage("images/hp2.jpg"),
                  radius:  50,
                ),
              )
          ),
          ListTile(
            title: Text('Tous', style: TextStyle(fontSize: 22), ),
            leading: Icon(Icons.view_module, color: Colors.blue,),
            trailing: Icon(Icons.arrow_right, color: Colors.orange, ),
            onTap: (){
              Navigator.of(context).pop();
              Navigator.pushNamed(context, "/counter");
            },
          ),
          Divider(height: 4, color: Colors.deepOrange,),
          ListTile(
            title: Text('Famille', style: TextStyle(fontSize: 22), ),
            leading: Icon(Icons.family_restroom, color: Colors.blue,),
            trailing: Icon(Icons.arrow_right, color: Colors.orange, ),
            onTap: (){
              Navigator.of(context).pop();
              Navigator.pushNamed(context, "/gallery");
            },
          ),
          Divider(height: 4, color: Colors.deepOrange,),
          ListTile(
            title: Text('Amis', style: TextStyle(fontSize: 22), ),
            leading: Icon(Icons.group, color: Colors.blue,),
            trailing: Icon(Icons.arrow_right, color: Colors.orange, ),
            onTap: (){
              Navigator.of(context).pop();
              Navigator.pushNamed(context, "/meteo");
            },
          ),
          Divider(height: 4, color: Colors.deepOrange,),
          ListTile(
            title: Text('Travail', style: TextStyle(fontSize: 22), ),
            leading: Icon(Icons.business_center, color: Colors.blue,),
            trailing: Icon(Icons.arrow_right, color: Colors.orange, ),
            onTap: (){
              Navigator.of(context).pop();
              Navigator.pushNamed(context, "/travail");
            },
          ),
          Divider(height: 4, color: Colors.deepOrange,),
          ListTile(
            title: Text('Autre', style: TextStyle(fontSize: 22), ),
            leading: Icon(Icons.more_horiz, color: Colors.blue,),
            trailing: Icon(Icons.arrow_right, color: Colors.orange, ),
            onTap: (){
              Navigator.of(context).pop();
              Navigator.pushNamed(context, "/autre");
            },
          ),
          Divider(height: 4, color: Colors.deepOrange,),
        ],
      ),

    );
  }
}


