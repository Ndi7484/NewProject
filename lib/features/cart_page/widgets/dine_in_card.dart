import 'dart:convert';

import 'package:flutter/material.dart';

class DineInCard extends StatelessWidget {
  const DineInCard({super.key, required this.jsonString});
  final String jsonString;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border.all(
          color: Colors.white,
          width: 1.0,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey, // Shadow color
            spreadRadius: 2.0, // Spread radius
            blurRadius: 5.0, // Blur radius
            offset: Offset(0, 3), // Offset in the x and y direction
          ),
        ],
      ),
      child: Builder(builder: (context) {
        // example json
        // {"place":"Mall Artha Gading", "address":"Jl. Kertajaksaan Gg. Sunda N0. 45", "table":"MAG01"}
        var tmp = jsonDecode(jsonString);
        // print(tmp['table']);
        // print(tmp.runtimeType);
        return ListTile(
          leading: Text(
            tmp['table'],
            style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontFamily: 'LeagueGothic',
                fontSize: 50),
          ),
          title: Text(tmp['place']),
          subtitle: Text(tmp['address']),
        );
      }),
    );
  }
}
