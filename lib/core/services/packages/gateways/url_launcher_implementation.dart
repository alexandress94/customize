import 'package:url_launcher/url_launcher.dart';

import '../contracts/url_launcher.dart';

class UrlLaucherImplementation implements UrlLaucher {
  String _url =
      'mailto:alexandre.sobral94s@gmail.com?subject=Suporte Organize despesa&body=';

  @override
  Future<void> open() async {
    if (!await launch(_url,
        forceSafariVC: false, forceWebView: false, enableJavaScript: true)) {
      throw 'Could not launch $_url';
    }
  }
}
