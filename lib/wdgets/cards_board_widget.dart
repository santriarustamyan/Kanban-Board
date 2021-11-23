import 'package:flutter/material.dart';
import 'package:kanban_boards/class/card_repository.dart';
import 'package:kanban_boards/model/card.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/cards_board/cards_column_widget.dart';

class CardsBoardScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CardsBoardScreenState();
  }
}

class _CardsBoardScreenState extends State<CardsBoardScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  CardRepository get cardRepository => _cardRepository;
  CardRepository _cardRepository = CardRepository();
  late List<CardModel> cards;
  late List<CardModel> cards0;
  late List<CardModel> cards1;
  late List<CardModel> cards2;
  late List<CardModel> cards3;

  @override
  void initState() {
    super.initState();

    cards = [];
    cards0 = [];
    cards1 = [];
    cards2 = [];
    cards3 = [];

    getCard();

    _tabController = TabController(length: 4, vsync: this);
    _tabController.animateTo(2);
  }

  static const List<Tab> _tabs = [
    const Tab(child: const Text('On hold')),
    const Tab(text: 'In progress'),
    const Tab(text: 'Needs review'),
    const Tab(text: 'Approved'),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: MaterialApp(
          home: DefaultTabController(
            length: 4,
            child: Scaffold(
              backgroundColor: Colors.grey,
              appBar: AppBar(
                actions: [
                  IconButton(
                    iconSize: 50,
                    color: Colors.greenAccent,
                    alignment: Alignment.centerRight,
                    onPressed: () => quitAction(),
                    icon: Icon(Icons.exit_to_app),
                  ),
                ],
                bottom: TabBar(
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white,
                  labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                  unselectedLabelStyle:
                      const TextStyle(fontStyle: FontStyle.italic),
                  overlayColor: MaterialStateColor.resolveWith(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.black45;
                    }
                    if (states.contains(MaterialState.focused)) {
                      return Colors.black45;
                    } else if (states.contains(MaterialState.hovered)) {
                      return Colors.black45;
                    }

                    return Colors.black;
                  }),
                  indicatorWeight: 10,
                  indicatorColor: Colors.black45,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorPadding: const EdgeInsets.all(5),
                  indicator: BoxDecoration(
                    border: Border.all(color: Colors.black54),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black54,
                  ),
                  isScrollable: true,
                  physics: BouncingScrollPhysics(),
                  onTap: (int index) {
                    print('Tab $index is tapped');
                  },
                  enableFeedback: true,
                  tabs: _tabs,
                ),
                backgroundColor: Colors.black54,
              ),
              body: TabBarView(physics: BouncingScrollPhysics(), children: [
                CardsColumn(card: cards0),
                CardsColumn(card: cards1),
                CardsColumn(card: cards2),
                CardsColumn(card: cards3),
              ]),
            ),
          ),
        ));
  }

  void quitAction() {
    Navigator.pushNamedAndRemoveUntil(context, "/", (r) => false);

    clearToken();
  }

  Future<void> getCard() async {
    cards.addAll(await _cardRepository.getCard());
    setState(() {
      cards = cards;
      cards0 = cards.where((e) => e.row == "0").toList();
      cards1 = cards.where((e) => e.row == "1").toList();
      cards2 = cards.where((e) => e.row == "2").toList();
      cards3 = cards.where((e) => e.row == "3").toList();
    });
  }
}

clearToken() async {
  var prefs = await SharedPreferences.getInstance();
  prefs.remove("token");
}
