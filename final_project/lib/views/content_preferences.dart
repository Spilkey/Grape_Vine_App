import 'package:flutter/material.dart';
// import '../models/topic_model.dart'; - get all the topics and display on DataTable

class ContentPreferences extends StatefulWidget {
  @override
  _ContentPreferencesState createState() => _ContentPreferencesState();
}

class _ContentPreferencesState extends State<ContentPreferences> {
  // TODO: return preferences object to do settings page so the settings can be passed to the database
  // TODO: pull from the database all the topics
  var preferences = [
    {'topic': 'Celebrities', 'selected': false},
    {'topic': 'Movies', 'selected': false},
    {'topic': 'Music', 'selected': false},
    {'topic': 'Technology', 'selected': false},
    {'topic': 'Travel', 'selected': false},
    {'topic': 'Gaming', 'selected': false},
    {'topic': 'Art', 'selected': false},
    {'topic': 'Food', 'selected': false},
    {'topic': 'Politics', 'selected': false},
    {'topic': 'Sports', 'selected': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('User preferences'),
          centerTitle: true,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context))),
      body: SizedBox(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Text(
                  'These are your content preferences. You can manage which topics you see on the Discovery page.'),
            ),
            DataTable(
              columns: [DataColumn(label: Text('Preferences'))],
              rows: List<DataRow>.generate(
                  preferences.length,
                  (index) => DataRow(
                        cells: [
                          DataCell(Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                preferences[index]['topic'],
                              ),
                              Checkbox(
                                  value: preferences[index]['selected'],
                                  onChanged: (bool value) {
                                    setState(() {
                                      preferences[index]['selected'] =
                                          !preferences[index]['selected'];
                                    });
                                  })
                            ],
                          )),
                        ],
                      )),
            ),
          ],
        ),
      ),
    );
  }
}
