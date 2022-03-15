import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lhad_elbeit_selleres/global/global.dart';
import 'package:lhad_elbeit_selleres/mainScreens/home_screen.dart';
import 'package:lhad_elbeit_selleres/model/items.dart';
import 'package:lhad_elbeit_selleres/widgets/error_dialog.dart';
import 'package:lhad_elbeit_selleres/widgets/progress_bar.dart';
import 'package:firebase_storage/firebase_storage.dart' as storageRef;
class SecondsUploadScreen extends StatefulWidget {

  final Items? model;
  SecondsUploadScreen({this.model });

  @override
  _SecondsUploadScreenState createState() => _SecondsUploadScreenState();
}

class _SecondsUploadScreenState extends State<SecondsUploadScreen> {

  XFile? imageXFile ;
  final ImagePicker _picker = ImagePicker();
  bool isChecked = false;

  TextEditingController titleController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  bool uploading = false ;
  String uniqueSecondID = DateTime.now().millisecondsSinceEpoch.toString();

  defaultScreen(){
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
        title: const Text(
          "Add new items",
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back , color: Colors.white,),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (c)=> const HomeScreen()));
          },
        ),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [
              const Icon(Icons.shop_two , color: Colors.grey, size: 200.0,),
              ElevatedButton(
                child: const Text("add new second" ,style: TextStyle(fontSize: 18),),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.amber),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    )
                ),
                onPressed: (){
                  takeImage(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  takeImage(mContext){
    return showDialog(
        context: mContext,
        builder: (context){
          return  SimpleDialog(
            title: const Text("item Image" , style: TextStyle(color: Colors.amber , fontWeight: FontWeight.bold),),
            children: [
              SimpleDialogOption(
                child: const Text("Capture with camera", style: TextStyle(color: Colors.grey),),
                onPressed: captureImageWithCamera,

              ),
              SimpleDialogOption(
                child: const Text("select from gallery", style: TextStyle(color: Colors.grey),),
                onPressed: pickImageFromGallery,
              ),
              SimpleDialogOption(
                  child: const Text("cancel", style: TextStyle(color: Colors.grey),),
                  onPressed: ()=>Navigator.pop(context)),

            ],
          );
        }
    );
  }

  captureImageWithCamera() async{
    Navigator.pop(context);
    imageXFile = await _picker.pickImage(source: ImageSource.camera ,
        maxHeight: 720,
        maxWidth: 1280
    );
    setState(() {
      imageXFile;
    });
  }

  pickImageFromGallery() async{
    Navigator.pop(context);
    imageXFile = await _picker.pickImage(source: ImageSource.gallery ,
        maxHeight: 720,
        maxWidth: 1280
    );
    setState(() {
      imageXFile;
    });

  }
  itemsUploadFormScreen(){
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
        title: const Text(
          "Uploading new seconds",
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back , color: Colors.white,),
          onPressed: (){
            clearMenuUploadForm();          },
        ),
        actions: [
          TextButton(
              onPressed:uploading ? null : ()=> validateUploadForm(),

              child: const Text("add" , style: TextStyle(color: Colors.cyan , fontWeight: FontWeight.bold , fontSize: 18),)),
        ],
      ),
      body: ListView(
        children: [
          uploading == true ? linearProgress() : const Text(""),
          Container(
            height: 230,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Center(
              child: AspectRatio(
                aspectRatio: 16/9,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(
                          File(imageXFile!.path)
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Divider(
            color: Colors.amber,
            thickness: 1,
          ),
          ListTile(
            leading: const Icon(Icons.perm_device_information , color: Colors.cyan,),
            title: Container(
              width: 250,
              child:

              TextField(
                style: const TextStyle(color: Colors.black),
                controller: titleController,
                decoration: const InputDecoration(
                  hintText:  "title",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ) ,

              ),
            ),

          ),
          const Divider(
            color: Colors.amber,
            thickness: 1,
          ),

          ListTile(
            leading: const Icon(Icons.camera , color: Colors.cyan,),
            title: Container(
              width: 250,
              child:

              TextField(
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.black),
                controller: priceController,
                decoration: const InputDecoration(
                  hintText:  " price",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ) ,

              ),
            ),

          ),
          const Divider(
            color: Colors.amber,
            thickness: 1,
          ),
        ],
      ),
    );
  }
  clearMenuUploadForm(){
    setState(() {
      titleController.clear();
      priceController.clear();
      imageXFile = null ;

    });
  }



  validateUploadForm() async
  {
    if(imageXFile != null){
      if(  titleController.text.isNotEmpty && priceController.text.isNotEmpty ){

        setState(() {
          uploading = true;
        });

        // upload
        String downloadUrl = await uploadImage(File(imageXFile!.path));

        // save info to firebase

        saveInfo(downloadUrl);
      }
      else{
        showDialog(context: context, builder: (c){
          return ErrorDialog(
            message: "write every thing",
          );
        });

      }
    }
    else{
      showDialog(context: context, builder: (c){
        return ErrorDialog(
          message: "pleas pick imge for menu",
        );
      });

    }

  }

  saveInfo(String downloadUrl ){
    //doc(firebaseAuth.currentUser!.uid)
    final ref = FirebaseFirestore.instance.collection("sellers").doc(sharedPreferences!.getString("uid")).collection("menus").doc(widget.model!.menuID).collection("items").doc(widget.model!.itemID).collection("secondes");
    ref.doc(uniqueSecondID).set({
      "SsecondID":uniqueSecondID,
      "SmenuId":widget.model!.menuID,
      "SitemID":widget.model!.itemID,
      "SsellerUid":sharedPreferences!.getString("uid"),
      "SsellerName":sharedPreferences!.getString("name"),
      "Stitle":titleController.text.toString(),
      "Sprice":int.parse(priceController.text),
      "SpublishedDate":DateTime.now(),
      "status":"available",
      "SthumbnailUrl":downloadUrl,
      "isChecked": isChecked
    }).then((value) {
      final itemsRef = FirebaseFirestore.instance.collection("items").doc(widget.model!.itemID).collection("secondes");
      itemsRef.doc(uniqueSecondID).set({
        "SsecondID": uniqueSecondID,
        "SmenuId": widget.model!.menuID,
        "SitemID":widget.model!.itemID,
        "SsellerUid": sharedPreferences!.getString("uid"),
        "SsellerName": sharedPreferences!.getString("name"),
        "Stitle": titleController.text.toString(),
        "Sprice": int.parse(priceController.text),
        "SpublishedDate": DateTime.now(),
        "status": "available",
        "SthumbnailUrl": downloadUrl,
        "isChecked": isChecked

      });
    }).then((value){
      clearMenuUploadForm();
      setState(() {
        uniqueSecondID = DateTime
            .now()
            .millisecondsSinceEpoch
            .toString();
        uploading = false;
      });

    });

  }

  uploadImage(mImageFile) async {
    storageRef.Reference reference = storageRef.FirebaseStorage.instance.ref().child("items");

    storageRef.UploadTask uploadTask = reference.child(uniqueSecondID + ".jpg").putFile(mImageFile);
    storageRef.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
    String downloadURL   =  await taskSnapshot.ref.getDownloadURL();

    return downloadURL;
  }


  @override
  Widget build(BuildContext context) {
    return imageXFile == null ? defaultScreen() :
    itemsUploadFormScreen();
  }
}
