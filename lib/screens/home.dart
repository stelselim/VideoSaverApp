import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:videosaver/components/videoCart.dart';
import 'package:videosaver/utility/shareVideo.dart';
import 'package:videosaver/utility/sharedPreferences.dart';
import 'package:videosaver/utility/videoInfo.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

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
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 20),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Center(
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

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      var urlOfVideo = snapshot.data.elementAt(index);

                      return Slidable(
                        actionPane: SlidableDrawerActionPane(),
                        actionExtentRatio: 0.25,
                        secondaryActions: <Widget>[
                          IconSlideAction(
                            caption: 'Share',
                            color: Colors.green,
                            icon: Icons.share,
                            onTap: () async {
                              try {
                                await shareVideo(urlOfVideo);
                              } catch (e) {
                                print(e);
                              }
                            },
                          ),
                          IconSlideAction(
                            caption: 'Delete',
                            color: Colors.red,
                            icon: Icons.delete,
                            onTap: () async {
                              try {
                                await removeVideo(index);
                                setState(() {});
                              } catch (e) {
                                print(e);
                              }
                            },
                          ),
                        ],
                        child: FutureBuilder<Video>(
                          future: getVideoInfo(urlOfVideo),
                          builder: (context, snapshot) {
                            if (snapshot.data == null) {
                              return Container();
                            }
                            if (snapshot.hasError == null)
                              return Center(
                                child: Text("Problem"),
                              );

                            return VideoCard(
                              setStateParent: () => setState(() {}),
                              videoIndex: index,
                              video: snapshot.data,
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
