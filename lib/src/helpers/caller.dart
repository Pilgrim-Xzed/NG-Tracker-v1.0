import 'package:url_launcher/url_launcher.dart' as URLLaucher;

abstract class URL {
  static launchURL(String url) async {
    url = Uri.encodeFull(url);
    if (await URLLaucher.canLaunch(url)) {
      await URLLaucher.launch(url);
    } else {
      throw 'Unknown error, can\'t launch the URL. Холбоост нэвтрэхэд алдаа гарлаа';
    }
  }
}