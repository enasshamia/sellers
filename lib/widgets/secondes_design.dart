import 'package:flutter/material.dart';
import 'package:lhad_elbeit_selleres/mainScreens/seconds_screen.dart';
import 'package:lhad_elbeit_selleres/model/seconds.dart';

class SecondsDesign extends StatefulWidget {

  Seconds? model ;
  BuildContext? context ;

  SecondsDesign({this.model , this.context});
  @override
  _SecondsDesignState createState() => _SecondsDesignState();
}



class _SecondsDesignState extends State<SecondsDesign> {
  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: ()
      {
      //  Navigator.push(context, MaterialPageRoute(builder: (c)=>  SecondsScreen(model:widget.model)));
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
                      widget.model!.title!,

                    ),),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(1, 1),
                              blurRadius: 4,
                            )
                          ]),
                      child:  const Padding(
                          padding: EdgeInsets.all(8.0),
                          child:  Icon(
                            Icons.favorite,
                            color: Colors.red,
                            size: 18,
                          )
                      ),
                    ),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween ,
                children: [
                  Row(
                    children:   [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          widget.model!.shortInfo!,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const Icon(
                        Icons.star,
                        color: Colors.red,
                        size: 16,
                      ),
                      const Icon(
                        Icons.star,
                        color: Colors.red,
                        size: 16,
                      ),
                      const Icon(
                        Icons.star,
                        color: Colors.red,
                        size: 16,
                      ),
                      const Icon(
                        Icons.star,
                        color: Colors.red,
                        size: 16,
                      ),
                      const Icon(
                        Icons.star,
                        color: Colors.grey,
                        size: 16,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child:  Text(
                      widget.model!.status!,

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
