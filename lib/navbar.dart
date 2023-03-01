
import 'package:flutter/material.dart';
import 'details.dart';

class navbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(//creating a row of children
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(accountName: Text('User_name'),
              accountEmail: Text('user@gmail.com'),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(
                  child: Image.network('https://oflutter.com/wp-content/uploads/2021/02/boy-profile.png',
                    fit: BoxFit.cover,
                    width: 90,
                    height: 90,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.lightBlue,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                        'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg')),
              ),
            ),

            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () => null,
            ),
            ListTile(
              leading: Icon(Icons.description),
              title: Text('AboutUs'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder:(context) => DetailPage()));
              },
            ),
            // ListTile(
            //   leading: Icon(Icons.person),
            //   title: Text('Friends'),
            //   onTap: () => null,
            // ),

            Divider(),
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text('Favorites'),
              trailing: Icon(Icons.arrow_forward),
              onTap: () => null,
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () => null,
            ),

            Divider(),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Exit'),
              onTap: () => null,
            ),

          ]
      ),
    );


  }
}