import 'package:youtube_explode_dart/youtube_explode_dart.dart';

Future<Video> getVideoInfo(String url) async {
  // You can provider either a video ID or URL as String or an instance of `VideoId`.
  try {
    var video = await YoutubeExplode().videos.get(url);
    return video;
  } catch (e) {
    print(e);
    return null;
  }
}

String viewFormatted(int views) {
  if (views > 1000000000) {
    return (views / 1000000000).toStringAsFixed(1).toString() + "B Views";
  }
  if (views > 1000000) {
    return (views / 1000000).toStringAsFixed(1).toString() + "M Views";
  }
  if (views > 1000) {
    return (views / 1000).toStringAsFixed(1).toString() + "K Views";
  }
  if (views < 1000) {
    return views.toString() + " Views";
  }
  return (views / 1000).toStringAsFixed(1).toString() + "K Views";
}
