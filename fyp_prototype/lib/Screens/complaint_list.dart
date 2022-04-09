import 'package:expandable/expandable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:location/location.dart' as loc;
import '../main.dart';

class ComplaintList extends StatefulWidget {
  const ComplaintList({Key? key}) : super(key: key);

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

  Future<void> printFirebase() async {
    print("complain");
    DatabaseEvent event = await database.ref('complaints').once();
    //database.ref().child("complaints").once().then((value)=> print(value.));
    List<dynamic> res = [];
    Map<dynamic, dynamic> map = {};
    var count = 0;
    event.snapshot.children.forEach((element) {
      print('print');
      print(count++);
      print(element.value);
      if (this.mounted) {
        setState(() {
          complainList.add(element.value);
        });
      }
      res.add(element.value);
    });

    print(res[0]["uid"]);
    print('after');
  }

  @override
  void initState() {
    // TODO: implement initState
    printFirebase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF2C3539),
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(
              onPressed: () {
                {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Stack(
                            overflow: Overflow.visible,
                            children: <Widget>[
                              Positioned(
                                right: -40.0,
                                top: -40.0,
                                child: InkResponse(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: CircleAvatar(
                                    child: Icon(Icons.close),
                                    backgroundColor: Colors.red,
                                  ),
                                ),
                              ),
                              Form(
                                key: _formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.all(1.0),
                                      child: Text("Name"),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(6.0),
                                      child: TextFormField(),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(1.0),
                                      child: Text("Question"),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(6.0),
                                      child: TextFormField(),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: RaisedButton(
                                        child: Text("Ask"),
                                        onPressed: () {
                                          // if (_formKey.currentState.validate()) {
                                          //   _formKey.currentState.save();
                                          // }
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                }
              },
              icon: Icon(Icons.question_mark))
        ],
      ),
      body: Center(
        child: ListView(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var i in complainList)
              Card1(i['dateTime'], i['uid'], i['status'], i['latitude'],
                  i['longitude'])
          ],
        ),
      ),
    );
  }
}

class Card1 extends StatefulWidget {
  var title, description, status, lat, lang;
  Card1(var t, var d, var s, var l1, var l2) {
    title = t;
    description = d;
    status = s;
    lat = l1;
    lang = l2;
  }

  @override
  State<Card1> createState() => _Card1State();
}

class _Card1State extends State<Card1> {
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
                decoration: BoxDecoration(
                  color: Colors.lightGreenAccent,
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
                  "view answer",
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
                        child: Text("Edit"),
                        onPressed: () {},
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
