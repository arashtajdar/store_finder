//**********************************************************************************
//DETAIL SECTION TITLE
//About, gallery, location and website (Icon + Name)
//To customize names go to 'customize_here.dart'
//**********************************************************************************

import 'package:flutter/material.dart';
import 'package:store_finder/utilities/customize_here.dart';

class SectionTitle extends StatelessWidget {
  final IconData sectionIcon;
  final String sectionName;
  const SectionTitle({
    Key? key,
    required this.sectionIcon,
    required this.sectionName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          sectionIcon,
          size: 20,
          color: Customize().mainAppColor,
        ),
        const SizedBox(width: 5),
        Text(sectionName,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            )),
      ],
    );
  }
}
