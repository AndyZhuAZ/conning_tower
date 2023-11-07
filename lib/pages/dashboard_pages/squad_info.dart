import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conning_tower/generated/l10n.dart';
import 'package:conning_tower/helper.dart';
import 'package:conning_tower/models/feature/dashboard/kancolle/ship.dart';
import 'package:conning_tower/providers/kancolle_data_provider.dart';
import 'package:conning_tower/utils/local_navigator.dart';
import 'package:conning_tower/widgets/components/label.dart';
import 'package:conning_tower/widgets/dialog.dart';
import 'package:conning_tower/widgets/input_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

const _sectionMargin = EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 10.0, 10.0);

class SquadInfo extends ConsumerStatefulWidget {
  const SquadInfo({super.key});

  @override
  ConsumerState createState() => _SquadInfoState();
}

class _SquadInfoState extends ConsumerState<SquadInfo> {
  int _selectedSegment = 0;
  late Map<int, Widget> segments;

  String speedLevel(speed) {
    if (speed == 5) return S.current.TextSlowSpeed;
    if (speed == 10) return S.current.TextFastSpeed;
    if (speed == 15) return S.current.TextFastPlusSpeed;
    if (speed == 20) return S.current.TextFastestSpeed;
    return 'N/A';
  }

  @override
  Widget build(BuildContext context) {
    final PageController controller =
        PageController(initialPage: _selectedSegment);
    var data = ref.watch(kancolleDataProvider);
    var squads = data.squads;
    final shipInfo = data.dataInfo.shipInfo;

    segments = {
      for (var element in squads)
        squads.indexOf(element):
            Text(element.name, style: const TextStyle(fontSize: 14))
    };

    return SafeArea(
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(5.0, 10.0, 0.0, 10.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: LocalNavigatorBuilder(builder: (context) {
            return CupertinoPageScaffold(
              navigationBar: CupertinoNavigationBar(
                automaticallyImplyLeading: false,
                transitionBetweenRoutes: false,
                backgroundColor: Colors.transparent,
                border: null,
                middle: segments.length >= 2
                    ? CupertinoSlidingSegmentedControl(
                        groupValue: _selectedSegment,
                        onValueChanged: (int? value) {
                          if (value != null) {
                            setState(() {
                              _selectedSegment = value;
                              controller.animateToPage(value,
                                  duration: const Duration(milliseconds: 200),
                                  curve: Curves.ease);
                            });
                          }
                        },
                        children: segments,
                      )
                    : null,
              ),
              child: SafeArea(
                child: PageView(
                  controller: controller,
                  onPageChanged: (value) {
                    setState(() {
                      _selectedSegment = value;
                    });
                  },
                  children: List.generate(squads.length, (index) {
                    var squad = squads[index];
                    if (squad.ships.isNotEmpty) {
                      List<int> speedList = [];
                      List<int> attackList = [];
                      List<int> antiAircraftList = [];
                      List<int> levelList = [];
                      List<int> antiSubmarineList = [];
                      List<int> scoutList = [];
                      for (var ship in squad.ships) {
                        speedList.add(ship.speed!);
                        attackList.add(ship.attack![0]);
                        antiAircraftList.add(ship.antiAircraft![0]);
                        levelList.add(ship.level);
                        antiSubmarineList.add(ship.antiSubmarine![0]);
                        scoutList.add(ship.scout![0]);
                      }

                      return ScrollViewPageWithScrollbar(
                        child: CupertinoListSection.insetGrouped(
                          margin: _sectionMargin,
                          footer: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CupertinoListSectionDescription(
                                    'Lv:${levelList.reduce((value, element) => value + element)}\n'
                                    '速力:${speedLevel(speedList.reduce(min))}\n'
                                    '火力:${attackList.reduce((value, element) => value + element)}\n'
                                    '対空:${antiAircraftList.reduce((value, element) => value + element)}\n'
                                    '対潜:${antiSubmarineList.reduce((value, element) => value + element)}\n'
                                    '索敵:${scoutList.reduce((value, element) => value + element)}\n'),
                                GestureDetector(
                                  child: Icon(
                                    CupertinoIcons.info,
                                    size: 20,
                                    color: CupertinoDynamicColor.resolve(
                                        kHeaderFooterColor, context),
                                  ),
                                  onTap: () => showAdaptiveDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog.adaptive(
                                          content: Text(S
                                              .of(context)
                                              .KCDashboardFleetDescription),
                                          actions: [
                                            adaptiveAction(
                                              context: context,
                                              child:
                                                  Text(S.of(context).TextYes),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            )
                                          ],
                                        );
                                      }),
                                ),
                              ]),
                          children: [
                            for (final ship in squad.ships)
                              CupertinoListTile(
                                title: Text(ship.name!),
                                padding: const EdgeInsetsDirectional.only(
                                    start: 10.0, end: 8.0),
                                leading: CarouselSlider(
                                  items: [
                                    AttributeLabel.vertical(
                                        label: 'Lv', value: '${ship.level}'),
                                    AttributeLabel.vertical(
                                        label: 'Lv Up',
                                        value: '${ship.exp?[1]}'),
                                  ],
                                  options: CarouselOptions(
                                    height: 30,
                                    viewportFraction: 1,
                                    initialPage: 0,
                                    enableInfiniteScroll: true,
                                    reverse: false,
                                    autoPlay: true,
                                    autoPlayInterval: Duration(seconds: 5),
                                    autoPlayAnimationDuration:
                                        Duration(milliseconds: 800),
                                    autoPlayCurve: Curves.ease,
                                    scrollDirection: Axis.horizontal,
                                  ),
                                ),
                                leadingToTitle: 4,
                                onTap: () async {
                                  await navigatorToCupertino(
                                      context,
                                      ShipInfo(
                                        ship: ship,
                                        squadName: squads[index].name,
                                      ));
                                },
                                additionalInfo: SizedBox(
                                    width: 70,
                                    child: Text(
                                      "${ship.nowHP}/${ship.maxHP}",
                                      textAlign: TextAlign.end,
                                    )),
                                subtitle: LinearPercentIndicator(
                                  backgroundColor:
                                      CupertinoDynamicColor.resolve(
                                          CupertinoColors
                                              .systemGroupedBackground,
                                          context),
                                  animation: true,
                                  animationDuration: 500,
                                  barRadius: const Radius.circular(2.5),
                                  animateFromLastPercent: true,
                                  lineHeight: 5.0,
                                  percent: ship.nowHP / ship.maxHP,
                                  progressColor: ship.damageColor,
                                ),
                                trailing: CircularPercentIndicator(
                                  backgroundColor:
                                      CupertinoDynamicColor.resolve(
                                          CupertinoColors
                                              .systemGroupedBackground,
                                          context),
                                  reverse: true,
                                  radius: 12.0,
                                  lineWidth: 5.0,
                                  animation: true,
                                  animationDuration: 500,
                                  animateFromLastPercent: true,
                                  circularStrokeCap: CircularStrokeCap.round,
                                  percent: ship.condition! / 100,
                                  center: Container(
                                    height: 6,
                                    width: 6,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: ship.fuelBullColor(
                                          shipInfo?[ship.shipId]!.apiFuelMax,
                                          shipInfo?[ship.shipId]!.apiBullMax),
                                    ),
                                  ),
                                  progressColor: ship.sparkColor,
                                ),
                              ),
                          ],
                        ),
                      );
                    }
                    return CupertinoListSection.insetGrouped(
                      children: const [
                        CupertinoListTile.notched(
                          title: Text("N/A"),
                        ),
                      ],
                    );
                  }),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class ShipInfo extends StatelessWidget {
  const ShipInfo({
    super.key,
    required this.ship,
    required this.squadName,
  });

  final Ship ship;
  final String squadName;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        transitionBetweenRoutes: false,
        backgroundColor: CupertinoColors.systemGroupedBackground,
        border: null,
        middle: Text(ship.name!),
        previousPageTitle: squadName,
      ),
      child: ScrollViewPageWithScrollbar(
        child: CupertinoListSection.insetGrouped(
          margin: _sectionMargin,
          children: [
            CupertinoListTile(
              title: Text("Lv"),
              additionalInfo: Text('${ship.level}'),
            ),
            CupertinoListTile(
              title: Text("Lv. up EXP"),
              additionalInfo: Text('${ship.exp?[1]}'),
            ),
            CupertinoListTile(
              title: Text("疲労度"),
              additionalInfo: Text('${ship.condition}'),
            ),
            CupertinoListTile(
              title: Text("損傷"),
              additionalInfo: Text(ship.damageLevel),
            ),
            CupertinoListTile(
              title: Text("速力"),
              additionalInfo: Text(ship.speedLevel),
            ),
            CupertinoListTile(
              title: Text("火力"),
              additionalInfo: Text('${ship.attack?[0]}/${ship.attack?[1]}'),
            ),
            CupertinoListTile(
              title: Text("雷装"),
              additionalInfo: Text('${ship.attackT?[0]}/${ship.attackT?[1]}'),
            ),
            CupertinoListTile(
              title: Text("対空"),
              additionalInfo:
                  Text('${ship.antiAircraft?[0]}/${ship.antiAircraft?[1]}'),
            ),
            CupertinoListTile(
              title: Text("装甲"),
              additionalInfo: Text('${ship.armor?[0]}/${ship.armor?[1]}'),
            ),
            CupertinoListTile(
              title: Text("回避"),
              additionalInfo: Text('${ship.evasion?[0]}/${ship.evasion?[1]}'),
            ),
            CupertinoListTile(
              title: Text("対潜"),
              additionalInfo:
                  Text('${ship.antiSubmarine?[0]}/${ship.antiSubmarine?[1]}'),
            ),
            CupertinoListTile(
              title: Text("索敵"),
              additionalInfo: Text('${ship.scout?[0]}/${ship.scout?[1]}'),
            ),
            CupertinoListTile(
              title: Text("射程"),
              additionalInfo: Text(ship.attackRangeLevel),
            ),
            CupertinoListTile(
              title: Text("運"),
              additionalInfo: Text('${ship.luck?[0]}/${ship.luck?[1]}'),
            ),
            CupertinoListTile(
              title: Text("ID"),
              additionalInfo: Text('${ship.uid}'),
            ),
            CupertinoListTile(
              leading: Icon(CupertinoIcons.back),
              title: Text(S.of(context).AppBack),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ScrollViewPageWithScrollbar extends StatelessWidget {
  const ScrollViewPageWithScrollbar({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CupertinoScrollbar(
      child: CustomScrollView(slivers: [
        SliverList(
          delegate: SliverChildListDelegate([child]),
        ),
      ]),
    );
  }
}
