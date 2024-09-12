//***********************************************************************************************************
//DETAILS AB0UT - TEXT SECTION
//***********************************************************************************************************

import 'package:flutter/material.dart';
import 'package:store_finder/utilities/customize_here.dart';
import 'section_title.dart';

class DetailsAbout extends StatelessWidget {
  final String about;
  const DetailsAbout({Key? key, required this.about}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        SectionTitle(
          sectionIcon: Icons.info_outline,
          sectionName: Customize.aboutSection,
        ),
        const SizedBox(height: 20),
        Text(
          about,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey.shade600,
            height: 1.6,
          ),
        ),
      ],
    );
  }
}
