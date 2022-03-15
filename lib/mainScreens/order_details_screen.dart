import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import '../model/user.dart';
import '../widgets/progress_bar.dart';
import '../widgets/shipment_address_desgin.dart';
import '../widgets/status_banner.dart';

class OrderDetailScreen extends StatefulWidget {

  final String? orderId ;

  OrderDetailScreen({this.orderId});

  @override
  _OrderDetailScreenState createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {

  String orderStatus = "" ;
  String address = "" ;
  String sellerId = "";
  String orderBy = "" ;
  String title = "" ;
  String price = "" ;
  String thumbnailUrl = "" ;
  String? lng , lat ;
  List?itemId =[];
  List<String> separateExtras=[] ;
  List<String> separateItem=[] ;
  List<String> itemQuan=[] ;


  getOrderInfo()
  {
      FirebaseFirestore.instance.collection("orders").doc(widget.orderId!).get().then((DocumentSnapshot)
     {
      orderStatus = DocumentSnapshot.data()!["status"].toString();
      orderBy = DocumentSnapshot.data()!["orderBY"].toString();
      sellerId = DocumentSnapshot.data()!["sellerUid"].toString();
      itemId = DocumentSnapshot.data()!["productId"];
     }
    );
    }


  @override
  void initState() {
    super.initState();
    getOrderInfo();
    getItemList();
    getItemQuan();
  }
  
  getItemList(){
    int i=0;
    for(i; i<itemId!.length ; i++)
    {
      String item = itemId![i].toString();
      var quanNumber;
      List<String> listItemCharacter = item.split(":").toList();
      quanNumber = listItemCharacter[0].toString();
      separateItem.add(quanNumber.toString());
    }
    return separateItem;
  }

  getItemQuan(){
    int i=0;
    for(i; i<itemId!.length ; i++)
    {
      String item = itemId![i].toString();
      var quanNumber;
      List<String> listItemCharacter = item.split(":").toList();
      quanNumber = listItemCharacter[1].toString();
      itemQuan.add(quanNumber.toString());
    }
    return itemQuan;

  }

  getExtras(){
    int i=0;
    for(i; i<itemId!.length ; i++)
    {
      String item = itemId![i].toString();
      var quanNumber;
      List<String> listItemCharacter = item.split(":").toList();
      quanNumber = listItemCharacter[2].toString();
      separateExtras.add(quanNumber.toString());
    }
    return separateExtras;

  }






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance.collection("orders").doc(widget.orderId!).get(),
          builder: (c,snapshot){
              Map? dataMap;
               if(snapshot.hasData){
               dataMap = snapshot.data!.data()! as Map<String , dynamic>;
               orderStatus = dataMap["status"].toString();
               address = dataMap["addressID"].toString();
               lat = dataMap["lat"].toString() ;
               lng = dataMap["lng"].toString();
              }
              return snapshot.hasData ? Container(
                child: Column(
                  children: [
                      StatusBanner(
                        status: dataMap!["isSuccess"],
                        orderStatus: orderStatus ,
                      ),
                    const SizedBox(height: 20.0,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text( "\$ " + "السعر الكلي" + dataMap["totalAmount"].toString(),
                        style: const TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text( "رقم الوصل : " + widget.orderId!,
                        style: const TextStyle(fontSize: 15 , ),),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(DateFormat("dd MMMM , yyyy - hh:mm aa").format(DateTime.fromMicrosecondsSinceEpoch(int.parse(dataMap["orderId"]))) + " : تم الطلب في ",
                        style: const TextStyle(fontSize: 15 , ),),
                      ),
                    ),
                    const Divider(thickness: 4,),
                    Container(
                      height:400,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: itemId!.length,
                          itemBuilder: (c,index1){
                          List<String> items = getItemList();
                          List<String> getQuan = getItemQuan();
                          List<String> getExtra = getExtras();
                          return
                            FutureBuilder<DocumentSnapshot>(
                                future: FirebaseFirestore.instance.collection("items").doc(items[index1]).get(),
                                builder:  (c, snap) {
                                  Map? dataMap;
                                  if (snap.hasData) {
                                    dataMap = snap.data!.data()! as Map<String, dynamic>;
                                    title = dataMap["title"].toString();
                                    thumbnailUrl = dataMap["thumbnailUrl"].toString();
                                    price = dataMap["price"].toString();

                                  }
                                  return snap.hasData?
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    margin: EdgeInsets.all(10),
                                    height:140,
                                    decoration:  const BoxDecoration(
                                      gradient: LinearGradient(colors: [
                                        Colors.black12,
                                        Colors.white54,
                                      ],
                                        begin: FractionalOffset(0.0, 0.0),
                                        end:  FractionalOffset(1.0, 0.0),
                                        stops: [0.0 , 1.0],
                                        tileMode: TileMode.clamp,
                                      ),
                                    ),
                                    child: Row(

                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            SizedBox(height: 12,),
                                            Text(title , textAlign: TextAlign.end,),
                                            SizedBox(height: 2,),

                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                              const Text("₪", textAlign: TextAlign.end ,style: TextStyle(color:Colors.black , fontSize: 16 ,),),
                                              const SizedBox(width: 2,),
                                              Text(price , textAlign: TextAlign.end,),
                                            ],),
                                            SizedBox(height: 2,),

                                            Row(
                                              children: [
                                                Text(
                                                  getQuan[index1].toString(),
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                const Text("x" , style: TextStyle(color: Colors.black , fontSize: 14) ,),


                                              ],),
                                            Text(getExtra[index1].toString() ,),
                                          ],
                                        ),
                                        SizedBox(width: 8,),
                                        ClipRRect(
                                          borderRadius:  BorderRadius.circular(2),
                                          child:Image.network(thumbnailUrl, width: 120,height: 100, fit: BoxFit.fill,), ),

                                      ],
                                    ),

                                  )
                                      :Container(child: circularProgress(),);
                                }
                            );
                          }

                      ),
                    ),

                    const Divider(thickness: 4,),
                    FutureBuilder<DocumentSnapshot>(
                        future: FirebaseFirestore.instance.collection("users").doc(orderBy).get(),
                        builder: (c , snapshot){
                          getItemList();
                          return snapshot.hasData
                              ?ShipmentDesgin(
                            model: User.fromJson(
                              snapshot.data!.data()! as Map<String ,dynamic>,
                            ) ,
                            city:   address,
                            orderStatus:orderStatus,
                            lat:lat,
                            lng:lng,
                            orderId:widget.orderId,
                            sellerId:sellerId,
                            orderBy:orderBy,

                          )
                              :Center(child: circularProgress(),);
                        }
                    ),


                  ],
                ),
              ) : Center(child: circularProgress(),);
          }
        ),
      ),
    );
  }
}
