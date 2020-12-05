import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:videosaver/utility/openYoutube.dart';
import 'package:videosaver/utility/videoInfo.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class VideoDetailScreen extends StatelessWidget {
  final Video video;
  const VideoDetailScreen({Key key, this.video}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final videoTitleTextStyle = TextStyle(
      fontWeight: FontWeight.w600,
      color: Colors.blueGrey.shade800,
      fontSize: 24,
    );
    final channelTextStyle = TextStyle(
      fontWeight: FontWeight.w700,
      color: Colors.blueGrey.shade600,
      fontSize: 20,
    );
    final videoViewsTextStyle = TextStyle(
      fontWeight: FontWeight.w600,
      color: Colors.green.shade800,
      fontSize: 18,
    );
    final videoDescriptionTextStyle = TextStyle(
      fontWeight: FontWeight.w500,
      color: Colors.black87,
      fontSize: 14,
    );
    return Container(
      color: Colors.black,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey.shade100,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CachedNetworkImage(
                      imageUrl: video.thumbnails.mediumResUrl,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.fitWidth,
                    ),
                    Positioned(
                      top: 90,
                      child: RaisedButton(
                        child: Icon(
                          Icons.play_arrow,
                          size: 60,
                        ),
                        onPressed: () async {
                          try {
                            await launchURL(video.url);
                          } catch (e) {
                            print(e);
                          }
                        },
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SelectableText(
                    video.title,
                    style: videoTitleTextStyle,
                  ),
                ),
                Divider(
                  height: 0.5,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, right: 15.0, top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 5.5 / 10,
                        child: SelectableText(
                          video.author,
                          style: channelTextStyle,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 3 / 10,
                        child: SelectableText(
                          viewFormatted(video.engagement.viewCount),
                          style: videoViewsTextStyle,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 40.0,
                    left: 15,
                    right: 15,
                    bottom: 20,
                  ),
                  child: SelectableText(
                    "Description:\n\n" + video.description,
                    style: videoDescriptionTextStyle,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
