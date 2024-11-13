import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final movie = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(title: Text(movie['name'])),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (movie['image'] != null) Image.network(movie['image']['original']),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(movie['name'], style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(movie['summary'] ?? 'No summary available'),
            ),
            // Add more details here as needed
          ],
        ),
      ),
    );
  }
}
