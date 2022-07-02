import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/pages/homepage.dart';
import 'package:project/pages/signup.dart';
import 'package:project/resources/color_manger.dart';
import 'package:project/widgets/button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool pass=true;
  late String _emailController;
 late  String _passwordController;
  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/pg1.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(35.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Image(image: AssetImage('assets/images/frist.png')),
                    const Text('WE HOPE TO BE HEALTHY',
                        style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.w900,
                            color: Colors.white)),
                    const SizedBox(
                      height: 30.0,
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    buildTextFormField(
                      vall: false,
                        validate:()=> (val) {
                          if (val!.isEmpty || !val.contains('@')) {
                            return "Invalid email!";
                          }
                          return null;
                        },
                        onSave: ()=>(val) {
                          setState(() {
                            _emailController = val;
                          });
                          _authData['email'] = val!;

                        },
                        hint: 'Enter Email',
                        label: 'Username',
                        pIcon: Icon(
                          Icons.person,
                          color: ColorManager.primary,
                        ),
                        sIcon: Icon(
                          Icons.verified_user_outlined,
                          color: ColorManager.primary,
                        ),
                        onTab: () {}),
                    const SizedBox(
                      height: 30.0,
                    ),
                    buildTextFormField(
                      vall: pass,
                     validate: ()=>(val) {
                       if (val!.isEmpty || val.length <= 5) {
                         return "Password is too short!";
                       }
                       return null;
                     },
                        onSave: ()=>(val) {
                          _authData['password'] = val!;
                          setState(() {
                            _passwordController = val;
                          });
                        },
                        hint: 'Password',
                        label: 'Password',
                        pIcon: Icon(
                          Icons.lock_outline,
                          color: ColorManager.primary,
                        ),
                        sIcon: Icon(
                          Icons.remove_red_eye_rounded,
                          color: ColorManager.primary,
                        ),
                        onTab: () {
                          setState(() {
                            pass=!pass;
                          });

                        }),
                    const SizedBox(
                      height: 30.0,
                    ),
                    MyButton(
                      title: 'Login',
                      onTap: _submit,
                      color: Colors.white,
                      color1: ColorManager.primary,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Expanded(
                          child: Divider(
                            thickness: 1.5,
                            endIndent: 5,
                            color: Colors.grey,
                          ),
                        ),
                        Text('OR',style: TextStyle(fontSize: 15,fontWeight:FontWeight.w700),),
                        Expanded(
                          child: Divider(
                            thickness: 1.5,
                            indent: 5,
                            color: Colors.grey,
                          ),
                        ),
                      ],),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Create a new account?',
                          style: GoogleFonts.arimo(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: ColorManager.darkGrey,
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Sign_Up()));
                            },
                            child: Text(
                              'Register Now',
                              style: GoogleFonts.abel(
                                fontSize: 19,
                                fontWeight: FontWeight.w800,
                              ),
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: const CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 28,
                              backgroundImage:
                                  AssetImage('assets/images/facebook.png'),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30),
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 28,
                                backgroundImage:
                                    AssetImage('assets/images/twitter.png'),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: const CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 28,
                              backgroundImage: AssetImage('assets/images/g+.png'),
                            ),
                          ),
                        ],
                      ),


                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  login() async {
    try {
      if (_emailController.isNotEmpty && _passwordController.isNotEmpty) {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
            email: _emailController, password: _passwordController);
        return userCredential;
      } else {
        print('isEmpty');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.INFO,
          animType: AnimType.BOTTOMSLIDE,
          title: 'Attend  !',
          desc: 'This Account IsNot Exist',
          btnCancelOnPress: () {},
          btnOkOnPress: () {},
        ).show();
      } else if (e.code == 'wrong-password') {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.INFO,
          animType: AnimType.BOTTOMSLIDE,
          title: 'Attend  !',
          desc: 'The password is Wrong',
          btnOkOnPress: () {},
        ).show();
      }
    } catch (e) {
      print(e);
    }
  }

  TextFormField buildTextFormField(
      {required String hint,
      required String label,
      required Widget pIcon,
      required Widget sIcon,
      required Function() onTab,
        required Function() validate,
        required Function() onSave,
        required bool vall,
      }) {
    return TextFormField(
      validator: validate(),
      onSaved: onSave(),
      // keyboardType: TextInputType.visiblePassword,
      obscureText: vall,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.arimo(
          fontSize: 20,
          color: Colors.grey[700],
        ),
        hintText: hint,
        hintStyle: GoogleFonts.arimo(
          fontSize: 19,
          color: Colors.grey[700],
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: const BorderSide(color: Colors.black, width: 1.2)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: const BorderSide(color: Colors.black, width: 1.2)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(color: Colors.black, width: 1.2),
        ),
        filled: true,
        fillColor: Colors.white,
        prefixIcon: pIcon,
        suffixIcon: IconButton(
          onPressed: onTab,
          icon: sIcon,
        ),
      ),
    );
  }

  void _submit()async {
    if (_formKey.currentState!.validate() ) {
      _formKey.currentState!.save();
      var user = await login();
      if (user != null) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomePage()));
      }
    }else{
      print('error');
      print('Not Valid');
    }


    // Sign user up
  }
}
