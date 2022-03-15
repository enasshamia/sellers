
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lhad_elbeit_selleres/global/global.dart';
import 'package:lhad_elbeit_selleres/mainScreens/home_screen.dart';
import 'package:lhad_elbeit_selleres/widgets/custom_text_field.dart';
import 'package:lhad_elbeit_selleres/widgets/error_dialog.dart';
import 'package:lhad_elbeit_selleres/widgets/loading_dialog.dart';
import 'package:firebase_storage/firebase_storage.dart' as fStorge;
import 'package:shared_preferences/shared_preferences.dart';
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>() ;
  List<String> listItems  =<String> ['مطعم','سوبرماركت','هدايا واكسسوارات','خضراوات','ملحمة','الكترونيات','اخر'];
  String valueChoose = 'مطعم';


  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  XFile? imageXFile;
  final ImagePicker _picker = ImagePicker();

  Position? position ;
  List<Placemark>? placeMark ;

  String sellerImageUrl = "";
  String completeAddress = "" ;


  Future<void> _getImage() async{

    imageXFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageXFile;
    });
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled ;
    LocationPermission permission ;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if(!serviceEnabled){
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();
    if( permission == LocationPermission.denied) {
      permission =await Geolocator.requestPermission();
      if(permission ==  LocationPermission.denied){
        return Future.error('Location permission are denied');
      }
    }
    if(permission == LocationPermission.deniedForever){
      return Future.error("we cannot request permission");
    }
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
}

  getCurrentLocation() async{

    Position newPosition = await _determinePosition(

    );
    position = newPosition;
    placeMark = await placemarkFromCoordinates(
      position!.latitude,
      position!.longitude,
    );
    Placemark pMark = placeMark![0];

     completeAddress = '${pMark.subThoroughfare} ${pMark.thoroughfare},${pMark.subLocality} ${pMark.locality} , ${pMark.subAdministrativeArea} , ${pMark.administrativeArea} ${pMark.postalCode} , ${pMark.country} ';

    locationController.text = completeAddress ;
  }

  Future<void> formValidation() async
  {
    if(imageXFile == null)
      {
        showDialog(
            context: context,
            builder: (c)
            {
              return ErrorDialog(
                message: "Pleas select an image",
              );
            }
        );
      }
    else{
      if(passwordController.text == confirmPasswordController.text){

        if(confirmPasswordController.text.isNotEmpty && emailController.text.isNotEmpty && nameController.text.isNotEmpty && phoneController.text.isNotEmpty && locationController.text.isNotEmpty){
          //start upload
          showDialog(context: context,
              builder: (c){
                return LoadingDialog(
                  message: "registration start",
                );
              }
          );

          String fileName = DateTime.now().millisecondsSinceEpoch.toString();
          fStorge.Reference reference = fStorge.FirebaseStorage.instance.ref().child("Sellers").child(fileName);
          fStorge.UploadTask uploadTask = reference.putFile(File(imageXFile!.path));
          fStorge.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
          await taskSnapshot.ref.getDownloadURL().then((url){
            sellerImageUrl = url ;

            // save data to firestore
            signUpSeller();

          });
        }
        else{
          showDialog(context: context, builder: (c){
            return ErrorDialog(
              message: " all fildes",
            );
          });

        }
      }
      else{
        showDialog(context: context, builder: (c){
          return ErrorDialog(
            message: " password do not match",
          );
        });
      }
    }
  }

  void signUpSeller() async
  {
    User ? currentUser ;


    await firebaseAuth.createUserWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    ).then((auth){
      currentUser = auth.user ;
    }).catchError((error){
      Navigator.pop(context);
      showDialog(context: context, builder: (c){
        return ErrorDialog(
          message: error.message.toString(),
        );
      });

    });
    if(currentUser != null)
      {
        saveDataToFirestore(currentUser!).then((value){
          Navigator.pop(context);

          //send User to home page
          Route newRoute = MaterialPageRoute(builder: (c) => const HomeScreen());
          Navigator.pushReplacement(context, newRoute);
        });
      }
  }

  Future saveDataToFirestore(User currentUser) async
  {
    FirebaseFirestore.instance.collection(valueChoose).doc(currentUser.uid).set({
      "sellerUID": currentUser.uid,
      "sellerEmail":currentUser.email,
      "sellerName": nameController.text.trim(),
      "sellerAvatrUrl": sellerImageUrl,
      "phone": phoneController.text.trim(),
      "type":valueChoose,
      "address": completeAddress,
      "status": "approved",
      "earnings" : 0.0,
      "let":position!.latitude,
      "lng":position!.longitude,
    }).then((value) {
      final itemsRef = FirebaseFirestore.instance.collection("sellers");
      itemsRef.doc(currentUser.uid).set({
        "sellerUID": currentUser.uid,
        "sellerEmail": currentUser.email,
        "sellerName": nameController.text.trim(),
        "sellerAvatrUrl": sellerImageUrl,
        "phone": phoneController.text.trim(),
        "type": valueChoose,
        "address": completeAddress,
        "status": "approved",
        "earnings": 0.0,
        "let": position!.latitude,
        "lng": position!.longitude,
      });
    });
    //save data locally
    sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences!.setString("uid", currentUser.uid);
    await sharedPreferences!.setString("email", currentUser.email.toString());
    await sharedPreferences!.setString("name", nameController.text.trim());
    await sharedPreferences!.setString("photoUrl", sellerImageUrl);
  }



  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child:Column(
          mainAxisSize: MainAxisSize.max,
          children:  [
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: ()
              {
                _getImage();
              },
              child: CircleAvatar(
                radius: MediaQuery.of(context).size.width * 0.20,
                backgroundColor: Colors.white,
                backgroundImage: imageXFile==null ? null : FileImage(File(imageXFile!.path)) ,
                child: imageXFile == null
                    ?
                Icon(
                  Icons.add_photo_alternate,
                  size: MediaQuery.of(context).size.width * 0.20,
                  color: Colors.grey,
                ) : null,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Form(
              key: _formKey,
                child:Column(
                  children: [
                    CustomTextFIeld(
                      data: Icons.person,
                      controller: nameController,
                      hintText: "Name",
                      isObsecre: false,
                    ),
                    CustomTextFIeld(
                      data: Icons.email,
                      controller: emailController,
                      hintText: "Email",
                      isObsecre: false,
                    ),
                    CustomTextFIeld(
                      data: Icons.lock,
                      controller: passwordController,
                      hintText: "Password",
                      isObsecre: true,
                    ),
                    CustomTextFIeld(
                      data: Icons.person,
                      controller: confirmPasswordController,
                      hintText: "Confirm Password",
                      isObsecre: true,
                    ),
                    CustomTextFIeld(
                      data: Icons.phone,
                      controller: phoneController,
                      hintText: "Phone",
                      isObsecre: false,
                    ),
                    CustomTextFIeld(
                      data: Icons.my_location,
                      controller: locationController,
                      hintText: "piza",
                      isObsecre: false,
                      enabled: false,
                    ),
                    Container(
                      margin: const EdgeInsets.all(16),
                      padding: const EdgeInsets.symmetric(horizontal: 12 , vertical: 4),
                      decoration:
                      BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.black,width: 4)
                      ),
                      child:DropdownButton<String>(
                        onChanged:(String? newValue){
                          setState(() {
                            valueChoose = newValue!;
                          });
                        } ,
                        value: valueChoose,
                        items: listItems.map<DropdownMenuItem<String>>(
                            (String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }
                        ).toList()
                          ),

                    ),
                    Container(
                      width: 400,
                      height: 40 ,
                      alignment: Alignment.center,
                      child: ElevatedButton.icon(
                          onPressed: (){
                            getCurrentLocation();
                          },
                          label: const Text(
                            "Get my Current Location",
                            style: TextStyle(color: Colors.white),
                          ),
                        icon: const Icon(
                            Icons.location_on,
                            color: Colors.white,
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.amber,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                      ),
                      ],
                    ),
                ),
            const SizedBox(height: 30,),
            ElevatedButton(
                onPressed: ()=> formValidation(),
                child: const Text(
                  "Sign Up",
                  style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold),
                ),
              style: ElevatedButton.styleFrom(
                primary: Colors.purple,
                padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
              ),
            ),
            const SizedBox(height: 30,),


          ],
        ) ,
      ),
    );
  }

}
