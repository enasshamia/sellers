class Order
{
  String ? title ;
  int? price;
  String?userId;
  String?orderId;
  String?sellerName;
  String?sellerAvatar;
  int ? itemCount ;
  List<dynamic>? extras;
  List? itemId;

  Order({
    this.title,
    this.extras,
    this.price,
    this.itemId,
    this.itemCount,
    this.userId,
    this.sellerName,
    this.sellerAvatar,
    this.orderId,
  });


  Order.fromJson(Map<String , dynamic> json){
    title = json["title"];
    extras = json["extras"];
    price = json["totalAmount"];
    itemId = json["productId"];
    itemCount=json["totalAmount"];
    userId=json["orderId"];
    sellerName=json["sellerName"];
    sellerAvatar=json["sellerAvatar"];
    orderId=json["orderId"];
  }

  Map<String ,dynamic> toJson()
  {
    final Map<String , dynamic> data = new Map<String , dynamic>();
    data["title"] = this.title;
    data["extras"] = this.extras;
    data["totalAmount"] = this.price;
    data["productId"] = this.itemId;
    data["totalAmount"]=this.itemCount;
    data["orderId"]=this.userId;
    data["sellerName"]=this.sellerName;
    data["sellerAvatar"]=this.sellerAvatar;
    data["orderId"]=this.orderId;
    return data;
  }

}
