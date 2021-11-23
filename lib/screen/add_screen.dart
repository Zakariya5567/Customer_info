import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_firestore/model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {

  //____________________________________________________________________
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  UserModel userModel=UserModel();
  final GlobalKey<FormState> _formKey= GlobalKey<FormState>();
  //_______________________________________________________________________________
  final _nameController= TextEditingController();
  final _addressController= TextEditingController();
  final _productController= TextEditingController();
  final _priceController= TextEditingController();
  //_______________________________________________________________________________
  Future<void> addUser() async {
    Navigator.pop(context);
    userModel.name=_nameController.text;
    userModel.address=_addressController.text;
    userModel.productName=_productController.text;
    userModel.productPrice=_priceController.text;
    userModel.date=dateFormatted().toString();

    return await users.add(userModel.toMap()
    ).then((value){
     Fluttertoast.showToast(msg: "data Added");
    })
        .catchError((error) {
      Fluttertoast.showToast(msg: error!.message);
    });

  }
  clearText(){
    _nameController.clear();
    _addressController.clear();
    _productController.clear();
    _priceController.clear();
  }
  //_____________________________________________________________________
 String dateFormatted(){
    var now= DateTime.now();
    var formatter= new DateFormat('EEE: d/MMM/yyyy hh:mm aaa');
    String formatted= formatter.format(now);
    return formatted;
 }
  //_____________________________________________________________________

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown.shade900,
        toolbarHeight: 80,
        shape:RoundedRectangleBorder(
          borderRadius:BorderRadius.only(bottomLeft: Radius.circular(20),
          ),),
        title: Text("Add Customer",style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child:Container(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Form(
            key: _formKey,
            child: Column(
              children:<Widget> [
                SizedBox(height: 20.0,),
                TextFormField(
                  autofocus: false,
                  controller: _nameController,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Costumer Name";
                    }
                  },
                  onSaved: (value) {
                    _nameController.text = value!;
                  },
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                      hintText: "Name",
                      labelText: "Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )
                  ),
                ),

                SizedBox(height: 20.0,),
                TextFormField(
                  autofocus: false,
                  keyboardType:TextInputType.text,
                  controller:_addressController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Costumer address";
                    }
                  },
                  onSaved: (value) {
                    _addressController.text = value!;
                  },
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.home),
                      contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                      hintText: "Address",
                      labelText: "Address",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )
                  ),
                ),
                SizedBox(height: 20.0,),
                TextFormField(
                  autofocus: false,
                  keyboardType:TextInputType.text,
                  controller:_productController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Product Name";
                    }
                  },
                  onSaved: (value) {
                    _productController.text = value!;
                  },
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.miscellaneous_services_outlined),
                      contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                      hintText: "Product Name",
                      labelText: "Product Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )
                  ),
                ),
                SizedBox(height: 20.0,),
                TextFormField(
                  autofocus: false,
                  keyboardType:TextInputType.number,
                  controller:_priceController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Product Price";
                    }
                  },
                  onSaved: (value) {
                    _priceController.text = value!;
                  },
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.money),
                      contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                      hintText: "Product Price",
                      labelText: "Product Price",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )
                  ),
                ),

                SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                        child: new MaterialButton(
                            padding: EdgeInsets.all(15),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                            elevation: 5,
                            color: Colors.brown.shade900,
                            child:Text("Save",style: TextStyle(color:Colors.white,)) ,
                            onPressed:(){
                              if(_formKey.currentState!.validate())
                              addUser();
                              clearText();
                            }
                        )
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                        child: new MaterialButton(
                            padding: EdgeInsets.all(15),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                            elevation: 5,
                            color: Colors.brown.shade900,
                            child:Text("Cancel",style: TextStyle(color: Colors.white),) ,
                            onPressed:(){
                              Navigator.pop(context);
                            }
                        )
                    ),

                  ],
                )
              ],
            ),
          ),
        ),
        ),
          )
    );
  }
}
