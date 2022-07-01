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
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      checkVerifyingEmail();
    });
    super.initState();
  }
  @override
  void dispose() {
   timer?.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('We send Verifying_Email To ${user?.email} Check your Email'),
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
