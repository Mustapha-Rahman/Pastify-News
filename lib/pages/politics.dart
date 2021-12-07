import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:uninews/pages/politicsdetails.dart';
import 'package:uninews/pages/trending%20details.dart';

class Politics extends StatefulWidget {


  @override
  _TrendingState createState() => _TrendingState();
}

class _TrendingState extends State<Politics> {
  final CollectionReference _politics=
  FirebaseFirestore.instance.collection('Politics');

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType){
      return Scaffold(
          appBar: AppBar(
            title: Text('Politics News'),
          ),

          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder<QuerySnapshot>(
                future: _politics.get(),
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
                                builder: (context)=>PoliticsDetails(politicsId: document.id)
                            ));
                          },
                          child: Container(
                              height:25.h ,
                              width:100.w,
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    height:25.h,
                                    width:30.w,
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        image: DecorationImage(
                                          image: NetworkImage('${document['image']}'),
                                          fit: BoxFit.fill,
                                        )
                                    ),

                                  ),

                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10.0, left: 5),
                                        child: Container(
                                            height: 15.h,
                                            width:55.w,
                                            child: Text('${document['title']}', style: TextStyle(
                                                fontSize: 15.sp
                                            ),)
                                        ),
                                      ),
                                      Text('${document['date']}'),

                                    ],
                                  ),
                                ],
                              )
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
