class User
{
  String ? userrName ;
  String ? userrUid ;
  String ? userEmail ;
  String ? phone ;

  User({
    this.userrName,
    this.phone,
    this.userEmail,

  });

  User.fromJson(Map<String , dynamic> json){
    userrUid = json["userUid"];
    userrName = json["name1"];
    userEmail = json["email1"];
    phone = json["phone1"];
  }

  Map<String ,dynamic> toJson()
  {
    final Map<String , dynamic> data = new Map<String , dynamic>();
    data["userUid"] = this.userrUid;
    data["name1"] = this.userrName;
    data["email1"] = this.userEmail;
    data["phone1"] = this.phone;
    return data;
  }

}
