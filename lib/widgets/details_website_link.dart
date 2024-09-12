//**********************************************************************************
//DETAILS WEBSITE CLICKABLE LINK
//**********************************************************************************
import 'package:flutter/material.dart';
import 'package:store_finder/utilities/contact_functions.dart';
import 'package:store_finder/utilities/customize_here.dart';
import 'section_title.dart';

class DetailsWebsiteLink extends StatelessWidget {
  final String websiteLink;

  const DetailsWebsiteLink({
    Key? key,
    required this.websiteLink,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          sectionIcon: Icons.web_asset_outlined,
          sectionName: Customize.websiteSection,
        ),
        const SizedBox(height: 15),
        GestureDetector(
          child: Text(
            websiteLink,
            style: const TextStyle(
                color: Colors.blue,
                fontSize: 18,
                decoration: TextDecoration.underline),
          ),
          onTap: () async {
            openUrl('https://$websiteLink');
          },
        ),
        const SizedBox(height: 100)
      ],
    );
  }
}
