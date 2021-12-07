import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:uninews/pages/entertainment.dart';

class EntertainmentDetails extends StatefulWidget {
  final String entertainmentId;
  EntertainmentDetails({ required this.entertainmentId});

  @override
  _PopularDetailsState createState() => _PopularDetailsState();
}

class _PopularDetailsState extends State<EntertainmentDetails> {

  final CollectionReference _entertainment=
  FirebaseFirestore.instance.collection('Entertainment');


  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType){
      return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder(
                future: _entertainment.doc(widget.entertainmentId).get(),
                builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot){
                  if(snapshot.hasError){
                    return Text('${snapshot.error}');
                  }

                  if(snapshot.connectionState == ConnectionState.done){
                    DocumentSnapshot<Object?> documentData = snapshot.data!;

                    return Column(
                      children: [

                        Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: Text('${documentData['title']}', style: TextStyle(
                              fontSize: 15.sp,
                          ),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: Row(
                            children: [
                              Text('Author:'),
                              Text('${documentData['author']}', style: TextStyle(
                                  fontSize: 15
                              ),),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: Container(
                              height: 60.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                    image: NetworkImage('${documentData['image']}'),
                                    fit: BoxFit.fill,
                                  )
                              )
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text('${documentData['description1']}'),
                        ),

                        Text('${documentData['description2']}'),

                      ],
                    );
                  }

                  return Center(child: CircularProgressIndicator());

                }),
          ),
        ),
      );
    });
  }
}
