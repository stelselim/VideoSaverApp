import 'package:shared_preferences/shared_preferences.dart';

const String videoKey = "videoKey";

Future removeVideo(int index) async {
  final instance = await SharedPreferences.getInstance();
  var listVideo = instance.getStringList(videoKey);
  print("Before: " + listVideo.length.toString());
  listVideo.removeAt(index);
  print("After: " + listVideo.length.toString());
  await instance.setStringList(videoKey, listVideo);
}

Future saveVideo(String url) async {
  final instance = await SharedPreferences.getInstance();
  final listVideo = instance.getStringList(videoKey);

  if (!url.contains("youtube") &&
      !url.contains("youtu.be") &&
      !url.contains("ytimg")) {
    print("Not Right URL");
    return;
  }
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
