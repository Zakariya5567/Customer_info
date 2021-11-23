import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_firestore/model.dart';
import 'package:crud_firestore/screen/add_screen.dart';
import 'package:crud_firestore/screen/update_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  UserModel userModel = UserModel();
  TextEditingController searchController = TextEditingController();

  Future<void> deleteUser(String id) async {
    return await users.doc(id).delete().then((value) {
      Fluttertoast.showToast(msg: "data deleted");
    }).catchError((error) {
      Fluttertoast.showToast(msg: error!.message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown.shade200,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.brown.shade900,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
          ),
        ),
        title: Text("Customer List ",style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('users').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            else  if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.red,
                ),
              );
            }else  if (snapshot.hasError) {
              return Center(
                child: Text("Something went wrong"),
              );
            }
            else if (snapshot.hasData || snapshot.data != null){

            }
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final document = snapshot.data!.docs[index];
                  if (snapshot.hasData || snapshot.data != null) {
                    return  Card(
                      color: Colors.brown.shade700,
                      shape: OutlineInputBorder(borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30.0),topLeft: Radius.circular(15.0),
                        bottomLeft: Radius.circular(15.0)
                      )),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                              title: Text("Name: ${document["name"]} ",
                                style: TextStyle(
                                color: Colors.white,fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                              ),
                              ),
                              subtitle:
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10.0,),
                                 Text("Address: ${document["address"]}",
                                   style: TextStyle(
                                       color: Colors.white,fontSize: 16.0
                                   ),),
                                  SizedBox(height: 10.0),
                                  Text("Product: ${document["productName"]}",
                                    style: TextStyle(
                                        color: Colors.white,fontSize: 16.0
                                    ),),
                                  SizedBox(height: 10.0),
                                  Text("Price: ${document["productPrice"]}",
                                    style: TextStyle(
                                        color: Colors.white,fontSize: 16.0
                                    ),),
                                  SizedBox(height: 10.0),
                                  Text("Date: ${document["date"]}",
                                    style: TextStyle(
                                        color: Colors.white,fontSize: 16.0
                                    ),),
                              ],),
                              //Text("${document["address"]}"),
                              trailing: IconButton(
                                icon: Icon(
                                  Icons.delete_forever,
                                  size: 30.0,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  deleteUser(document.id,);
                                },
                              ),
                              onLongPress: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                      return UpdateScreen(document.id);
                                    }));
                              }),
                        )
                    );
                          }
                          return Center(
                        child: Text("no data found"),
                  );
                });
          }), //builder stream
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.brown.shade900,
          child: Icon(Icons.add,color: Colors.white,),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return AddScreen();
            }));
          } //floating onpressed
          ),
    );
  } //Widget build
} //_HomeStateclass
