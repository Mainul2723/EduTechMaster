import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
class VideoPlayerScreen extends StatefulWidget {
  final String videoPath;

  VideoPlayerScreen({Key? key, required this.videoPath}) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  late ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoPath);
    _chewieController = ChewieController(
      videoPlayerController: _controller,
      autoPlay: true,
      looping: false,
    );
    _initializeVideo();
  }


  Future<void> _initializeVideo() async {
    print("Initializing video: ${widget.videoPath}");
    await _controller.initialize();
    print("Video initialized");
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black12,
        title: Text('Video Player', style: GoogleFonts.poppins(
          color: Colors.black,
        ),),
      ),
      body: Container(
        color: Colors.black,
        child: Center(
          child: _controller.value.isInitialized
              ? Chewie(controller: _chewieController!)
              : const CircularProgressIndicator(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _chewieController?.dispose();
    super.dispose();
  }
}
