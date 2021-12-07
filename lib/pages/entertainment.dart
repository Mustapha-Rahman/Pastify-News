import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:uninews/pages/trending%20details.dart';

import 'entertainment details.dart';

class Entertainment extends StatefulWidget {
  const Entertainment({Key? key}) : super(key: key);

  @override
  _TrendingState createState() => _TrendingState();
}

class _TrendingState extends State<Entertainment> {
  final CollectionReference _entertainment=
  FirebaseFirestore.instance.collection('Entertainment');

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType){
      return Scaffold(
          appBar: AppBar(
            title: Text('Entertainment'),
          ),

          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder<QuerySnapshot>(
                future: _entertainment.get(),
                builder: (context, snapshot){
                  if(snapshot.hasError){
                    return Text('Error: ${snapshot.error}');
                  }

                  if(snapshot.connectionState == ConnectionState.done){
                    return Column(
                      children:snapshot.data!.docs.map((document){
                        return GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context)=>EntertainmentDetails(entertainmentId: document.id)
                            ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Container(
                                height:25.h,
                                width:100.w,
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 120,
                                      width: 120,
                                      decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius: BorderRadius.circular(10),
                                          image: DecorationImage(
                                            image: NetworkImage('${document['image']}'),
                                            fit: BoxFit.fill,
                                          )
                                      ),

                                    ),

                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            height:20.h,
                                            width: 55.w,
                                            child: Text('${document['title']}', style: TextStyle(
                                                fontSize: 15.sp
                                            ),)
                                        ),
                                        Text('${document['date']}'),

                                      ],
                                    ),
                                  ],
                                )
                            ),
                          ),
                        );

                      }).toList(),
                    );
                  }

                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
          )
      );
    });
  }
}
