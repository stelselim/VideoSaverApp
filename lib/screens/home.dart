import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:videosaver/utility/sharedPreferences.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final videoAddController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent.shade400,
        title: Text("Your Video List"),
        actions: [
          IconButton(
            icon: Icon(
              CupertinoIcons.delete,
              size: 25,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => CupertinoAlertDialog(
                  title: Text("Would You Like to Delete All Videos?"),
                  actions: [
                    FlatButton(
                      child: Text("No"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    FlatButton(
                      child: Text("Yes"),
                      onPressed: () async {
                        try {
                          await clearVideoList();
                          Navigator.pop(context);
                          setState(() {});
                        } catch (e) {
                          print(e);
                        }
                      },
                    )
                  ],
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(
              CupertinoIcons.add,
              size: 30,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  FlutterClipboard.paste().then((value) {
                    setState(() {
                      videoAddController.text = value;
                    });
                  }).catchError((e) => print(e));
                  return AlertDialog(
                    title: Container(
                      // height: 150,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Paste Your Video URL!"),
                          SizedBox(height: 15),
                          CupertinoTextField(
                            controller: videoAddController,
                            style: CupertinoTextThemeData().textStyle,
                            suffix: GestureDetector(
                              child: Icon(Icons.paste),
                              onTap: () {
                                FlutterClipboard.paste().then((value) {
                                  setState(() {
                                    videoAddController.text = value;
                                  });
                                }).catchError((e) => print(e));
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    actions: [
                      FlatButton(
                        child: Text("Cancel"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      FlatButton(
                        child: Text("Save"),
                        onPressed: () async {
                          try {
                            await saveVideo(videoAddController.text);
                            videoAddController.clear();
                            Navigator.pop(context);
                            setState(() {});
                          } catch (e) {
                            print(e);
                          }
                        },
                      )
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Center(
        child: StreamBuilder<List<String>>(
          stream: getVideoList.asStream(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Center(child: Text("No Video Addded"));
            }
            if (snapshot.hasError == null)
              return Center(
                child: Text("Problem"),
              );
            if (snapshot.data.length == 0) return Text("No Video Addded");
            return Column(
              children: snapshot.data.map((e) => Text(e)).toList(),
            );
          },
        ),
      ),
    );
  }
}
