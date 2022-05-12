import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fyp_prototype/Screens/faq_screen.dart';
import 'package:fyp_prototype/Screens/user_maps_screen.dart';
import 'package:fyp_prototype/Screens/register_complaint.dart';
import 'package:lottie/lottie.dart';

import '../main.dart';

class UserDashboard extends StatelessWidget {
  Function signout = () {};
  Function getuserid = () {};
  UserDashboard(Function sout, Function getuid) {
    signout = sout;
    getuserid = getuid;
  }

  final carousalList = [
    {
      'title': '',
      'imgUrl':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRlEo5EKL1rmrTsux_yA3pkrczRhoMhFNvOrg&usqp=CAU'
    },
    {
      'title': '',
      'imgUrl':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQByVFnD78lnaJcXecq_jkVY80tx07M_XZz8A&usqp=CAU'
    },
    {
      'title': '',
      'imgUrl':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSg0VZIrvtU0RLkN15IRFYH9PfoSvDzxOOEMw&usqp=CAU'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF006E7F),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8CB2E),
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
              onPressed: () {
                signout().then((_) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => App(),
                    ),
                  );
                });
              },
              icon: Icon(
                Icons.logout,
                color: Colors.black,
              ))
        ],
      ),
      drawer: Drawer(child: Container()),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          CarouselSlider(
            options: CarouselOptions(height: 200.0, autoPlay: true),
            items: carousalList.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 200,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            i['imgUrl'].toString(),
                          ),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.65),
                              BlendMode.colorBurn),
                        ),
                      ),
                      child: Text(
                        i['title'].toString(),
                        style: TextStyle(fontSize: 26.0, color: Colors.white),
                      ));
                },
              );
            }).toList(),
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RegisterComplaint(
                    signout,
                    getuserid,
                  ),
                ),
              );
            },
            child: menuItem(context, 'Register Complaint',
                'https://assets9.lottiefiles.com/packages/lf20_dbqrrD.json'),
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserGoogleMapsScreen(getuserid),
                ),
              );
            },
            child: menuItem(context, 'View Maps',
                'https://assets3.lottiefiles.com/packages/lf20_svy4ivvy.json'),
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FaqScreen(),
                ),
              );
            },
            child: menuItem(context, 'FAQ\'s',
                'https://assets7.lottiefiles.com/packages/lf20_ssIwdK.json'),
          ),
          const SizedBox(height: 20),
          menuItem(context, 'Ask Question',
              'https://assets8.lottiefiles.com/packages/lf20_e3q4w80w.json'),
        ],
      ),
    );
  }

  Stack menuItem(BuildContext context, String text, String imgUrl) {
    return Stack(
      children: [
        Positioned(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.only(left: 10),
            height: 80,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: const Color(0xFFF8CB2E),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          right: 0,
          bottom: 2,
          child: Container(
            width: 80,
            child: Lottie.network(imgUrl),
          ),
        )
      ],
    );
  }
}
