//**********************************************************************************
//USER CONFIGURATION FILE
//General Color and tab names
//**********************************************************************************

import 'package:flutter/material.dart';
import 'package:store_finder/utilities/create_material_color.dart';

class Customize {
//APPLICATION COLORS
  var mainAppColor = createMaterialColor(
    const Color.fromARGB(255, 76, 175, 80),
  );

//NAVIGATION SECTION NAMES (BOTTOM TAB AND TITLES)
  static String mapSection = 'Locations';
  static String categoriesSection = 'Categories';
  static String newsSection = 'News';

//DETAILS SECTION NAMES
  static String aboutSection = 'About';
  static String gallerySection = 'Gallery';
  static String locationSection = 'Location';
  static String websiteSection = 'Website';
}
