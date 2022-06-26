import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:fyp_prototype/models/faq.dart';
import 'package:fyp_prototype/providers/faqProvider.dart';
import 'package:firebase_database/firebase_database.dart';

import '../main.dart';
import '../providers/faqProvider.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({Key? key}) : super(key: key);

  @override
  _FaqScreenState createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // Initial Selected Value
  String dropdownvalue = 'Item 1';
  final database = FirebaseDatabase.instanceFor(
      app: firebaseApp,
      databaseURL:
          'https://fyp-project-98f0f-default-rtdb.asia-southeast1.firebasedatabase.app');
  //DatabaseReference ref = FirebaseDatabase.instance.ref("complaints");
  FaqProvider myFaq = FaqProvider(
    FirebaseDatabase.instanceFor(
        app: firebaseApp,
        databaseURL:
            'https://fyp-project-98f0f-default-rtdb.asia-southeast1.firebasedatabase.app'),
  );
  TextEditingController _namedContreller = TextEditingController();

  DatabaseReference ref = FirebaseDatabase.instance.ref("faq");
  List<dynamic> FAQList = [];

  Future<void> GetFAQFirebase() async {
    print("complain");
    DatabaseEvent event = await database.ref('faq').once();
    //database.ref().child("complaints").once().then((value)=> print(value.));
    List<dynamic> res = [];
    Map<dynamic, dynamic> map = {};
    event.snapshot.children.forEach((element) {
      setState(() {
        FAQList.add(element.value);
      });
      //res.add( element.value);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    GetFAQFirebase();
    super.initState();
  }
  // List of items in our dropdown menu

  @override
  Widget build(BuildContext context) {
    print("in build");
    print(FAQList);
    return Scaffold(
      backgroundColor: const Color(0XFF006E7F),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8CB2E),
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
                                      child: Text("Ask your Question"),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.all(6.0),
                                        child: TextField(
                                          controller: _namedContreller,
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: RaisedButton(
                                        child: Text("Ask"),
                                        onPressed: () {
                                          print("FAQ pressed");
                                          FAQ tempVar = FAQ();
                                          tempVar.setQuestion(
                                              _namedContreller.text);
                                          tempVar.setAnswer("");
                                          tempVar.setCustomerId("UserID");
                                          myFaq.registerQuestion(tempVar);
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
            if (FAQList.length != 0)
              for (var i in FAQList) Card1(i['question'], i['answer'])
          ],
        ),
      ),
    );
  }
}

class Card1 extends StatelessWidget {
  var title, description;
  Card1(var t, var d) {
    title = t;
    description = d;
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
              height: 100,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.orange,
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
                      title,
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
                          description,
                          softWrap: true,
                          overflow: TextOverflow.fade,
                        )),
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
