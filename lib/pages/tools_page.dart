import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:settings_ui/settings_ui.dart';

import '../constants.dart';
import '../generated/l10n.dart';
import '../helper.dart';
import '../widgets/dailog.dart';
import 'home.dart';

class ToolsPage extends StatelessWidget {
  ToolsPage(this.controller, CookieManager? cookieManager,
      {Key? key, required this.notifyParent})
      : cookieManager = cookieManager ?? CookieManager.instance(),
        super(key: key);

  final Function() notifyParent;
  final InAppWebViewController controller;
  late final CookieManager cookieManager;

  Future<void> _onHttpRedirect(InAppWebViewController controller) async {
    if (!inKancolleWindow) {
      String? currentUrl = await controller.getUrl().toString();
      if (currentUrl.toString().endsWith(kGameUrl)) {
        // May be HTTPS or HTTP
        allowNavi = true;
        if (Platform.isIOS) {
          await controller.evaluateJavascript(
              source: '''window.open("http:"+gadgetInfo.URL,'_blank');''');
        }
        inKancolleWindow = true;
      }
      Fluttertoast.showToast(msg: S.current.KCViewFuncMsgAutoGameRedirect);
      print("HTTP Redirect success");
    } else {
      Fluttertoast.showToast(msg: S.current.KCViewFuncMsgAlreadyGameRedirect);
      print("HTTP Redirect fail");
    }
    print("inKancolleWindow: $inKancolleWindow");
  }

  Future<void> _onClearCache(
      BuildContext context, InAppWebViewController controller) async {
    bool? value = await showDialog(
        context: context,
        builder: (context) {
          return CustomAlertDialog(
              msg: S.current.AppClearCache.replaceAll('\n', ''),
              isNormal: true);
        });
    if (value ?? false) {
      allowNavi = true;
      await controller.clearCache();
      Fluttertoast.showToast(msg: S.current.AppLeftSideControlsClearCache);
    }
  }

  Future<void> _onClearCookies(BuildContext context) async {
    bool? value = await showDialog(
        context: context,
        builder: (context) {
          return CustomAlertDialog(
              msg: S.current.AppClearCookie, isNormal: true);
        });
    if (value ?? false) {
      await cookieManager.deleteAllCookies();
      String message = S.current.AppLeftSideControlsLogoutSuccess;
      Fluttertoast.showToast(msg: message);
    }
  }

  Future<void> _onAdjustWindow(InAppWebViewController controller) async {
    if (gameLoadCompleted) {
      await autoAdjustWindowV2(controller);
    } else {
      Fluttertoast.showToast(
          msg: S.current.KCViewFuncMsgNaviGameLoadNotCompleted);
    }
  }

  Future<void> _onMuteGame(InAppWebViewController controller) async {
    await controller.evaluateJavascript(source: '''document.cookie=
    "kcs_options=vol_bgm%3D0%3Bvol_se%3D0%3Bvol_voice%3D0%3Bv_be_left%3D1%3Bv_duty%3D1;expires=Thu, 1-Jan-2099 00:00:00 GMT;path=/;domain=dmm.com"
	''');
    Fluttertoast.showToast(msg: S.current.MsgMuteGame);
  }

  Future<void> _onUnmuteGame(InAppWebViewController controller) async {
    await controller.evaluateJavascript(source: '''	document.cookie=
    "kcs_options=vol_bgm%3D30%3Bvol_se%3D40%3Bvol_voice%3D60%3Bv_be_left%3D1%3Bv_duty%3D1;expires=Thu, 1-Jan-2099 00:00:00 GMT;path=/;domain=dmm.com"''');
    Fluttertoast.showToast(msg: S.current.MsgUnmuteGame);
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, bool innerBoxIsScrolled) {
        return [
          CupertinoSliverNavigationBar(
            largeTitle: Text(S.current.ToolsButton),
          ),
        ];
      },
      body: SettingsList(
        sections: [
          SettingsSection(
            title: Text(S.of(context).ToolTitleWeb),
            tiles: [
              SettingsTile.navigation(
                leading: const Icon(CupertinoIcons.rectangle_expand_vertical),
                title: Text(S.of(context).AppRedirect),
                onPressed: (context) {
                  HapticFeedback.heavyImpact();
                  _onHttpRedirect(controller);
                },
              ),
              SettingsTile.navigation(
                leading: const Icon(CupertinoIcons.delete),
                title: Text(S.of(context).AppClearCache),
                onPressed: (context) {
                  HapticFeedback.heavyImpact();
                  _onClearCache(context, controller);
                },
              ),
              SettingsTile.navigation(
                leading: const Icon(CupertinoIcons.square_arrow_left),
                title: Text(S.of(context).AppClearCookie),
                onPressed: (context) {
                  HapticFeedback.heavyImpact();
                  _onClearCookies(context);
                },
              ),
            ],
          ),
          SettingsSection(
            title: Text(S.of(context).ToolTitleGameSound),
            tiles: [
              SettingsTile.navigation(
                leading: const Icon(CupertinoIcons.volume_down),
                title: Text(S.of(context).GameUnmute),
                onPressed: (context) {
                  HapticFeedback.heavyImpact();
                  _onUnmuteGame(controller);
                },
              ),
              SettingsTile.navigation(
                leading: const Icon(CupertinoIcons.volume_off),
                title: Text(S.of(context).GameMute),
                onPressed: (context) {
                  HapticFeedback.heavyImpact();
                  _onMuteGame(controller);
                },
              ),
            ],
          ),
          SettingsSection(
            title: Text(S.of(context).ToolTitleGameScreen),
            tiles: [
              SettingsTile.navigation(
                leading: const Icon(CupertinoIcons.fullscreen),
                title: Text(S.of(context).AppResize),
                onPressed: (context) {
                  HapticFeedback.heavyImpact();
                  _onAdjustWindow(controller);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
