import 'package:flutter/material.dart';
import 'package:kanban_boards/class/card_repository.dart';
import 'package:kanban_boards/model/card.dart';
import 'package:kanban_boards/wdgets/continue_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CardsBoardScreen extends StatefulWidget {
  CardsBoardScreen({this.card});
  final CardModel? card;

  @override
  _CardsBoardScreenState createState() => _CardsBoardScreenState();
}

class _CardsBoardScreenState extends State<CardsBoardScreen> {
  // CardModel? get _cardInfo => widget.card;
  late List<CardModel> cardi;
  CardRepository get cardRepository => _cardRepository;
  CardRepository _cardRepository = CardRepository();
  @override
  void initState() {
    super.initState();
    cardi = [];
    getCard();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          alignment: Alignment.center,
          child: Row(
            children: [
              Text("${cardi.length}"),
              Container(
                  alignment: Alignment.center,
                  child: ContinueButton(
                    color: Colors.amber,
                    text: "Quit",
                    // .localizations(context),
                    onPress: () {
                      clearToken();
                    },
                  ))
            ],
          )),
    );
  }

  Future<void> getCard() async {
    cardi.addAll(await _cardRepository.getCard());

    setState(() {
      cardi = cardi;
    });
  }

  clearToken() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.remove("token");
  }
}
