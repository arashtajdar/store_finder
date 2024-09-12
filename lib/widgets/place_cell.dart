//**********************************************************************************
//CUSTOM LIST TILE FOR PLACES
//**********************************************************************************

import 'package:flutter/material.dart';
import 'package:store_finder/models/place_model.dart';
import 'package:store_finder/screens/details_main.dart';

class PlaceCell extends StatelessWidget {
  const PlaceCell({
    Key? key,
    required this.snapList,
    required this.index,
  }) : super(key: key);

  final List<PlaceModel> snapList;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 15),
      title: Text(
        snapList[index].name,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        snapList[index].address,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      leading: SizedBox(
        height: 70,
        width: 70,
        child: CircleAvatar(
          //radius: 35,
          backgroundImage: NetworkImage(snapList[index].thumbnail),
        ),
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DetailsMain(
              placeSelected: snapList[index],
            ),
          ),
        );
      },
    );
  }
}
