import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:my_app/post_widget.dart';

Future<List<Album>> fetchPost() async {
  print('fetchPost: Sending request...');
  final response = await http.get(Uri.parse('http://192.168.6.143/api/posts'));

  print('fetchPost: Response received - statusCode: ${response.statusCode}');

  if (response.statusCode == 200) {
    print('fetchPost: statusCode 200 - Parsing JSON');
    final jsonResponse = jsonDecode(response.body);

    if (jsonResponse is List) {
      print('fetchPost: jsonResponse is a List');
      return jsonResponse.map((item) => Album.fromJson(item)).toList();
    } else {
      throw Exception('Unexpected JSON response format');
    }
  } else {
    throw Exception('Failed to load description');
  }
}

class Album {
  final String description;
  final String picture;


  const Album({required this.description, required this.picture});

  factory Album.fromJson(Map<String, dynamic> json) {
    print('Album.fromJson - json contents: $json');
    return Album(description: json['content'],
      picture: "http://192.168.6.143/storage/" + json['picture']);
  }
}

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<List<Album>> futureAlbumList;

  @override
  void initState() {
    super.initState();
    futureAlbumList = fetchPost();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Instagram',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Image.asset(
            'images/Insta_logo.png',
            height: 50,
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.add_a_photo_outlined,
                color: Colors.black,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(
                Icons.favorite_border_outlined,
                color: Colors.black,
              ),
              onPressed: () {},
            ),
          ],
        ),
        body:SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder<List<Album>>(
                future: futureAlbumList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Text(snapshot.data![index].description),
                            Image.network(snapshot.data![index].picture),
                          ],
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  // By default, show a loading spinner.
                  return const CircularProgressIndicator();
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          unselectedItemColor: Colors.grey.shade700,
          selectedItemColor: Colors.black,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_outlined,
                ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
                icon: Icon(
                Icons.search,
                ),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.video_camera_back_outlined,
              ),
              label: 'Video',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.message_rounded,
              ),
              label: 'Message',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person_off_outlined,
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}