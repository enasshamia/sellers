
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lhad_elbeit_selleres/mainScreens/items_screen.dart';
import 'package:lhad_elbeit_selleres/model/menus.dart';

import '../global/global.dart';

class InfoDesignWidget extends StatefulWidget {

  Menus? model ;
  BuildContext? context ;

  InfoDesignWidget({this.model , this.context});
  @override
  _InfoDesignWidgetState createState() => _InfoDesignWidgetState();
}



class _InfoDesignWidgetState extends State<InfoDesignWidget> {

  deleteMenu(String menuId){
    FirebaseFirestore.instance.collection("sellers").doc(sharedPreferences!.getString("uid")).collection("menus").doc(menuId).delete();
    
    Fluttertoast.showToast(msg: "menu Deleted");

  }

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: ()
      {
        Navigator.push(context, MaterialPageRoute(builder: (c)=>  ItemsScreen(model:widget.model)));
      },
      splashColor: Colors.amber,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          height: 200,
          width: MediaQuery.of(context).size.width * 70,
          decoration:
           BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(15, 5),
              blurRadius: 30,
            )
          ]),
          child: Column(
            children: [
              Container(
                height: 120,
                width: MediaQuery.of(context).size.width*70,
                decoration:
                BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(15, 5),
                        blurRadius: 30,
                      )
                    ]),
                child: Image.network(widget.model!.thumbnailUrl!,
                  height: 120,
                  width: 120,
                  fit: BoxFit.fitWidth,


                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                    widget.model!.menuTittle!,

                  ),),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: IconButton(
                      onPressed:()
                      {
                          deleteMenu(widget.model!.menuID!);
                      } ,
                      icon:Icon(Icons.delete_sweep,color: Colors.pinkAccent,),
                    ),
                    ),
                ],
              ),


            ],
          ),
        ),
      ),
    );
  }
}
