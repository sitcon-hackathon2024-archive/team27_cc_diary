import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class DetailPage extends StatelessWidget {
  final String disorderKey;

  const DetailPage({Key? key, required this.disorderKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    log('disorderKey: $disorderKey');
    String getLocalizedText(String key) {
      switch (key) {
        case 'symptom':
          if(disorderKey == 'Depression') {
            return loc.depressionSymptom;
          } else if(disorderKey == 'Bipolar') {
            return loc.bipolarSymptom;
          }
          return 'No information available';
        case 'explanation':
          if(disorderKey == 'Depression') {
            return loc.depressionExplanation;
          } else if(disorderKey == 'Bipolar') {
            return loc.bipolarExplanation;
          }
          return 'No information available';
        case 'groups':
          if(disorderKey == 'Depression') {
            return loc.depressionGroups;
          } else if(disorderKey == 'Bipolar') {
            return loc.bipolarExplanation;
          }
          return 'No information available';
        default:
          return 'No information available';
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.informationTitle), // Assuming title is generic or passed dynamically
        backgroundColor: Color(0xffD6CCC2),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          Text(loc.symptom, style: Theme.of(context).textTheme.headlineMedium),
          Text(getLocalizedText('symptom')),
          SizedBox(height: 20, ),
          Text(loc.explanation, style: Theme.of(context).textTheme.headlineMedium),
          Text(getLocalizedText('explanation')),
          SizedBox(height: 20),
          Text(loc.groups, style: Theme.of(context).textTheme.headlineMedium),
          Text(getLocalizedText('groups')),
          Text(loc.suggestion, style: Theme.of(context).textTheme.headlineSmall),
        ],
      ),
    );
  }
}
