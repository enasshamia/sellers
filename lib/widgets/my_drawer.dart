import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lhad_elbeit_selleres/authenctication/auth_screen.dart';
import 'package:lhad_elbeit_selleres/global/global.dart';
import 'package:lhad_elbeit_selleres/mainScreens/home_screen.dart';

import '../mainScreens/orders_screen.dart';

class MyDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 25 ,bottom: 10),
            child: Column(
              children: [
                //header drawer
                Material(
                  borderRadius: const BorderRadius.all(Radius.circular(80.0)),
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Container(
                      height: 100,
                      width: 100,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          sharedPreferences!.getString("photoUrl")!
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                Text(
                  sharedPreferences!.getString("name")!,
                  style: const TextStyle(color: Colors.black , fontSize: 20),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12,),
          Container(
            padding: const EdgeInsets.only(top: 1.0),
            child: Column(
              children: const [
              Divider(
                height: 10,
                color: Colors.grey,
                thickness: 2,
              )
            ],),
          ),
          ListTile(
            leading: const Icon(Icons.home, color: Colors.black,),
            title: const Text(
              "Home",
              style: TextStyle(color: Colors.black),
            ),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (c)=>const HomeScreen()));

            },
          ),
          ListTile(
            leading: const Icon(Icons.reorder, color: Colors.black,),
            title: const Text(
              "New order",
              style: TextStyle(color: Colors.black),
            ),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (c)=>const OrdersScreen()));

            },
          ),
          ListTile(
            leading: const Icon(Icons.local_shipping, color: Colors.black,),
            title: const Text(
              "History - orders",
              style: TextStyle(color: Colors.black),
            ),
            onTap: (){},
          ),
          ListTile(
            leading: const Icon(Icons.monetization_on, color: Colors.black,),
            title: const Text(
              "My earnings",
              style:  TextStyle(color: Colors.black),
            ),
            onTap: (){},
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app, color: Colors.black,),
            title: const Text(
              "Sign out",
              style: TextStyle(color: Colors.black),
            ),
            onTap: (){
              firebaseAuth.signOut().then((value){
                Navigator.push(context, MaterialPageRoute(builder: (c)=>const AuthScreen()));
              });

            },
          ),
        ],
      ),
    );
  }
}
