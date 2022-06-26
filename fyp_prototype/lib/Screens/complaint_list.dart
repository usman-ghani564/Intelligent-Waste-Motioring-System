import 'package:expandable/expandable.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geo;
import '../main.dart';
import '../providers/complaint_provider.dart';

class ComplaintList extends StatefulWidget {
  late Function getUserId;
  ComplaintList(Function getuid) {
    getUserId = getuid;
  }

  @override
  State<ComplaintList> createState() => _ComplaintListState();
}

class _ComplaintListState extends State<ComplaintList> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final database = FirebaseDatabase.instanceFor(
      app: firebaseApp,
      databaseURL:
          'https://fyp-project-98f0f-default-rtdb.asia-southeast1.firebasedatabase.app');
  DatabaseReference ref = FirebaseDatabase.instance.ref("complaints");
  List<dynamic> complainList = [];
  List<String> complainKeys = [];
  List<dynamic> originalComplainList = [];
  List<Map<dynamic, dynamic>> mapList = [];

  updateState(dynamic val) async {
    setState(() {
      complainList.remove(val);

      originalComplainList.remove(val);
    });
  }

  Future<void> printFirebase() async {
    DatabaseEvent event = await database.ref('complaints').once();
    //database.ref().child("complaints").once().then((value)=> print(value.));
    List<dynamic> res = [];
    Map<dynamic, dynamic> map = {};
    var count = 0;
    event.snapshot.children.forEach((element) {
      if (mounted) {
        setState(() {
          mapList.add({element.key: element.value});
          complainList.add(element.value);
          complainKeys.add(element.key.toString());
          originalComplainList.add(element.value);
        });
      }
      res.add(element.value);
    });
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
            for (var i in complainList)
              Card1(i, updateState, widget.getUserId, mapList)
          ],
        ),
      ),
    );
  }
}

class Card1 extends StatefulWidget {
  var title, description, status, lat, lang, cid, imageUrl;
  String key1 = "";
  dynamic complain2;
  dynamic complain_obj;
  Function deleteCard = (dynamic val) {};
  late Function getUserId;
  List<Map<dynamic, dynamic>> mapList = [];

  Card1(dynamic complain, Function delcard, Function getuid,
      List<Map<dynamic, dynamic>> mList) {
    print(complain['imageUrl']);
    title = complain['uid'];
    description = complain['dateTime'];
    status = complain['status'];
    lat = complain['latitude'];
    lang = complain['longitude'];
    imageUrl = complain['imageUrl'];
    // key1=k;
    deleteCard = delcard;
    complain_obj = complain;
    getUserId = getuid;
    complain2 = complain;
    mapList = mList;
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
                decoration: const BoxDecoration(
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
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(widget.imageUrl),
                                fit: BoxFit.cover),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(100),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          child: Text(
                            address,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    )),
                collapsed: const Text(
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
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          widget.description,
                          softWrap: true,
                          overflow: TextOverflow.fade,
                        )),
                    Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          'status: ' + widget.status,
                          softWrap: true,
                          overflow: TextOverflow.fade,
                        )),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    const Color(0XFF006E7F))),
                            child: const Text("Cancel Complaint"),
                            onPressed: () {
                              ComplaintProvider complaintProvider =
                                  ComplaintProvider(
                                FirebaseDatabase.instanceFor(
                                    app: firebaseApp,
                                    databaseURL:
                                        'https://fyp-project-98f0f-default-rtdb.asia-southeast1.firebasedatabase.app'),
                                widget.getUserId,
                              );
                              String key = '';
                              for (var i in widget.mapList) {
                                for (var entry in i.entries) {
                                  if (widget.title == entry.value['uid'] &&
                                      widget.lat == entry.value['latitude'] &&
                                      widget.lang == entry.value['longitude'] &&
                                      widget.status == entry.value['status']) {
                                    key = entry.key;
                                  }
                                }
                              }
                              complaintProvider.editComplaint(
                                  key, widget.complain2, 'Canceled');
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.red)),
                            child: const Text("delete"),
                            onPressed: () {
                              ComplaintProvider complaintProvider =
                                  ComplaintProvider(
                                FirebaseDatabase.instanceFor(
                                    app: firebaseApp,
                                    databaseURL:
                                        'https://fyp-project-98f0f-default-rtdb.asia-southeast1.firebasedatabase.app'),
                                widget.getUserId,
                              );
                              String key = '';
                              for (var i in widget.mapList) {
                                for (var entry in i.entries) {
                                  if (widget.title == entry.value['uid'] &&
                                      widget.lat == entry.value['latitude'] &&
                                      widget.lang == entry.value['longitude'] &&
                                      widget.status == entry.value['status']) {
                                    key = entry.key;
                                  }
                                }
                              }
                              complaintProvider.removeComplaint(key);
                            },
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                builder: (_, collapsed, expanded) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 10),
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
