import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/resources/color_manger.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.maxFinite,
          child: Stack(
            children: [
              Positioned(
                child: Container(
                  width: double.maxFinite,
                  height: 350,
                  decoration: BoxDecoration(
                    color: ColorManager.primary,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(60),
                        bottomRight: Radius.circular(60)),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 65),
                width: double.maxFinite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CircleAvatar(
                            radius: 28,
                            backgroundColor: Colors.grey.withOpacity(0.5),
                            child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.edit,
                                  size: 35,
                                  color: Colors.grey[100],
                                ))),
                        const CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(
                              'https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dXNlcnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60'),
                        ),
                        CircleAvatar(
                            radius: 28,
                            backgroundColor: Colors.grey.withOpacity(0.5),
                            child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.settings,
                                  size: 35,
                                  color: Colors.grey[100],
                                ))),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Karim khaled',
                      style: GoogleFonts.lato(
                          textStyle: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w800,
                          )),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.location_on_rounded, size: 25,
                          color: Colors.redAccent,),
                        const SizedBox(width: 9,),
                        Text(
                          'Egypt, Menofia ',
                          style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  fontSize: 21,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey[400]
                              )),
                        ),
                      ],
                    ),
                    Text(
                      'Kareemkhaled617@gmail.com',
                      style: GoogleFonts.lato(
                          textStyle: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[400]
                          )),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 50),
                            child: MaterialButton(
                              onPressed: () {},
                              child: const Text(
                                'FOLLOW',
                              ),
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side: const BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 100,
                          ),
                          MaterialButton(
                            onPressed: () {},
                            child: const Text(
                              'MESSAGE',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: const BorderSide(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(right: 10,
                                left:10,bottom: 10),
                            height: 130,
                            decoration: BoxDecoration(
                                color: Colors.redAccent,
                                borderRadius: BorderRadius.circular(15)
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(right: 10,
                                left:10,bottom: 10),
                            height: 130,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(15)
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(right: 10,
                                left:10,bottom: 10),
                            height: 130,
                            decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.circular(15)
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(right: 10,
                                left:10,bottom: 10),
                            height: 130,
                            decoration: BoxDecoration(
                                color: Colors.teal,
                                borderRadius: BorderRadius.circular(15)
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(right: 10,
                                left:10,bottom: 10),
                            height: 130,
                            decoration: BoxDecoration(
                                color: Colors.tealAccent,
                                borderRadius: BorderRadius.circular(15)
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(right: 10,
                                left:10,bottom: 10),
                            height: 130,
                            decoration: BoxDecoration(
                                color: Colors.indigo,
                                borderRadius: BorderRadius.circular(15)
                            ),
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
