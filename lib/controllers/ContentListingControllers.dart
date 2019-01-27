import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:vod/sdk/Api.dart';
import 'dart:ui' as ui;
import 'package:vod/sdk/api/GetContentList.dart';
import 'package:vod/utils/Utils.dart';

class ContentListingController {
  final ContentListingListener listener;
  final PreferenceManager preferenceManager;

  ContentListingController({@required this.listener})
      : preferenceManager = PreferenceManager();

  Future callApi(String permalink, int offset, int limit, bool firstTime) async {
    ContentListModel contentList = await getContentListApi({
      "authToken": AUTH_TOKEN,
      "country": await preferenceManager.getCountryCodePrefs(),
      "permalink": permalink,
      "limit": limit.toString(),
      "offset": offset.toString(),
      "lang_code": "en",
      "order_by": "",
    });

//    listener.onApiSuccess(contentListData: contentList, isVertical: false);
//    await new Future.delayed(const Duration(milliseconds: 1200));
    Future<ui.Image> _getImage(String url) {
      try {
        Completer<ui.Image> completer = new Completer<ui.Image>();
        new NetworkImage(url).resolve(new ImageConfiguration()).addListener(
                (ImageInfo info, bool _) => completer.complete(info.image));
        return completer.future;
      } catch (e) {
        print(e);
        return null;
      }
    }
    if (firstTime) {
      ui.Image image = await _getImage(contentList.movieList[0].posterUrl);
      if (image.width > image.height) {
        listener.onApiSuccess(contentListData: contentList, isVertical: false, firstTime: firstTime);
      } else {
        listener.onApiSuccess(contentListData: contentList, isVertical: true, firstTime: firstTime);
      }
    } else {
      listener.onApiSuccess(contentListData: contentList, isVertical: true, firstTime: firstTime);
    }
  }
}

abstract class ContentListingListener {
  void onApiFailure({@required Failures failure});

  void onApiSuccess(
      {@required ContentListModel contentListData, bool isVertical, bool firstTime});
}

enum Failures { NO_INTERNET, UNKNOWN }
