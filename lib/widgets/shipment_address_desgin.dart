import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lhad_elbeit_selleres/mainScreens/order_details_screen.dart';
import 'package:lhad_elbeit_selleres/mainScreens/orders_screen.dart';
import '../mainScreens/home_screen.dart';
import '../model/user.dart';

class ShipmentDesgin extends StatefulWidget {

   final User? model ;
   final String? city;
   final String? orderStatus;
   final String? lat;
   final String? lng;
   final String? orderId ;
   final String? sellerId ;
   final String? orderBy ;


   ShipmentDesgin({this.model , this.city ,this.orderStatus,  this.lat,  this.lng , this.orderId , this.sellerId , this.orderBy,});

  @override
  State<ShipmentDesgin> createState() => _ShipmentDesginState();
}

class _ShipmentDesginState extends State<ShipmentDesgin> {

  confirmOrder() {
    FirebaseFirestore.instance.collection("orders").doc(widget.orderId).update({
      "status": "ready",

    });
  }

    @override
    Widget build(BuildContext context) {
      return Column(
        children: [
          const Text('ـفاصيل الطلب'),
          const SizedBox(height: 20.0,),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 5),
            width: MediaQuery
                .of(context)
                .size
                .width,
            child: Table(
              children: [
                TableRow(
                    children: [
                      Text(widget.model!.userrName!),
                      Text("الأسم"),

                    ]
                ),
                TableRow(
                    children: [
                      Text(widget.model!.phone!),
                      Text("رقم الهاتف"),

                    ]
                ),
              ],
            ),
          ),
          const SizedBox(height: 20.0,),
          Text(widget.city!, textAlign: TextAlign.justify,),
          Padding(padding: const EdgeInsets.all(8.0),
            child: Center(
              child: InkWell(
                onTap: () {
                  confirmOrder();
                  Navigator.push(
                      context, MaterialPageRoute(builder: (c) => OrdersScreen()));
                },
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Colors.cyan,
                      Colors.amber,
                    ],
                      begin: FractionalOffset(0.0, 0.0),
                      end: FractionalOffset(1.0, 0.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp,
                    ),
                  ),
                  width: MediaQuery
                      .of(context)
                      .size
                      .width - 40,
                  height: 50,
                  child: Center(
                    child: Text(
                      widget.orderStatus == "ended"
                          ? "go back"
                          : "order packing - done",
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20,),
        ],
      );
    }
  }

