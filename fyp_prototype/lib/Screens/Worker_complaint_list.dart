import 'package:expandable/expandable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:location/location.dart' as loc;
import '../main.dart';
import '../providers/complaint_provider.dart';
import './register_complaint_worker.dart';

class WorkerComplaintList extends StatefulWidget {
  //const ComplaintList({Key? key}) : super(key: key);
  double latitude = 0;
  double logitude = 0;
  late Function getUserId;
  late Function signOut;

  WorkerComplaintList(
      double lat, double lon, Function getuid, Function signout) {
    latitude = lat;
    logitude = lon;
    getUserId = getuid;
    signOut = signout;
  }

  @override
  State<WorkerComplaintList> createState() => _WorkerComplaintListState();
}

class _WorkerComplaintListState extends State<WorkerComplaintList> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final database = FirebaseDatabase.instanceFor(
      app: firebaseApp,
      databaseURL:
          'https://fyp-project-98f0f-default-rtdb.asia-southeast1.firebasedatabase.app');
  DatabaseReference ref = FirebaseDatabase.instance.ref("complaints");
  List<dynamic> complainList = [];
  List<String> complainKeys = [];
  List<dynamic> originalComplainList = [];
  List<dynamic> workerComplainList = [];
  List<Map<dynamic, dynamic>> mapList = [];
  String keyid = '';

  updateState(dynamic val) async {
    print("val");
    print(val['dateTime']);
    setState(() {
      complainList.remove(val);

      originalComplainList.remove(val);
    });
  }

  Future<void> printFirebase() async {
    print("complain");
    DatabaseEvent event = await database.ref('complaints').once();
    //database.ref().child("complaints").once().then((value)=> print(value.));
    List<dynamic> res = [];
    Map<dynamic, dynamic> map = {};
    var count = 0;
    event.snapshot.children.forEach((element) {
      print('print worker complain list');
      print(count++);
      print(element.key);
      if (this.mounted) {
        setState(() {
          complainList.add(element.value);
          mapList.add({element.key: element.value});
          complainKeys.add(element.key.toString());
          originalComplainList.add(element.value);
        });
      }

      res.add(element.value);
    });

    print(res[0]["uid"]);
    print(complainKeys);
    print('after');
  }

  String dropdownValue = 'SortBy';
  var j = 0;

  @override
  void initState() {
    printFirebase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("constuctor");
    print(widget.latitude);
    print(widget.logitude);

    //Logic to insert here Distance lat log with worker
    for (var i in originalComplainList) {
      if (i["latitude"].toInt() == widget.latitude.toInt() &&
          i["longitude"].toInt() == widget.logitude.toInt()) {
        workerComplainList.add(i);
      }
    }
    return Scaffold(
      backgroundColor: const Color(0XFF006E7F),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8CB2E),
        actions: [
          DropdownButton<String>(
            value: dropdownValue,
            icon: const Icon(Icons.arrow_downward),
            elevation: 16,
            style: const TextStyle(color: Colors.blue),
            underline: Container(
              height: 2,
              color: Colors.blue,
            ),
            onChanged: (String? newValue) {
              List<dynamic> newcomplainList = [];
              if (newValue == "Registered") {
                for (var i in originalComplainList) {
                  if (i["status"] == "Registered") {
                    newcomplainList.add(i);
                  }
                }
                setState(() {
                  dropdownValue = newValue!;
                  complainList = newcomplainList;
                });
              }
              if (newValue == "Completed") {
                for (var i in originalComplainList) {
                  if (i["status"] == "Completed") {
                    newcomplainList.add(i);
                  }
                }
                setState(() {
                  dropdownValue = newValue!;
                  complainList = newcomplainList;
                });
              }
              if (newValue == "SortBy") {
                setState(() {
                  dropdownValue = newValue!;
                  complainList = originalComplainList;
                });
              }
            },
            items: <String>['SortBy', 'Registered', "Pending", "Completed"]
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          )
        ],
      ),
      body: Center(
        child: ListView(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var i in originalComplainList)
              Card1(i, updateState, widget.getUserId, mapList, widget.signOut)
          ],
        ),
      ),
    );
  }
}

