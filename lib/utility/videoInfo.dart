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
