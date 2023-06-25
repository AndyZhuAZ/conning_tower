import 'package:conning_tower/app.dart';
import 'package:conning_tower/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences localStorage;
final InAppLocalhostServer localhostServer = InAppLocalhostServer(
    documentRoot: 'assets/www', directoryIndex: 'home.html');
late bool safeNavi;
late bool autoAdjusted;
late bool bottomPadding;
late bool gameLoadCompleted;
late bool inKancolleWindow;
late bool beforeRedirect;
late double kWebviewHeight;
late double kWebviewWidth;
late int selectedIndex;
late Uri home;
late bool enableAutoProcess;
late bool enableAutoLoadHomeUrl;
late String customHomeUrl;
late String customUA;
late bool enableHideFAB;
late bool showControls;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    // start the localhost server
    await localhostServer.start();
  }

  if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
    await InAppWebViewController.setWebContentsDebuggingEnabled(true);
  }
  WebView.debugLoggingSettings.enabled = false;
  localStorage = await SharedPreferences.getInstance();

  gameLoadCompleted = false;
  inKancolleWindow = false;
  autoAdjusted = false;
  kWebviewHeight = 0.0;
  kWebviewWidth = 0.0;
  safeNavi = false;
  bottomPadding = false;
  selectedIndex = 0;
  enableAutoLoadHomeUrl = true;
  customHomeUrl = kGameUrl;
  customUA = '';
  enableAutoProcess = true;
  enableHideFAB = false;
  showControls = true;

  SystemChrome.setPreferredOrientations(DeviceOrientation.values)
      .then((value) => runApp(const ProviderScope(child: ConnTowerApp())));
}
