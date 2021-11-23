import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_firestore/main.dart';
import 'package:flutter/cupertino.dart';

class UserModel{
  String?  name;
  String? address;
  String?  productName;
  String?  productPrice;
  String?  date;


  UserModel(
  {this.name, this.address, this.productName, this.productPrice, this.date});

  Map<String, dynamic> toMap(){
   return{
     "name":name,
     "address":address,
     "productName":productName,
     "productPrice": productPrice,
     "date":date,
   };
 }

}