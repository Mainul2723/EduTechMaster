import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'NavScreen/bookmarked.dart';
import 'coursePlayerPageScreen.dart';

class CardInfo {
  final int index;
  final String title;
  final String subtitle;

  CardInfo({required this.index, required this.title, required this.subtitle});
}

class DashBoard extends StatefulWidget {
  DashBoard({Key? key, required this.title, required this.subText});
  String ht = '';
  String st = '';
  final String title;
  final String subText;

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int _selectedIndex = 0;
  List<bool> bookmarked = [false, false, false, false, false];
  List<String> bookmarkedTitles = [];
  List<String> subTitle = [];
  List<CardInfo> cardInfoList = [];

  void _onUnmark(int index) {
    setState(() {
      bookmarked[index] = false;
      bookmarkedTitles.removeAt(index);
      subTitle.removeAt(index);
    });
  }

  void _toggleBookmark(int index, String title, String subText) {
    setState(() {
      bookmarked[index] = !bookmarked[index];

      if (bookmarked[index]) {
        bookmarkedTitles.add(title);
        subTitle.add(subText);
        cardInfoList
            .add(CardInfo(index: index, title: title, subtitle: subText));
      } else {
        bookmarkedTitles.remove(title);
        subTitle.remove(subText);
        cardInfoList.removeWhere((cardInfo) => cardInfo.index == index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Container(
        color: Colors.grey[300],
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeInRight(
                duration: const Duration(milliseconds: 200),
                child: _cards('JavaScript', 'Summit', 0),
              ),
              FadeInLeft(
                  duration: const Duration(milliseconds: 200),
                  child: _cards('Java', 'Anisul Islam', 1)),
              FadeInRight(
                  duration: const Duration(milliseconds: 200),
                  child: _cards('Dart', 'Rabbil Hasan', 2)),
              FadeInLeft(
                  duration: const Duration(milliseconds: 200),
                  child: _cards('React JS', 'Summit', 3)),
              FadeInRight(
                  duration: const Duration(milliseconds: 200),
                  child: _cards('C/C++', 'Anisul Islam', 4)),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Home'),
              selected: _selectedIndex == 0,
              onTap: () {
                _onUnmark(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('BookMarks'),
              selected: _selectedIndex == 1,
              onTap: () {
                _onUnmark(1);
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookmarkedScreen(
                      bookmarkedTitles: bookmarkedTitles,
                      subText: subTitle,
                      cardInfoList: cardInfoList,
                      onUnmarkCallback: (index) {
                        // Update the state in Dashboard when a card is unmarked
                        setState(() {
                          bookmarked[index] = false;
                        });
                      },
                    ),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('About Me'),
              selected: _selectedIndex == 2,
              onTap: () {
                _onUnmark(2);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _cards(String ht, String st, int index) {
    CardInfo cardInfo = CardInfo(index: index, title: ht, subtitle: st);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      clipBehavior: Clip.antiAlias,
      color: bookmarked[index] ? Colors.greenAccent : null,
      child: Column(
        children: [
          ListTile(
            hoverColor: Colors.indigoAccent,
            leading: const Icon(Icons.video_camera_front_outlined),
            title: Text(
              ht,
              style: GoogleFonts.poppins(
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Text(
              st,
              style: GoogleFonts.poppins(
                color: Colors.black.withOpacity(0.6),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CoursePlayer(
                        selectedIndex: index,
                        selectedTitle: ht,
                        selectedSubtitle: st,
                      ),
                    ),
                  );
                },
                child: const Text('Continue'),
              ),
              IconButton(
                icon: Icon(
                  bookmarked[index] ? Icons.bookmark : Icons.bookmark_border,
                  color: Colors.blue,
                ),
                onPressed: () {
                  _toggleBookmark(index, ht, st);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
