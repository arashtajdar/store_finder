//**********************************************************************************
//GENERAL CONTACT FUNCTION
//Recieves urls, phones and emails
//**********************************************************************************

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:url_launcher/url_launcher.dart';

openUrl(url) async {
  final Uri finalUrl = Uri.parse(url);
  if (await canLaunchUrl(finalUrl)) {
    await launchUrl(finalUrl);
  } else {
    EasyLoading.showError('Error performing action');
  }
}
