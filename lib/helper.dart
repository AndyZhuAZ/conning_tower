import 'dart:io';
import 'dart:math';

import 'package:conning_tower/pages/home.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'constants.dart';
import 'generated/l10n.dart';

Future<bool> autoAdjustWindow(
  WebViewController controller,
) async {
  //Adjust Kancolle window
  if (inKancolleWindow && !autoAdjusted) {
    int getWebviewSizeCount = 0;
    do {
      controller.runJavascriptReturningResult('''window.innerHeight;''').then(
          (value) => kWebviewHeight = double.parse(value));
      controller.runJavascriptReturningResult('''window.innerWidth;''').then(
          (value) => kWebviewWidth = double.parse(value));
      if (kWebviewHeight == 0.0 || kWebviewWidth == 0.0) {
        await Future.delayed(const Duration(seconds: 2));
      } else {
        getWebviewSizeCount = 99;
      }
      print("obtaining webview size");
      getWebviewSizeCount++;
    } while (getWebviewSizeCount < 5);
    var resizeScale = 1.0;
    if (kWebviewHeight != null && kWebviewWidth != null) {
      resizeScale = getResizeScale(kWebviewHeight, kWebviewWidth);
      autoAdjusted = true;
    } else {
      print("autoAdjustWindow fail");
      return false;
    }
    await controller.runJavascript(
        '''document.getElementById("spacing_top").style.display = "none";''');
    await controller.runJavascript(
        '''document.getElementById("sectionWrap").style.display = "none";''');
    await controller.runJavascript(
        '''document.getElementById("flashWrap").style.backgroundColor = "black";''');
    await controller
        .runJavascript('''document.body.style.backgroundColor = "black";''');

    if (Platform.isIOS) {
      await controller.runJavascript(
          //Scale to correct size(ios webkit)
          '''document.getElementById("htmlWrap").style.webkitTransform = "scale($resizeScale,$resizeScale)";''');
    } else if (Platform.isAndroid) {
      await controller.runJavascript(//Scale to correct size(android chrome)
          '''document.getElementById("htmlWrap").style.transform = "scale($resizeScale,$resizeScale)";''');
    }
    Fluttertoast.showToast(msg: S.current.FutureAutoAdjustWindowSuccess);
    print("Auto adjust success");
    allowNavi = false;
    return true;
  }
  print("autoAdjustWindow fail");
  return false;
}

getResizeScale(double height, double width) {
  //Get Kancolle iframe resize scale
  var scale = (height * width) / kKancollePixel;
  if (scale < 0.5) {
    scale = 1 - scale;
    return sqrt(scale);
  } else {
    while (kKancolleWidth * scale > kWebviewWidth ||
        kKancolleHeight * scale > kWebviewHeight) {
      scale = scale - 0.05;
    }
    return scale;
  }
}
