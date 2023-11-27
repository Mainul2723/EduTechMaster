import 'package:edutechmaster/screens/coursePlayerPageScreen.dart';

class VideoModel {
  String title;
  String path;

  VideoModel({required this.title, required this.path});
}

List<VideoModel> videos = [
  VideoModel(title: 'JavaScript Tutorial 01', path: 'assets/videos/01.mp4'),
  VideoModel(title: 'JavaScript Tutorial 02', path: 'assets/videos/02.mp4'),
  VideoModel(title: 'JavaScript Tutorial 03', path: 'assets/videos/03.mp4'),

  // Add more videos as needed
];
List<VideoModel> videos1 = [
  VideoModel(title: 'Java Tutorial 01', path: 'assets/videos/java01.mp4'),
  VideoModel(title: 'Java Tutorial 02', path: 'assets/videos/java02.mp4'),
  VideoModel(title: 'Java Tutorial 03', path: 'assets/videos/java03.mp4'),
];
List<VideoModel> videos2 = [
  VideoModel(title: 'Dart Tutorial 01', path: 'assets/videos/flutter01.mp4'),
  VideoModel(title: 'Dart Tutorial 02', path: 'assets/videos/flutter02.mp4'),
  VideoModel(title: 'Dart Tutorial 03', path: 'assets/videos/flutter03.mp4'),
];
List<VideoModel> videos3 = [
  VideoModel(title: 'React Tutorial 01', path: 'assets/videos/react01.mp4'),
  VideoModel(title: 'React Tutorial 02', path: 'assets/videos/react02.mp4'),
  VideoModel(title: 'React Tutorial 03', path: 'assets/videos/react03.mp4'),
];
List<VideoModel> videos4 = [
  VideoModel(title: 'C Tutorial 01', path: 'assets/videos/c01.mp4'),
  VideoModel(title: 'C Tutorial 02', path: 'assets/videos/c02.mp4'),
  VideoModel(title: 'C Tutorial 03', path: 'assets/videos/c02.mp4'),
];