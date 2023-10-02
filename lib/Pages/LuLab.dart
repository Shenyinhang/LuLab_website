import 'dart:async';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

import '../items/end_about.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: LuLabPage(),
    ),
  ));
}
class LuLabPage extends StatefulWidget {
  const LuLabPage({Key? key}) : super(key: key);

  @override
  State<LuLabPage> createState() => _LuLabPageState();
}

class _LuLabPageState extends State<LuLabPage> {
  late VideoPlayerController _controller;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset("res/images/video.mp4");
    _chewieController = ChewieController(
      videoPlayerController: _controller,
      aspectRatio: 16 / 9, // 设置视频的宽高比
      autoPlay: true,
      looping: true,
      showControls: false,
    );
    _controller.setVolume(0);
  }

  @override
  void dispose() {
    _controller.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                AspectRatio(
                  aspectRatio: 16 / 7.5,
                  child: Container(
                    color: Colors.black,
                    child: Chewie(
                      controller: _chewieController,
                    ),
                  ),
                ),
                Positioned(
                  top: 450,
                  child: Column(
                    children: const [
                      Text(
                        'The New Education',
                        style: TextStyle(
                          fontSize: 100,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'in AI age',
                        style: TextStyle(
                          fontSize: 40,
                          color: Colors .white,
                        ),
                      ),
                      Text(
                        '\nAll work and no play makes Jack a dull boy\n',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors. white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            ScreenTypeLayout(
              mobile: CustomWidget(
                height: 500,
                itemCount: 6,
              ),
              tablet: CustomWidget(
                height: 600,
                itemCount: 6,
              ),
              desktop: CustomWidget(
                height: 700,
                itemCount: 6,
              ),
            ),
            const LearnWidget(),
            ea() // Add your custom widget here
          ],
        ),
      ),
    );
  }
}

class CustomWidget extends StatefulWidget {
  final double height;
  final int itemCount;

  const CustomWidget({Key? key, required this.height, required this.itemCount})
      : super(key: key);

  @override
  _CustomWidgetState createState() => _CustomWidgetState();
}

class _CustomWidgetState extends State<CustomWidget> {
  late PageController _pageController;
  int _currentPage = 0;
  Timer? _timer;

  // 俱乐部名称列表，可以自定义每个俱乐部的名称
  final List<String> clubNames = [
    "Metaverse Club",
    "Roblox&ChatGPT Club",
    "Digital Technology Club",
    "AI Club",
    "Digital Marketing Club",
    "Leadership Club",
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startAutoPlay();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startAutoPlay() {
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      if (_currentPage < widget.itemCount - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      height: widget.height,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.itemCount,
        itemBuilder: (BuildContext context, int index) {
          return buildClubCard(index);
        },
      ),
    );
  }

  Widget buildClubCard(int index) {
    final clubName = clubNames[index];
    final clubDescription = "Description of Club ${index + 1}";
    final imageUrl = "res/images/demo1.png";

    return Container(
      margin: const EdgeInsets.fromLTRB(50, 50, 50, 50),
      width: 400,
      child: Card(
        color: Colors.grey[800],
        child: Column(
          children: [
            Container(
              width: 400,
              height: 400,
              child: Image.network(imageUrl),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              color: Colors.black,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    clubName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    clubDescription,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LearnWidget extends StatelessWidget {
  const LearnWidget({Key? key});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [Image.asset("res/images/laa.png", fit: BoxFit.fill)]);
  }
}




