import 'package:cloud_firestore/cloud_firestore.dart';
import '../global/global.dart';



separateOrdersIDs(orderId)
{
  List<String> separateOrderIDsList=[] , defaultItemList=[];
  int i=0;

  defaultItemList = List<String>.from(orderId!);

  for(i; i<defaultItemList.length ; i++)
  {
    String item = defaultItemList[i].toString();
    var pos = item.lastIndexOf(":");
    String getItemId = (pos != -1) ? item.substring(0, pos) : item ;

    print("\nthis is itemID now = " + getItemId);

    separateOrderIDsList.add(getItemId);
  }
  print("\nthis is List now1 = " );
  print(separateOrderIDsList);

  return separateOrderIDsList ;

}


separateItemIDs()
{
  List<String> separateItemIDsList=[] , defaultItemList=[];
  int i=0;

  defaultItemList = sharedPreferences!.getStringList("userCart")!;

  for(i; i<defaultItemList.length ; i++)
    {
      String item = defaultItemList[i].toString();
      var pos = item.lastIndexOf(":");
      String getItemId = (pos != -1) ? item.substring(0, pos) : item ;

      print("\nthis is itemID now = " + getItemId);

      separateItemIDsList.add(getItemId);
    }
   print("\nthis is List now1 = " );
   print(separateItemIDsList);

   return separateItemIDsList ;

}


separateItemId(List? itemId)
{
  List<String> separateOrderQuantityList=[] ;
  int i=1;

  for(i; i<itemId!.length ; i++)
  {
    List defaultItemList=[];
    String item = defaultItemList[i].toString();
    var quanNumber;

    defaultItemList = itemId;

    List<String> listItemCharacter = item.split(":").toList();

     quanNumber = listItemCharacter[1].toString();

    print("\nthis is Quantity Number = " + quanNumber.toString());

    separateOrderQuantityList.add(quanNumber.toString());
  }
  print(itemId.length.toString() + "dsadsadsada");
  print("\nthis is List now = " );
  print(separateOrderQuantityList);

  return separateOrderQuantityList ;

}


separateItemQuantities()
{
  List<int> separateItemQuantityList=[] ;
  List<String> defaultItemList=[];
  int i=1;

  defaultItemList = sharedPreferences!.getStringList("userCart")!;

  for(i; i<defaultItemList.length ; i++)
  {
    String item = defaultItemList[i].toString();

    List<String> listItemCharacter = item.split(":").toList();

    var quanNumber = int.parse(listItemCharacter[1].toString());

    print("\nthis is Quantity Number = " + quanNumber.toString());

    separateItemQuantityList.add(quanNumber);
  }
  print("\nthis is List now = " );
  print(separateItemQuantityList);

  return separateItemQuantityList ;

}

clearCartNow(context)
{
  sharedPreferences!.setStringList("userCart", ['garbageValue']);
  List<String>? emptyList = sharedPreferences!.getStringList("userCart");

  FirebaseFirestore.instance.collection("users").doc(firebaseAuth.currentUser!.uid).update({"userCart": emptyList}).then((value){
    sharedPreferences!.setStringList("userCart", emptyList!);
  });
}
