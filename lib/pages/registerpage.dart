import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uninews/widget/constant.dart';
import 'package:uninews/widget/custom%20btn.dart';
import 'package:uninews/widget/custom%20input.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  Future<void> _alertDialogBuilder(String error) async{
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context){
          return AlertDialog(
            title: Text('Error'),
            content: Container(
              child:  Text(error),
            ),
            actions: [
              ElevatedButton(
                child: Text('Close Dialog'),
                onPressed: (){
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  Future<String?> _createAccount() async{
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _registerEmail, password: _registerPassword);
      return null;
    } on FirebaseAuthException catch(e){
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
      return e.message;

    } catch (e) {
      return e.toString();

    }
  }

  void _submitForm() async{
    setState(() {
      _registerFormLoading = true;
    });

    String? _createAccountFeedback = await _createAccount();
    if(_createAccountFeedback != null){
      _alertDialogBuilder( _createAccountFeedback);

      setState(() {
        _registerFormLoading = false;
      });
    } else{
      Navigator.pop(context);
    }

  }


  bool _registerFormLoading = false;

  String _registerEmail = '';
  String _registerPassword = '';

  late FocusNode _passwordFocusNode;
  late FocusNode _emailFocusNode;



  @override
  void initState() {
    _passwordFocusNode = FocusNode();
    _emailFocusNode = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose;
    _emailFocusNode.dispose;

    super.dispose();
  }






  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: Text('Create A New Account',
                    textAlign: TextAlign.center,
                    style: Constants.boldHeading,
                  ),
                ),
                SizedBox(height: 50,),
                Column(
                  children: [
                    CustomInput(
                      hintText: 'Email',
                      onChanged: (value) {
                        _registerEmail = value;
                      },
                      textInputAction: TextInputAction.next,
                      isPasswordField: false,
                      focusNode: _emailFocusNode,
                      onSubmitted: (String ) {

                      },
                    ),





                    CustomInput(
                      hintText: 'Password',
                      onChanged: (value){
                        _registerPassword = value;
                      },
                      isPasswordField: true,
                      focusNode: _passwordFocusNode,
                      onSubmitted: (value){
                        _submitForm();
                      },
                      textInputAction: TextInputAction.next,
                    ),






                    GestureDetector(
                      onTap: (){
                       _submitForm();
                       },

                      child: CustomBtn(
                        text: 'Create New Account',
                        outlineBtn: false,
                        isLoading: _registerFormLoading,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 200,),
                Padding(
                  padding: const EdgeInsets.only( bottom: 12.0),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: CustomBtn(
                      text: 'Back To Login',
                      outlineBtn: true, isLoading: false,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
