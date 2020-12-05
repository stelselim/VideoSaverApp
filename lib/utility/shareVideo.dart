import 'package:share/share.dart';

Future shareVideo(String url) async {
  await Share.share('$url');
}
