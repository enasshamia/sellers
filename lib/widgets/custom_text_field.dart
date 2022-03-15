import 'package:flutter/material.dart';

class CustomTextFIeld extends StatelessWidget
{
  final TextEditingController ? controller ;
  final IconData? data;
  final String? hintText;

  bool? isObsecre = true ;
  bool? enabled = true ;

  CustomTextFIeld({
    this.controller,
    this.data,
    this.hintText,
    this.isObsecre,
    this.enabled,
});


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.all(10.0),
      child: TextFormField(
        enabled: enabled,
        controller: controller,
        obscureText: isObsecre!,
        cursorColor: Theme.of(context).primaryColor,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            data,
            color: Colors.cyan,
          ),
          focusColor: Theme.of(context).primaryColor,
          hintText: hintText,
        ),
      ),
    );
  }}