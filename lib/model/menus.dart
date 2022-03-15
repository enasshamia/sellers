import 'package:cloud_firestore/cloud_firestore.dart';

class Menus
{
  String? menuID;
  String? sellerUID;
  String? menuTittle;
  String? menuInfo;
  String? thumbnailUrl;
  String? status;
  Timestamp? publishedDate;

  Menus({
    this.menuID,
    this.sellerUID,
    this.menuTittle,
    this.menuInfo,
    this.publishedDate,
    this.status,
    this.thumbnailUrl,
});

  Menus.fromJson(Map<String , dynamic> json)
  {
    menuID = json["menuId"];
    sellerUID = json['sellerUid'];
    menuInfo = json['menuInfo'];
    menuTittle = json['title'];
    publishedDate = json['publishedDate'];
    thumbnailUrl = json['thumbnailUrl'];
    status = json['status'];
  }

  Map<String , dynamic> toJson()
  {
    final Map<String , dynamic> data = Map<String , dynamic>();
    data["menuId"] = menuID;
    data['sellerUid'] = sellerUID;
    data['menuInfo'] = menuInfo;
    data['title'] = menuTittle;
    data['publishedDate'] = publishedDate;
    data['thumbnailUrl'] = thumbnailUrl;
    data['status'] = status;

    return data ;
  }

}