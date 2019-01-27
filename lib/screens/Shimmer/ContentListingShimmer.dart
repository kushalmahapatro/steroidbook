import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vod/utils/Constants.dart';

class ContentListingShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    Widget shimmerSection = new Padding(
      padding: EdgeInsets.only(left: 10.0, top: 20.0, right: 10.0),
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: Container(
              width: HR_WIDTH,
              height: HR_HEIGHT,
              color: Colors.grey,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: Container(
              width: HR_WIDTH,
              height: HR_HEIGHT,
              color: Colors.grey,
            ),
          )
        ],
      ),
    );

    List<Widget> shimmer = new List();
    for (int i = 0 ; i< (screenHeight ~/ VR_HEIGHT); i++){
      shimmer.add(shimmerSection);
    }
    return Container(
        child: Center(
      child: Shimmer.fromColors(
          child: Column(
            children: shimmer,
          ),
          baseColor: Colors.grey.withOpacity(0.3),
          highlightColor: Colors.grey.withOpacity(0.5)),
    ));
  }
}
