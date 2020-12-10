import 'package:flutter/material.dart';
import '../models/user_data.dart';

class ContentPreferences extends StatefulWidget {
  @override
  _ContentPreferencesState createState() => _ContentPreferencesState();
}

class _ContentPreferencesState extends State<ContentPreferences> {
  var contentPreferences = UserData.userData['content_preferences'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('User preferences'),
          centerTitle: true,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context, contentPreferences))),
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
              rows: contentPreferences.entries
                  .map<DataRow>(
                    (e) => DataRow(cells: [
                      DataCell(Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(e.key),
                          Checkbox(
                              value: e.value,
                              onChanged: (bool value) {
                                setState(() {
                                  contentPreferences[e.key] =
                                      !contentPreferences[e.key];
                                });
                              })
                        ],
                      ))
                    ]),
                  )
                  .toList(),
            )
          ],
        ),
      ),
    );
  }
}
