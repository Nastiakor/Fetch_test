import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Album {
  final String fact;

  const Album({
    required this.fact,
  });

  factory Album.fromJson(String fact) {
    return Album(
      fact: fact,
    );
  }
}

Future<Album> fetchCatFact() async {
  final response = await http.get(Uri.parse('https://catfact.ninja/fact'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    final jsonResponse = jsonDecode(response.body);
    final fact = jsonResponse['fact'];
    return Album.fromJson(fact);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load cat fact');
  }
}

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchCatFact();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<Album>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data!.fact);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}


/*
Future<Album> fetchAlbum() async {
  final response = await http
      .get(Uri.parse('https://catfact.ninja/fact'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Album {
  final int userId;
  final int id;
  final String description;

  const Album({
    required this.userId,
    required this.id,
    required this.description,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'],
      id: json['id'],
      description: json['title'],
    );
  }
}

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<Album>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data!.description);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
*/


/*List<dynamic> articles = [];

Future<List<dynamic>> fetchPosts() async {
  final response = await http.get(Uri.parse("http://localhost/posts"));
  print("Response body: ${response.body}"); // Add this line to print the response

  if (response.statusCode == 200) {
    final data = json.decode(response.body)
    as Map <String, dynamic>;
  } else {
    throw Exception('Failed to fetch posts');
  }
}


void main() {
  runApp(MyApp()); // on appelle la classe MyApp
}

class MyApp extends StatelessWidget {
  // on hérite tout de la classe principale StatelessWidget
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // build = méthode de la classe StatelessWidget
    return MaterialApp(
      // on retourne une "fenêtre"
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: PostsPage(),
    );
  }
}

class PostsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Posts')),
      body: FutureBuilder(
        future: fetchPosts(),
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                final post = snapshot.data?[index];
                // Customize the ListTile widget or any other widget as needed to display the post data
                return ListTile(title: Text(post['title']));
              },
            );
          }
        },
      ),
    );
  }
}*/

