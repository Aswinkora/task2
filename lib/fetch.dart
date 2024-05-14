import 'dart:convert';
import 'package:fetch_api/model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostListScreen extends StatefulWidget {
  @override
  PostListScreenState createState() {
    return PostListScreenState();
  }
}

class PostListScreenState extends State<PostListScreen> {
  late Future<List<Post>> futurePosts;

  Future<List<Post>> fetchPosts() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((post) => Post.fromJson(post)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }

  @override
  void initState() {
    super.initState();
    futurePosts = fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Posts'),
          backgroundColor: const Color.fromARGB(255, 147, 116, 234)),
      body: FutureBuilder<List<Post>>(
        future: futurePosts,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  shadowColor: Theme.of(context).hintColor,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    title: Text(
                      snapshot.data![index].title ?? '',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 103, 83, 158)),
                    ),
                    subtitle: Text(snapshot.data![index].body ?? ''),
                    tileColor: Colors.grey[100],
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("${snapshot.error}"));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
