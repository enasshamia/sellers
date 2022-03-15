import 'package:flutter/material.dart';
class MyappBar extends StatefulWidget with PreferredSizeWidget{

  final PreferredSizeWidget? bottom;
  final String? sellerUid;
  MyappBar({this.bottom , this.sellerUid});
  
  @override
  _MyappBarState createState() => _MyappBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => bottom==null?Size(56, AppBar().preferredSize.height):Size(56, 80+AppBar().preferredSize.height);
}

class _MyappBarState extends State<MyappBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
        flexibleSpace: Container(
          decoration:  const BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.cyan,
              Colors.amber,
            ],
              begin: FractionalOffset(0.0, 0.0),
              end:  FractionalOffset(1.0, 0.0),
              stops: [0.0 , 1.0],
              tileMode: TileMode.clamp,
            ),
          ),
        ),
        leading:  IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "iFood",
          style: TextStyle(fontSize: 30 , ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: (){
                },
              ),
              Positioned(child: Stack(
                children:  [
                  const Icon(
                    Icons.brightness_1,
                    color: Colors.green,
                  ),
                ],
              )),
            ],
          ),
        ],
      );
  }
}
