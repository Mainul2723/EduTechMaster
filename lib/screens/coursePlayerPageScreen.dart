import 'package:edutechmaster/screens/videoPlayerScreen.dart';
import 'package:flutter/material.dart';

import '../Model/videoModel.dart';

class CoursePlayer extends StatelessWidget {
  final int selectedIndex;
  final String selectedTitle;
  final String selectedSubtitle;

  CoursePlayer({
    Key? key,
    required this.selectedIndex,
    required this.selectedTitle,
    required this.selectedSubtitle,
  }) : super(key: key);

  List<List<VideoModel>> allVideoLists = [
    videos,
    videos1,
    videos2,
    videos3,
    videos4,
  ];

  @override
  Widget build(BuildContext context) {
    List<VideoModel> currentVideoList = allVideoLists[selectedIndex];
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Video List - ${selectedTitle}'), // Use selectedTitle in the title
        // You can also use selectedSubtitle in the AppBar as needed
      ),
      body: ListView.builder(
        itemCount: currentVideoList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              print("Card tapped: $index");
              print("Video path: ${currentVideoList[index].path}");
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      VideoPlayerScreen(videoPath: currentVideoList[index].path),
                ),
              );
            },

            child: Card(
              child: ListTile(
                title: Text(currentVideoList[index].title),
              ),
            ),
          );
        },
      ),
    );
  }
}
