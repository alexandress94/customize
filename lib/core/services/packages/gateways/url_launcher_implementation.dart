import 'package:url_launcher/url_launcher.dart';

import '../contracts/url_launcher.dart';

class UrlLaucherImplementation implements UrlLaucher {
  @override
  Future<void> open() async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: 'help.customize@gmail.com',
      query: 'subject=Suporte Customize&body=', //add subject and body here
    );

    if (!await canLaunchUrl(params)) {
      await launchUrl(params);
    } else {
      throw 'Could not launch $params';
    }
  }
}