//
// class BasicsPage extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     var platform = Theme.of(context).platform;
//     print('coucou ${articles}');
//     print("size: $size");
//     print("platform: $platform");
//     double width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('REFUGEES WELCOME !'),
//         centerTitle: true,
//         backgroundColor: Colors.indigo,
//         leading: IconButton(
//           onPressed: () {},
//           icon: const Icon(Icons.home),
//         ),
//         actions: <Widget>[
//           IconButton(
//             icon: const Icon(Icons.menu),
//             tooltip: 'Show Snackbar',
//             onPressed: () {
//               ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(content: Text('LES KEUFS ARRIVENT !')));
//             },
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Stack(
//               alignment: Alignment.topCenter,
//               children: [
//                 Image.asset("images/banner.jpeg",
//                     height: 200, width: size.width, fit: BoxFit.cover),
//                 Padding(
//                   padding: EdgeInsets.only(top: 150),
//                   child: CircleAvatar(
//                       radius: 60,
//                       backgroundColor: Colors.white,
//                       child: myProfilePic(60)),
//                 ),
//               ],
//             ),
//             Row(
//               children: [
//                 Spacer(),
//                 Text(
//                   "Nicolas Cage",
//                   style: TextStyle(
//                       fontStyle: FontStyle.italic,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 25),
//                 ),
//                 Spacer(),
//               ],
//             ),
//             Padding(
//               padding: EdgeInsets.all(15),
//               child: Text(
//                 "Les chats domineront le monde, mais pas aujourd'hui, car c'est la sieste",
//                 style: TextStyle(color: Colors.grey, fontSize: 15),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//             Row(
//               children: [
//                 Expanded(child: buttonContainer(text: "Modifier le profil")),
//                 buttonContainer(icon: Icons.border_color),
//               ],
//             ),
//             Padding(
//               padding: EdgeInsets.only(top: 10),
//               child: Divider(
//                 thickness: 2,
//               ),
//             ),
//             sectionTitleText("A propos de moi"),
//             aboutRow(
//                 icon: Icons.house,
//                 text: "Porte de la Chapelle, sous une tente Quechua"),
//             aboutRow(icon: Icons.work, text: "Acteur de renom"),
//             aboutRow(icon: Icons.favorite, text: "Avec sa main droite"),
//             Divider(
//               thickness: 2,
//             ),
//             sectionTitleText("Amis"),
//             allFriends(width / 3.5),
//             Divider(
//               thickness: 2,
//             ),
//             sectionTitleText("Mes Posts"),
//             post(
//                 time: "5 minutes",
//                 image: "images/night_sky.jpg",
//                 desc: "Red Star ce soir",
//                 likes: 1001,
//                 comments: 1000000),
//             post(
//                 time: "15 minutes",
//                 image: "images/night_sky.jpg",
//                 desc: "Red Star ce soir"),
//             post(
//                 time: "50 minutes",
//                 image: "images/night_sky.jpg",
//                 desc: "Red Star ce soir")
//           ],
//         ),
//       ),
//     );
//   }
//
//   CircleAvatar myProfilePic(double radius) {
//     return CircleAvatar(
//       radius: radius,
//       backgroundImage: AssetImage("images/nicolas_cage_crazy.webp"),
//     );
//   }
//
//   Container buttonContainer({IconData? icon, String? text}) {
//     return Container(
//       margin: EdgeInsets.only(left: 10, right: 10),
//       padding: EdgeInsets.all(15),
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20), color: Colors.blue),
//       child: (icon == null)
//           ? Center(
//               child: Text(text ?? "", style: TextStyle(color: Colors.white)))
//           : Icon(
//               icon,
//               color: Colors.white,
//             ),
//       height: 50,
//     );
//   }
//
//   Widget sectionTitleText(String text) {
//     return Padding(
//       padding: EdgeInsets.all(5),
//       child: Text(
//         text,
//         style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
//       ),
//     );
//   }
//
//   Widget aboutRow({required IconData icon, required String text}) {
//     return Row(
//       children: [
//         Padding(
//           padding: EdgeInsets.only(left: 10),
//           child: Icon(icon),
//         ),
//         Padding(
//           padding: EdgeInsets.all(5),
//           child: Text(text),
//         )
//       ],
//     );
//   }
//
//   Column friendsImage(String name, String imagePath, double width) {
//     return Column(
//       children: [
//         Container(
//             margin: EdgeInsets.all(5),
//             width: width,
//             height: width,
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                   image: AssetImage(imagePath), fit: BoxFit.cover),
//               borderRadius: BorderRadius.circular(20),
//               boxShadow: [BoxShadow(color: Colors.grey)],
//             )),
//         Text(name),
//         Padding(padding: EdgeInsets.only(bottom: 5))
//       ],
//     );
//   }
//
//   Row allFriends(double width) {
//     Map<String, String> friends = {
//       "Bernard Minou": "images/cat.png",
//       "Minette": "images/flower.jpg",
//       "Pignouf": "images/cat.png"
//     };
//     List<Widget> children = [];
//     friends.forEach((name, imagePath) {
//       children.add(friendsImage(name, imagePath, width));
//     });
//     return Row(
//       children: children,
//       mainAxisSize: MainAxisSize.max,
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//     );
//
// //  Container buttonContainer({IconData? icon, String? text}) {
// //    return Container(
// //      margin: EdgeInsets.only(left:10, right:10),
// //      padding: EdgeInsets.all(15),
// //      child: (icon == null) {
// //        ? Text(text ?? "", style: TextStyle(color: Colors.white),)
// //    }, // PAUSE VIDEO 87 à 7min19
//   } //End Widget
//
// // End class
//
//   Container post(
//       {required String time,
//       required String image,
//       required String desc,
//       int likes = 0,
//       int comments = 0}) {
//     return Container(
//       margin: EdgeInsets.only(top: 8, left: 3, right: 3),
//       padding: EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20),
//         color: Color.fromRGBO(225, 225, 225, 1),
//       ),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               myProfilePic(20),
//               Padding(padding: EdgeInsets.only(left: 8)),
//               Text(NYTAPI().toString()),
//               Spacer(),
//               timeText("5 minutes")
//             ],
//           ),
//           Padding(
//               padding: EdgeInsets.only(top: 8, bottom: 8),
//               child: Image.asset(
//                 image,
//                 fit: BoxFit.cover,
//               )),
//           Text(
//             desc,
//             style: TextStyle(color: Colors.blueAccent),
//             textAlign: TextAlign.center,
//           ),
//           Divider(),
//           Row(
//             mainAxisSize: MainAxisSize.max,
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Icon(Icons.favorite),
//               Text("$likes Likes"),
//               Icon(Icons.message),
//               Text("$comments Commentaires")
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Text timeText(String time) {
//     return Text(
//       "Il y a $time",
//       style: TextStyle(color: Colors.black),
//     );
//   }
// }
//
