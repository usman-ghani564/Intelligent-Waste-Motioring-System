import 'package:flutter/material.dart';
//import 'package:footer/footer.dart';
//import 'package:footer/footer_view.dart';
import 'package:expandable/expandable.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({Key? key}) : super(key: key);

  @override
  _FaqScreenState createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // Initial Selected Value
  String dropdownvalue = 'Item 1';

  // List of items in our dropdown menu
  var items = [
    {
      'title': 'How to Register complain',
      'description':
          'First login or sign up through our app then click on register complain our application will prompt you that it will access your camera click ok then take a picture then click ok to register complain '
    },
    {
      'title': 'How to Register complain',
      'description':
          'First login or sign up through our app then click on register complain our application will prompt you that it will access your camera click ok then take a picture then click ok to register complain '
    },
    {
      'title': 'How to Register complain',
      'description':
          'First login or sign up through our app then click on register complain our application will prompt you that it will access your camera click ok then take a picture then click ok to register complain '
    },
    {
      'title': 'How to Register complain',
      'description':
          'First login or sign up through our app then click on register complain our application will prompt you that it will access your camera click ok then take a picture then click ok to register complain '
    },
  ];
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
            for (var i in items) Card1(i['title'], items[0]['description'])
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