class Card1 extends StatefulWidget {
  var title, description, status, lat, lang, cid;
  String key1 = "";
  String complainid = "";
  dynamic complain2;
  late Function getUserId;
  late Function signOut;
  dynamic complain_obj;
  List<Map<dynamic, dynamic>> mapList = [];
  Function deleteCard = (dynamic val) {};
  String keyid = '';

  Card1(dynamic complain, Function delcard, Function getuid,
      List<Map<dynamic, dynamic>> mList, Function signout) {
    title = complain['uid'];
    description = complain['dateTime'];
    status = complain['status'];
    lat = complain['latitude'];
    lang = complain['longitude'];
    complainid = complain['uid'];
    // key1=k;
    getUserId = getuid;
    complain2 = complain;
    signOut = signout;

    mapList = mList;
    deleteCard = delcard;
    complain_obj = complain;
  }

  @override
  State<Card1> createState() => _Card1State();
}

class _Card1State extends State<Card1> {
  final database = FirebaseDatabase.instanceFor(
      app: firebaseApp,
      databaseURL:
          'https://fyp-project-98f0f-default-rtdb.asia-southeast1.firebasedatabase.app');
  DatabaseReference ref = FirebaseDatabase.instance.ref("complaints");
  var address = "";
  @override
  void initState() {
    // TODO: implement initState

    _getAddress(widget.lat, widget.lang).then((value) {
      print(value.last.street);
      setState(() {
        address = value.last.street.toString() + value.last.locality.toString();
      });
    });
    super.initState();
  }

  Future<List<geo.Placemark>> _getAddress(double? lat, double? lang) async {
    //final coordinates = new Coordinates(lat, lang);
    List<geo.Placemark> placemarks =
        await geo.placemarkFromCoordinates(lat!, lang!);
    return placemarks;
  }

  @override
  Widget build(BuildContext context) {
    // for (var i in widget.mapList) {
    //   for (var entry in i.entries) {
    //     if (widget.title == entry.value['uid'] &&
    //         widget.lat == entry.value['latitude'] &&
    //         widget.lang == entry.value['longitude'] &&
    //         widget.status == entry.value['status']) {
    //         widget.keyid = entry.key;
    //         print("key in complainlist = " + widget.keyid);
    //
    //
    //     }
    //   }
    // }
    return ExpandableNotifier(
        child: Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF8CB2E),
                  shape: BoxShape.rectangle,
                ),
              ),
            ),
            ScrollOnExpand(
              scrollOnExpand: true,
              scrollOnCollapse: false,
              child: ExpandablePanel(
                theme: const ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToCollapse: true,
                ),
                header: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      address,
                    )),
                collapsed: Text(
                  "More Details...",
                  softWrap: true,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                expanded: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // for (var _ in Iterable.generate(5))
                    Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text(
                          widget.title,
                          softWrap: true,
                          overflow: TextOverflow.fade,
                        )),
                    Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text(
                          widget.status,
                          softWrap: true,
                          overflow: TextOverflow.fade,
                        )),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0XFF006E7F))),
                        child: Text(" Take a picture"),
                        onPressed: () {
                          String key = '';
                          for (var i in widget.mapList) {
                            for (var entry in i.entries) {
                              if (widget.title == entry.value['uid'] &&
                                  widget.lat == entry.value['latitude'] &&
                                  widget.lang == entry.value['longitude'] &&
                                  widget.status == entry.value['status']) {
                                key = entry.key;
                                widget.keyid = key;
                                print('key in loop' + key);
                              }
                            }
                          }
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WorkerRegisterComplaint(
                                  widget.signOut,
                                  widget.getUserId,
                                  widget.complain2,
                                  widget.keyid),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
                builder: (_, collapsed, expanded) {
                  return Padding(
                    padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: Expandable(
                      collapsed: collapsed,
                      expanded: expanded,
                      theme: const ExpandableThemeData(crossFadePoint: 0),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
