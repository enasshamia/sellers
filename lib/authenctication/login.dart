import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lhad_elbeit_selleres/authenctication/auth_screen.dart';
import 'package:lhad_elbeit_selleres/global/global.dart';
import 'package:lhad_elbeit_selleres/mainScreens/home_screen.dart';
import 'package:lhad_elbeit_selleres/widgets/custom_text_field.dart';
import 'package:lhad_elbeit_selleres/widgets/error_dialog.dart';
import 'package:lhad_elbeit_selleres/widgets/loading_dialog.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>() ;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  formValidation(){
    if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty){
      //login
      loginNow();
    }
    else{
      showDialog(context: context,
          builder: (c)
          {
        return ErrorDialog(
          message: "Please write.....",
        );
          }
      );
    }

  }

  loginNow()async{
    showDialog(context: context,
        builder: (c)
        {
          return LoadingDialog(
            message: "Checking.....",
          );
        }
    );

    User? currentUser;
    await firebaseAuth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim()
    ).then((auth){
      currentUser = auth.user!;
    }).catchError((error){
      Navigator.pop(context);
      showDialog(context: context,
          builder: (c)
          {
            return ErrorDialog(
              message: error.message.toString(),
            );
          }
      );
    });
    if(currentUser != null){
        readData(currentUser!);
    }
  }
  //read data ana set data locally
  Future readData(User currentUser) async
  {
    await FirebaseFirestore.instance.collection("sellers").doc(currentUser.uid).get().then((snapshot) async{
      if(snapshot.exists) {
        await sharedPreferences!.setString("uid", currentUser.uid);
        await sharedPreferences!.setString(
            "email", snapshot.data()!["sellerEmail"]);
        await sharedPreferences!.setString(
            "name", snapshot.data()!["sellerName"]);
        await sharedPreferences!.setString(
            "photoUrl", snapshot.data()!["sellerAvatrUrl"]);

        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (c)=> const HomeScreen()));
      }
      else{
        firebaseAuth.signOut();
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (c)=> const AuthScreen()));
        showDialog(context: context,
            builder: (c)
            {
              return ErrorDialog(
                message: "no record exist",
              );
            }
        );
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Image.asset("images/d.png",
              height: 270,
              ),
              ),
            ),
          Form(
            key: _formKey,
              child: Column(
                children: [
                  CustomTextFIeld(
                    data: Icons.email,
                    controller: emailController,
                    hintText: "email",
                    isObsecre: false,
                  ),
                  CustomTextFIeld(
                    data: Icons.lock,
                    controller: passwordController,
                    hintText: "password",
                    isObsecre: true,
                  ),
                  ElevatedButton(
                    onPressed: (){
                      formValidation();
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.purple,
                      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
                    ),
                  ),
                  const SizedBox(height: 30,),
                ],
              ),),
        ],
      ),
    );
  }
}
