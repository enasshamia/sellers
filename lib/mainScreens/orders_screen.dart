import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../model/order.dart';
import '../widgets/app_bar.dart';
import '../widgets/progress_bar.dart';
import 'order_details_screen.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {

  String? userID;
  List itemID = [];
  List idUser = [];
  List defaultItemList = [];
  List<String> separateItem=[] ;
  String?title ;
  int counter = 0 ;

  void _deleteItem() {
    setState(() {
      separateItem.clear();
    });
  }
  void refresh(){
    setState(() {
      idUser;
    });
  }

  @override
  void initState() {
    super.initState();
    refresh();
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:MyappBar() ,
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection("orders").where("status" ,isEqualTo: "normal").snapshots(),
            builder: (c , snapshot) {
              return snapshot.hasData
                  ? ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (c, index) {
                    Order order = Order.fromJson(
                        snapshot.data!.docs[index].data()! as Map<String , dynamic>
                    );
                    userID = order.userId.toString();
                    if(idUser.contains(userID))
                    {
                      null ;
                    }else{
                        idUser.add(userID);

                    }
                    print(userID.toString()+"aa");
                    print(idUser.toString()+"asasasasas");

                    int i=0;
                    for(i; i<order.itemId!.length ; i++)
                    {
                      String item = order.itemId![i].toString();
                      var quanNumber;
                      List<String> listItemCharacter = item.split(":").toList();
                      quanNumber = listItemCharacter[0].toString();
                      separateItem.add(quanNumber.toString());
                    }

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 200,
                        color: Colors.blueGrey,
                        child: InkWell(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Container(
                              child: Text(order.orderId.toString() + "----" +idUser[index].toString()),
                            ),),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (c)=>OrderDetailScreen(orderId: idUser[index])));
                          },
                        ),

                      ),
                    );
                  }
              )
                  : Center(child: circularProgress(),);
            }
        ),
      ),);
  }
}
