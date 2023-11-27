import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../dashboard.dart';

class BookmarkedScreen extends StatefulWidget {
  final List<String> bookmarkedTitles;
  final List<String> subText;
  final List<CardInfo> cardInfoList;
  final Function(int) onUnmarkCallback;

  const BookmarkedScreen({
    Key? key,
    required this.bookmarkedTitles,
    required this.subText,
    required this.cardInfoList,
    required this.onUnmarkCallback,
  }) : super(key: key);

  @override
  _BookmarkedScreenState createState() => _BookmarkedScreenState();
}

class _BookmarkedScreenState extends State<BookmarkedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmarked Cards'),
      ),
      body: ListView.builder(
        itemCount: widget.cardInfoList.length,
        itemBuilder: (context, index) {
          CardInfo cardInfo = widget.cardInfoList[index];
          return _bookmarkedCard(cardInfo.title, cardInfo.subtitle);
        },
      ),
    );
  }

  Widget _bookmarkedCard(String title, String subtitle) {
    return Card(
      clipBehavior: Clip.antiAlias,
      color: Colors.lightGreen,
      child: Column(
        children: [
          ListTile(
            hoverColor: Colors.lightBlueAccent,
            leading: const Icon(Icons.video_camera_front_outlined),
            title: Text(title),
            subtitle: Text(
              subtitle,
              style: GoogleFonts.poppins(
                color: Colors.black.withOpacity(0.6),
              ),
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Perform some action
                },
                child: const Text('ACTION 2'),
              ),
              IconButton(
                icon: const Icon(
                  Icons.bookmark,
                  color: Colors.blue,
                ),
                onPressed: () {
                  int index = widget.cardInfoList.indexWhere((cardInfo) =>
                  cardInfo.title == title && cardInfo.subtitle == subtitle);
                  if (index != -1) {
                    setState(() {
                      widget.cardInfoList.removeAt(index);
                      widget.bookmarkedTitles.removeAt(index);
                      widget.subText.removeAt(index);
                    });
                    // Invoke the callback to notify Dashboard about the unmarking
                    widget.onUnmarkCallback(index);
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
