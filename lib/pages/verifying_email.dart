import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'homepage.dart';

class  Verifying_Email extends StatefulWidget {
  const  Verifying_Email({Key? key}) : super(key: key);

  @override
  State<Verifying_Email> createState() => _Verifying_EmailState();
}

class _Verifying_EmailState extends State<Verifying_Email> {
  final auth = FirebaseAuth.instance;
  User? user;
  Timer? timer;

  @override
  void initState() {
    user = auth.currentUser;
    user?.sendEmailVerification();
    timer = Timer.periodic(Duration(seconds: 500), (timer) {

    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Column(
        children: [
          Text('We send Verifying_Email To ${auth.currentUser} Check your Email'),
        ],
      )),
    );
  }

  Future<void> checkVerifyingEmail()
  async {
    user = auth.currentUser;
    await user?.reload();
    if(user!.emailVerified){
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomePage()));


    }
  }

}
