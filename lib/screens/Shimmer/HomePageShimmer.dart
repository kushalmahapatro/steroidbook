import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vod/utils/Constants.dart';

class HomePageShimmer extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    Widget shimmerSection = new Padding(
      padding: EdgeInsets.only(left: 10.0, top: 20.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(padding: EdgeInsets.only(bottom: 10.0), child:
              Container(
                color: Colors.grey,
                width: 100.0,
                height: 20.0,
              ))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(padding: EdgeInsets.only(right: 10.0),
                child: Container(
                  width: HR_WIDTH,
                  height: HR_HEIGHT,
                  color: Colors.grey,
                ),),
              Padding(padding: EdgeInsets.only(right: 10.0),
                child: Container(
                  width: HR_WIDTH,
                  height: HR_HEIGHT,
                  color: Colors.grey,
                ),)
            ],
          )
        ],
      ),
    );

    return Container(
        child: Center(
          child:
          /*ColorLoaderPlain(
              colors: loaderColors,
              duration: Duration(milliseconds: 1200),
            )*/
          Shimmer.fromColors(
              child: Column(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: 900 / (1600 / screenWidth),
                    color: Colors.grey,
                  ),
                  shimmerSection,
                  shimmerSection,
                ],
              ),
              baseColor: Colors.grey.withOpacity(0.5),
              highlightColor: Colors.grey.withOpacity(0.7)),
        ));
  }

}