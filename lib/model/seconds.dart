import 'package:cloud_firestore/cloud_firestore.dart';


class Seconds
{
  String? menuID;
  String? secondsID;
  String? sellerUid;
  String? itemID;
  String? title;
  String? shortInfo;
  Timestamp? publishedDate;
  String? thumbnailUrl;
  String? status;
  String? description;
  int? price;
  bool? isCheck =false;

  Seconds({
    this.secondsID,
    this.menuID,
    this.sellerUid,
    this.itemID,
    this.title,
    this.shortInfo,
    this.publishedDate,
    this.thumbnailUrl,
    this.status,
    this.price,
    this.isCheck,
  });

  Seconds.fromJson(Map<String ,dynamic> json)
  {
    menuID = json['menuId'];
    secondsID = json['secondID'];
    sellerUid = json['sellerUid'];
    itemID = json['itemID'];
    title = json['title'];
    shortInfo= json['Info'];
    publishedDate = json['publishedDate'];
    thumbnailUrl = json['thumbnailUrl'];
    description = json['description'];
    status = json['status'];
    price = json['price'];
    isCheck =json['isChecked'];

  }

  Map<String ,dynamic> tojson()
  {
    final Map<String , dynamic> data = Map<String , dynamic>();
    data['menuID'] = menuID;
    data['secondID'] = secondsID;
    data['sellerUID'] = sellerUid;
    data['itemID'] = itemID ;
    data['Info'] = shortInfo;
    data['publishedDate']=publishedDate;
    data['thumbnailUrl']=thumbnailUrl;
    data['description']=description;
    data['status']=status;
    data['price']=price;
    data['title']=title;
    data['isChecked']=isCheck;

    return data ;

  }

}

