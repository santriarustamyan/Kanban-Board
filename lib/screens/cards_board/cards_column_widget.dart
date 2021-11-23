import 'package:flutter/material.dart';
import 'package:kanban_boards/model/card.dart';

class CardsColumn extends StatelessWidget {
  final List<CardModel>? card;

  const CardsColumn({
    this.card,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            for (int i = 0; i < card!.length; i++)
              Container(
                decoration:
                    BoxDecoration(color: Colors.grey, border: Border.all()),
                child: ListTile(
                  title: Text('ID: ${card![i].id}',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.w600)),
                  subtitle: Text('${card![i].text}',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w600)),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
