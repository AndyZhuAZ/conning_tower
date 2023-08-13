import 'package:conning_tower/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:yaml/yaml.dart';

import 'package:conning_tower/providers/webview_provider.dart';

class KancolleDataModal extends ConsumerStatefulWidget {
  const KancolleDataModal({Key? key}) : super(key: key);



  @override
  ConsumerState<KancolleDataModal> createState() => _KancolleDataModalState();
}

class _KancolleDataModalState extends ConsumerState<KancolleDataModal> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

@override
  Widget build(BuildContext context) {
    final data = ref.watch(dataProvider);
    return Material(
        child: CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
              leading: Container(), middle: Text('Kancolle Data')),
          child: SafeArea(child: SingleChildScrollView(child: Text(data))),
        ));
  }
}

class ModalFit extends StatelessWidget {
  final List<Widget> children;

  const ModalFit({Key? key, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: children,
        ),
      ),
    );
  }
}

class ComplexModal extends StatelessWidget {
  final Widget child;

  const ComplexModal({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: WillPopScope(
        onWillPop: () async {
          bool shouldClose = true;
          await showCupertinoDialog(
              context: context,
              builder: (context) => CupertinoAlertDialog(
                    title: Text(S.of(context).TextShouldClose),
                    actions: <Widget>[
                      CupertinoButton(
                        child: Text(S.current.TextNo),
                        onPressed: () {
                          shouldClose = false;
                          Navigator.of(context).pop();
                        },
                      ),
                      CupertinoButton(
                        child: Text(S.current.TextYes),
                        onPressed: () {
                          shouldClose = true;
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ));
          return shouldClose;
        },
        child: child,
      ),
    );
  }
}
