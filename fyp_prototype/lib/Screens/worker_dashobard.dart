import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fyp_prototype/Screens/admin_maps_screen.dart';
import 'package:fyp_prototype/Screens/Worker_complaint_list.dart';
import 'package:fyp_prototype/Screens/register_complaint.dart';
import 'package:lottie/lottie.dart';
import 'package:fyp_prototype/Screens/faq_screen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:location/location.dart' as loc;
import '../main.dart';

class WorkerDashboard extends StatefulWidget {
  Function signout = () {};
  Function getUserId = () {};
  double lat = 0;
  double lon = 0;

  WorkerDashboard(Function sout, Function getUid) {
    signout = sout;
    getUserId = getUid;
  }

  @override
  State<WorkerDashboard> createState() => _WorkerDashboardState();
}

class _WorkerDashboardState extends State<WorkerDashboard> {
  final loc.Location location = loc.Location();
  Geolocator geolocator = Geolocator();

  late Position userLocation;
  String _address = "";
  double latitude = 0.0, longitude = 0.0;
  String _city = "", _country = "", _state = "", _zipCode = "";
  String street = "";

  Future<List<geo.Placemark>> _getAddress(double? lat, double? lang) async {
    //final coordinates = new Coordinates(lat, lang);
    List<geo.Placemark> placemarks =
        await geo.placemarkFromCoordinates(lat!, lang!);
    return placemarks;
  }

  getLoc() async {
    var currentLocation = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    //print(
    //'Latitude: ${currentLocation.latitude}, Longitude: ${currentLocation.longitude}');

    //_currentPosition = await location.getLocation();
    _getAddress(currentLocation.latitude, currentLocation.longitude)
        .then((value) {
      setState(() {
        latitude = currentLocation.latitude;
        widget.lat = latitude;

        longitude = currentLocation.longitude;
        widget.lon = longitude;
        _address = "${currentLocation.latitude}, ${currentLocation.longitude}";

        street = value.last.locality.toString();
      });

      latitude = currentLocation.latitude;
      longitude = currentLocation.longitude;
      _city = value.first.locality.toString();
      _country = value.first.country.toString();
      _state = value.first.administrativeArea.toString();
      _zipCode = value.first.postalCode.toString();
    });
    return _address;
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
  void initState() {
    super.initState();
    getLoc();
  }

  @override
  Widget build(BuildContext context) {
    print(
        "================================================Printing my location in build=================================================");
    print(_address);
    print(longitude);
    print(latitude);
    print(_address);
    print(_city);
    print("address123");
    print(street);
    return Scaffold(
      backgroundColor: const Color(0XFF006E7F),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8CB2E),
        actions: [
          IconButton(
            onPressed: () {
              widget.signout().then((_) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => App(),
                  ),
                );
              });
            },
            icon: Icon(Icons.logout, color: Colors.black),
          )
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
          const SizedBox(height: 20),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AdminGoogleMapsScreen(widget.getUserId),
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
                  builder: (context) =>
                      WorkerComplaintList(widget.lat, widget.lon),
                ),
              );
            },
            child: menuItem(context, 'Complaints',
                'https://assets7.lottiefiles.com/packages/lf20_ssIwdK.json'),
          ),
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
