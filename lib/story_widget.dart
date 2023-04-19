import 'package:flutter/material.dart';

class StoryWidget extends StatelessWidget {
  StoryWidget({Key? key}) : super(key: key);
  final List storyItems = [
    {
      "pseudo": 'Jojo',
      "photo": "images/cat.png",
    },

    {
      "pseudo": 'Nasty',
      "photo": "images/flower.jpg",
    },

    {
      "pseudo": 'Jojo',
      "photo": "images/cat.png",
    },

    {
      "pseudo": 'Nasty',
      "photo": "images/flower.jpg",
    },

    {
      "pseudo": 'Jojo',
      "photo": "images/cat.png",
    },

    {
      "pseudo": 'Nasty',
      "photo": "images/flower.jpg",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: storyItems.map((story) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      'images/story-circle.png',
                      height: 77,
                    ),
                    Image.asset(
                      'images/story-circle.png',
                      height: 75,
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 37,
                      backgroundImage: AssetImage(story['photo']),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  story['pseudo'],
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}