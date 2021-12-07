import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:uninews/pages/landingpage.dart';


void main(){
  runApp(
    PastifyNews()
  );
}

class PastifyNews extends StatelessWidget {
  const PastifyNews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType){
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pastify News',

        home: LandingPage(),
      );
    });
  }
}

