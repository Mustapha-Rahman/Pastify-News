import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class LatestDetails extends StatefulWidget {
   final String latestId;

   LatestDetails({required this.latestId});


  @override
  _LatestDetailsState createState() => _LatestDetailsState();
}

class _LatestDetailsState extends State<LatestDetails> {
  final CollectionReference _latest=
  FirebaseFirestore.instance.collection('Latest');

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType){
      return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder(
                future: _latest.doc(widget.latestId).get(),
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
                              fontSize: 15.sp
                          ),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: Row(
                            children: [
                              Text('Author:'),
                              Text('${documentData['author']}', style: TextStyle(
                                  fontSize: 13.sp
                              ),),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: Container(
                              height:55.h,
                              width:100.w,
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
