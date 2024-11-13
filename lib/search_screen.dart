import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<dynamic> searchResults = [];
  final TextEditingController _controller = TextEditingController();

  Future<void> searchMovies(String query) async {
    final response = await http.get(Uri.parse('https://api.tvmaze.com/search/shows?q=$query'));
    if (response.statusCode == 200) {
      setState(() {
        searchResults = jsonDecode(response.body);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search Movies')),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Search for movies...',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () => searchMovies(_controller.text),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                final movie = searchResults[index]['show'];
                return ListTile(
                  leading: Image.network(movie['image']?['medium'] ?? 'https://via.placeholder.com/100'),
                  title: Text(movie['name']),
                  subtitle: Text(movie['summary'] ?? '', maxLines: 2, overflow: TextOverflow.ellipsis),
                  onTap: () {
                    Navigator.pushNamed(context, '/details', arguments: movie);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
