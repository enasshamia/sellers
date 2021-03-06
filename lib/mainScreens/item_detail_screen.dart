import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../model/items.dart';
import '../widgets/app_bar.dart';

class ItemDetailScreen extends StatefulWidget {

    final Items? model;
    ItemDetailScreen({this.model});
  @override
  _ItemDetailScreenState createState() => _ItemDetailScreenState();
}


class _ItemDetailScreenState extends State<ItemDetailScreen> {

  TextEditingController counter = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:MyappBar(sellerUid : widget.model!.sellerUid),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(widget.model!.thumbnailUrl.toString() , width: MediaQuery.of(context).size.width * 50, height: 180,),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.model!.title.toString(),
              style: const TextStyle(fontWeight: FontWeight.bold , fontSize: 20.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.model!.description.toString(),
              textAlign: TextAlign.justify,
              style: const TextStyle(fontWeight: FontWeight.normal , fontSize: 14.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
             "\$" + widget.model!.price.toString(),
              style: const TextStyle(fontWeight: FontWeight.bold , fontSize: 30.0),
            ),
          ),

          const SizedBox(height: 10,),

          Center(
            child: InkWell(
              onTap: ()
              {

              },
              child: Container(
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
                width: MediaQuery.of(context).size.width - 16,
                height: 50,
                child: const Center(
                  child: Text("delete this item" , style: TextStyle(fontSize: 16),),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
