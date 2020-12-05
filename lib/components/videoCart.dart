import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:videosaver/screens/videoDetailScreen.dart';
import 'package:videosaver/style/textStyles.dart';
import 'package:videosaver/utility/sharedPreferences.dart';
import 'package:videosaver/utility/videoInfo.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class VideoCard extends StatelessWidget {
  final Function setStateParent;
  final Video video;
  final int videoIndex;

  const VideoCard({
    Key key,
    @required this.video,
    @required this.videoIndex,
    @required this.setStateParent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title = video.title;
    final channelName = video.author;
    final views = video.engagement.viewCount;

    final videoTitleTextStyle = TextStyle(
      fontWeight: FontWeight.w600,
      color: Colors.blueGrey.shade800,
      fontSize: 15,
    );
    final channelTextStyle = TextStyle(
      fontWeight: FontWeight.w500,
      color: Colors.blueGrey.shade900,
      fontSize: 13,
    );
    final videoViewsTextStyle = TextStyle(
      fontWeight: FontWeight.w600,
      color: Colors.green.shade800,
      fontSize: 12,
    );

    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: GestureDetector(
        onTap: () {
          print("Tapped");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VideoDetailScreen(
                video: video,
              ),
            ),
          );
        },
        child: Row(
          children: [
            // Thumbnail
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.all(8),
                child: CachedNetworkImage(
                  imageUrl: video.thumbnails.mediumResUrl,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            // Video Details
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.only(right: 5),
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: videoTitleTextStyle,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    SizedBox(height: 3),
                    Text(
                      channelName,
                      style: channelTextStyle,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          viewFormatted(views),
                          style: videoViewsTextStyle,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
