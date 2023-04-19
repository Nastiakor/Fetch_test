import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'story_widget.dart';

Future<List<Album>> fetchPost() async {
  print('fetchPost: Sending request...');
  final response = await http.get(Uri.parse('http://localhost/api/posts'));

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
    return Album(
        description: json['content'],
        picture: "http://localhost/storage/" + json['picture']);
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
                Icons.add_box_outlined,
                color: Colors.black,
                size: 30,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(
                Icons.favorite_border_outlined,
                color: Colors.black,
                size: 30,
              ),
              onPressed: () {},
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              StoryWidget(),
              const Divider(
                thickness: 2,
              ),
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
                            Container(
                              width: 400,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Colors.grey.shade300,
                                        backgroundImage: AssetImage(
                                            "images/nicolas_cage_crazy.webp"),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        "Nicolas Cage",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(width: 5),
                                      Image.asset(
                                        "images/verification-badge.png",
                                        height: 13,
                                      ),
                                      Expanded(child: Container()),
                                      IconButton(
                                          onPressed: () {},
                                          icon: const Icon(Icons.more_horiz))
                                    ],
                                  ),
                                  Container(
                                    width: 400,
                                    child: Image.network(
                                        snapshot.data![index].picture,
                                        fit: BoxFit.cover),
                                  ),
                                  SizedBox(
                                    height: 50,
                                    child: Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                              Icons.favorite_outline),
                                        ),
                                        IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                              Icons.message_outlined),
                                        ),
                                        IconButton(
                                          onPressed: () {},
                                          icon: const Icon(Icons.send_outlined),
                                        ),
                                        Expanded(child: Container()),
                                        IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                              Icons.bookmark_outline),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 10,
                                              backgroundColor: Colors.grey,
                                              backgroundImage: AssetImage(
                                                  "images/nicolas_cage_crazy.webp"),
                                            ),
                                            const SizedBox(width: 10),
                                            RichText(
                                              text: TextSpan(
                                                text: "Aimé par ",
                                                style:
                                                    DefaultTextStyle.of(context)
                                                        .style,
                                                children: const <TextSpan>[
                                                  TextSpan(
                                                      text: "Jojo",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600)),
                                                  TextSpan(text: " et "),
                                                  TextSpan(
                                                      text:
                                                          "150 autres personnes",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600)),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              "Jojo",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(width: 5),
                                            Expanded(
                                              child: Text(
                                                snapshot
                                                    .data![index].description,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              "Plus",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.grey.shade400),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          'Afficher les 35 commentaires',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey.shade400),
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              'IL Y A 2 JOURS ',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.grey.shade400),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 15),
                            ),
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
                Icons.videocam_outlined,
              ),
              label: 'Video',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_bag_outlined,
              ),
              label: 'Message',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person_outline_outlined,
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
