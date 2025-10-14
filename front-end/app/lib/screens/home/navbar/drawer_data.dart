import 'package:flutter/material.dart';

class DrawerData extends StatelessWidget {
  const DrawerData({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> navigation = const [
    {"name": "Home", "href": "/", "current": true},
    {"name": "Services", "href": "#services", "current": false},
    {"name": "About", "href": "#about", "current": false},
    {"name": "Project", "href": "#project", "current": false},
    {"name": "Help", "href": "/", "current": false},
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: navigation.map((item) {
          return InkWell(
            onTap: () {
              debugPrint('${item["name"]} clicked in drawer');
              Navigator.of(context).pop(); // Close drawer after click
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              child: Text(
                item["name"],
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: item["current"] ? Colors.black : Colors.black.withOpacity(0.8),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
