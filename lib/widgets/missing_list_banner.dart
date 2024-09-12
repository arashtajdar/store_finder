//**********************************************************************************
//BANNER FOR EMPTY LISTS
//**********************************************************************************

import 'package:flutter/material.dart';

class MissingListBanner extends StatelessWidget {
  final String message;
  final IconData icon;

  const MissingListBanner({
    Key? key,
    required this.message,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 50, color: Colors.grey.shade400),
          const SizedBox(height: 15),
          Text(
            message,
            style: TextStyle(
                fontSize: 20,
                color: Colors.grey.shade400,
                fontWeight: FontWeight.normal),
          ),
        ],
      ),
    );
  }
}
