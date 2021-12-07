import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:uninews/pages/entertainment.dart';
import 'package:uninews/pages/politics.dart';
import 'package:uninews/pages/populardetails.dart';
import 'package:uninews/pages/sports.dart';
import 'package:uninews/pages/trending.dart';

import 'latestdetails.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CollectionReference _homepage =
      FirebaseFirestore.instance.collection('HomePage');

  final CollectionReference _popular =
      FirebaseFirestore.instance.collection('Popular');

  final CollectionReference _latest =
      FirebaseFirestore.instance.collection('Latest');

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(
        backgroundColor: Colors.grey[180],
        appBar: AppBar(),
        drawer: Drawer(
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  Container(
                    height: 35.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                      color: Colors.red,
                    ),
                    child: Column(
                      children: [
                        Center(
                          child: Container(
                            height: 30.h,
                            width: 50.h,
                            decoration: BoxDecoration(
                              color: Colors.yellow,
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage('assets/images/newspastify.jpg'),
                                fit: BoxFit.fill,
                              )
                            )
                          ),
                        ),
                      ],
                    )
                  ),

                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context)=>Trending()));
                    },
                    child: ListTile(
                      leading: const Icon(Icons.new_releases),
                      title: Text('Trending'),
                    ),
                  ),

                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context)=>Entertainment()));
                    },
                    child: ListTile(
                      leading: const Icon(Icons.run_circle_rounded),
                      title: Text('Entertainment'),
                    ),
                  ),

                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context)=>Sports()));
                    },
                    child: ListTile(
                      leading: Icon(Icons.sports_soccer),
                      title: Text('Sports'),
                    ),
                  ),

                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context)=>Politics()));
                    },
                    child: ListTile(
                      leading: const Icon(Icons.thumb_up_alt_rounded),
                      title: Text('Politics'),
                    ),
                  ),

                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text('Log Out'),
                    onTap: () {
                      FirebaseAuth.instance.signOut();
                    },
                  ),
                ],
              ),
            ),
          )
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: FutureBuilder(
              future: _homepage.get(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                if (snapshot.connectionState == ConnectionState.done) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: Text(
                          'Pastify News',
                          style: TextStyle(
                              fontSize: 3.h, fontWeight: FontWeight.w600),
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Trending()));
                                  },
                                  child: Container(
                                    height: 10.h,
                                    width: 20.w,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.red,
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/trending.png'),
                                          fit: BoxFit.fill,
                                        )),
                                  ),
                                ),
                                Text('Trending')
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Entertainment()));
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, right: 15),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 10.h,
                                      width: 20.w,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.red,
                                          image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/entertainment.jfif'),
                                            fit: BoxFit.fill,
                                          )),
                                    ),
                                    Text('Entertainment')
                                  ],
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Sports()));
                                  },
                                  child: Container(
                                    height: 10.h,
                                    width: 20.w,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.red,
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/sports.jfif'),
                                          fit: BoxFit.fill,
                                        )),
                                  ),
                                ),
                                Text('Sports')
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Politics()));
                                    },
                                    child: Container(
                                      height: 10.h,
                                      width: 20.w,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.red,
                                          image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/politics.jfif'),
                                            fit: BoxFit.fill,
                                          )),
                                    ),
                                  ),
                                  Text('Politics')
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 25.0, bottom: 30),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  Align(
                                    child: Text('Popular Now'),
                                    alignment: Alignment.topLeft,
                                  ),
                                  FutureBuilder<QuerySnapshot>(
                                    future: _popular.get(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasError) {
                                        return Text('${snapshot.error}');
                                      }

                                      if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        return Row(
                                          children: snapshot.data!.docs
                                              .map((document) {
                                            return Padding(
                                              padding: const EdgeInsets.only(right: 15.0),
                                              child: Stack(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  PopularDetails(
                                                                      popularId:
                                                                          document
                                                                              .id)));
                                                    },
                                                    child: Container(
                                                      height: 30.h,
                                                      width: 35.h,
                                                      decoration: BoxDecoration(
                                                          color: Colors.red,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          image: DecorationImage(
                                                              image: NetworkImage(
                                                                  '${document['image']}'),
                                                              fit: BoxFit.fill)),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    child: Container(
                                                      height: 60,
                                                      width: 290,
                                                      child: Text(
                                                          '${document['title']}',
                                                          style: TextStyle(
                                                            color: Colors.red,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 20,
                                                          )),
                                                    ),
                                                    bottom: 10,
                                                  )
                                                ],
                                              ),
                                            );
                                          }).toList(),
                                        );
                                      }

                                      return Center(
                                          child: CircularProgressIndicator());
                                    },
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Text(
                        'Latest News',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      FutureBuilder<QuerySnapshot>(
                          future: _latest.get(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            }

                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return Column(
                                children: snapshot.data!.docs.map((document) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LatestDetails(
                                                    latestId: document.id,
                                                  )));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 12.0),
                                      child: Container(
                                        height: 18.h,
                                        width: 100.w,
                                        decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Row(
                                          children: [
                                            Column(
                                              children: [
                                                Container(
                                                    height: 15.h,
                                                    width: 25.w,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: Colors.red,
                                                        image: DecorationImage(
                                                            image: NetworkImage(
                                                                '${document['image']}'),
                                                            fit: BoxFit.fill)))
                                              ],
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 1.h),
                                                  child: Container(
                                                    height: 10.h,
                                                    width: 60.w,
                                                    color: Colors.grey[200],
                                                    child: Text(
                                                      '${document['title']}...',
                                                      style: TextStyle(
                                                          fontSize: 11.sp),
                                                    ),
                                                  ),
                                                ),
                                                Text('${document['date']}')
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              );
                            }

                            return Center(child: CircularProgressIndicator());
                          })
                    ],
                  );
                }

                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ),
      );
    });
  }
}
