import 'package:shared_preferences/shared_preferences.dart';

const String videoKey = "videoKey";

Future removeVideo(String url) async {
  final instance = await SharedPreferences.getInstance();
  final listVideo = instance.getStringList(videoKey);
  listVideo.remove(url);
  await instance.setStringList(videoKey, listVideo);
}

Future saveVideo(String url) async {
  final instance = await SharedPreferences.getInstance();
  final listVideo = instance.getStringList(videoKey);
  print("Before: " + listVideo.toString());

  if (listVideo == null) {
    var toAdd = [url];
    await instance.setStringList(videoKey, toAdd);
  } else {
    listVideo.add(url);
    await instance.setStringList(videoKey, listVideo);
  }
  print("After: " + listVideo.toString());
}

Future clearVideoList() async {
  final instance = await SharedPreferences.getInstance();
  await instance.remove(videoKey);
}

Future<List<String>> get getVideoList async {
  final instance = await SharedPreferences.getInstance();
  final listVideo = instance.getStringList(videoKey);
  return listVideo;
}
