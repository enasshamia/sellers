import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lhad_elbeit_selleres/global/global.dart';
import 'package:lhad_elbeit_selleres/model/items.dart';
import 'package:lhad_elbeit_selleres/model/seconds.dart';
import 'package:lhad_elbeit_selleres/uploadScreens/seconds_upload.dart';
import 'package:lhad_elbeit_selleres/widgets/my_drawer.dart';
import 'package:lhad_elbeit_selleres/widgets/progress_bar.dart';
import 'package:lhad_elbeit_selleres/widgets/secondes_design.dart';
import 'package:lhad_elbeit_selleres/widgets/text_widget.dart';

class SecondsScreen extends StatefulWidget {
  final Seconds? secondsModel ;
  final Items? model ;
  SecondsScreen({this.model , this.secondsModel});

  @override
  _SecondsScreenState createState() => _SecondsScreenState();
}

class _SecondsScreenState extends State<SecondsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        title: Text(
          sharedPreferences!.getString("name")!,
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.library_add),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (c) =>  SecondsUploadScreen(model:widget.model)));
            },
          )
        ],
      ),
      drawer: MyDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(pinned: true , delegate: TextWidgetStyle(title: widget.model!.title.toString())),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection("sellers").doc(sharedPreferences!.getString("uid")).collection("menus").doc(widget.model!.menuID).collection("items").doc(widget.model!.itemID).collection("second").orderBy("publishedDate" , descending: true).snapshots(),
            builder: (context, snapshot)
            {
              return !snapshot.hasData
                  ? SliverToBoxAdapter(child: Center(child: circularProgress(),),
              )
                  :SliverStaggeredGrid.countBuilder(
                crossAxisCount: 1,
                staggeredTileBuilder: (c) =>  const StaggeredTile.fit(1),
                itemBuilder: (context , index)
                {
                  Seconds model = Seconds.fromJson(
                      snapshot.data!.docs[index].data()! as Map<String , dynamic>
                  );
                  return SecondsDesign(
                    model: model,
                    context: context,
                  );
                },
                itemCount: snapshot.data!.docs.length,
              );
            },
          ),



        ],
      ),

    );
  }
}
